//
//  ModalView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 19/12/21.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    let modalType: ModalType
    @State var textBinding: String = ""
    @State var hasFocus: Bool = false
    @State var items: [TextModel] = []
    
    @State var url: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            freewordSubview
            
            ScrollView {
                ForEach(items, id: \.id) { model in
                    HStack(spacing: 20) {
                        Image(systemName: "checkmark.square")
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.presentedAsModal = false
                                }
                            }
                        Text(model.name)
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            switch modalType {
            case .country:
                url = K.API.COUNTRY_LIST
                fetchItems(type: [CountryModel].self)
            case .mnn:
                url = K.API.MNN_LIST
                fetchItems(type: [MnnModel].self)
            case .form:
                url = K.API.FORM_LIST
                fetchItems(type: [FormModel].self)
            case .atc:
                url = K.API.ATC_LIST
                fetchItems(type: [AtcModel].self)
            }
        }
    }
    
    private var freewordSubview: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: hasFocus ? 20 : 40)
            TextField("Поиск", text: $textBinding, onEditingChanged: { isEditing in
                hasFocus = isEditing
            })
                .foregroundColor(textBinding == "" ? .gray : .primary)
                .modifier(ClearButton(text: $textBinding))
                .font(Font.system(size: 17))
                .multilineTextAlignment(.leading)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(
            HStack {
                if !hasFocus {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
            }
            .frame(height: 20)
            .foregroundColor(Color(.systemGray))
            .padding()
        )
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15).stroke(Color(.systemGray), lineWidth: 2)
        )
    }
    
    private func fetchItems<T: Codable>(type: T.Type) {
        Api.shared.fetch(of: T.self, from: url) { result in
            switch result {
            case .failure(let error):
                print("[FAILED]: " + url)
                print("\(error.localizedDescription)")
            case .success(let data):
                DispatchQueue.main.async {
//                    Files.shared.write(filename: K.Source.COATE, item: data)
//                    self.coate.data = data
                    print("[SUCCESS]: \(data)")
                    add(data)
                }
            }
        }
    }
    
    private func add(_ data: Decodable & Encodable) {
        switch modalType {
        case .country:
            if let items = data as? [CountryModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: item.country_name, fullname: item.country_fullname))
                }
            }
        case .mnn:
            if let items = data as? [MnnModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: item.mnn_name, fullname: ""))
                }
            }
        case .form:
            if let items = data as? [FormModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: item.full_name, fullname: item.description))
                }
            }
        case .atc:
            if let items = data as? [AtcModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: "\(item.atc_code) \(item.atc_name_rus)", fullname: ""))
                }
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(presentedAsModal: .constant(false), modalType: .country)
    }
}

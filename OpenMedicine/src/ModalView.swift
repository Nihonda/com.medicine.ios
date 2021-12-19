//
//  ModalView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 19/12/21.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool

    @AppStorage("country") var countryBinding: String = ""
    @AppStorage("mnn") var mnnBinding: String = ""
    @AppStorage("form") var formBinding: String = ""
    @AppStorage("atc") var atcBinding: String = ""

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
                                onClick(text: "\(model.id) - \(model.name)")
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
            loadItems()
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
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(presentedAsModal: .constant(false), modalType: .country)
    }
}

// MARK: PRIVATE FUNCTIONS
extension ModalView {
    private func countryItems() -> [CountryModel] {
        return Files.shared.read(filename: K.Source.COUNTRY) ?? []
    }
    
    private func mnnItems() -> [MnnModel] {
        return Files.shared.read(filename: K.Source.MNN) ?? []
    }
    
    private func formItems() -> [FormModel] {
        return Files.shared.read(filename: K.Source.FORM) ?? []
    }
    
    private func atcItems() -> [AtcModel] {
        return Files.shared.read(filename: K.Source.ATC) ?? []
    }
    
    private func loadItems() {
        switch modalType {
        case .country:
            if Files.shared.exists(K.Source.COUNTRY) {
                for item in countryItems() {
                    self.items.append(TextModel(id: item.id, name: item.country_name, fullname: item.country_fullname))
                }
            } else {
                url = K.API.COUNTRY_LIST
                fetchItems(type: [CountryModel].self)
            }
        case .mnn:
            if Files.shared.exists(K.Source.MNN) {
                for item in mnnItems() {
                    self.items.append(TextModel(id: item.id, name: item.mnn_name, fullname: ""))
                }
            } else {
                url = K.API.MNN_LIST
                fetchItems(type: [MnnModel].self)
            }
        case .form:
            if Files.shared.exists(K.Source.FORM) {
                for item in formItems() {
                    self.items.append(TextModel(id: item.id, name: item.full_name, fullname: item.description))
                }
            } else {
                url = K.API.FORM_LIST
                fetchItems(type: [FormModel].self)
            }
        case .atc:
            if Files.shared.exists(K.Source.ATC) {
                for item in atcItems() {
                    self.items.append(TextModel(id: item.id, name: "\(item.atc_code) \(item.atc_name_rus)", fullname: ""))
                }
            } else {
                url = K.API.ATC_LIST
                fetchItems(type: [AtcModel].self)
            }
        }
    }
    
    private func onClick(text: String) {
        switch modalType {
        case .country:
            countryBinding = text
        case .mnn:
            mnnBinding = text
        case .form:
            formBinding = text
        case .atc:
            atcBinding = text
        }
    }
    
    private func fetchItems<T: Codable>(type: T.Type) {
        Api.shared.fetch(of: T.self, from: url) { result in
            switch result {
            case .failure(let error):
                print("[FAILED]: " + url)
                print("\(error.localizedDescription)")
            case .success(let data):
                DispatchQueue.main.async {
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
                
                Files.shared.write(filename: K.Source.COUNTRY, item: items)
            }
        case .mnn:
            if let items = data as? [MnnModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: item.mnn_name, fullname: ""))
                }
                
                Files.shared.write(filename: K.Source.MNN, item: items)
            }
        case .form:
            if let items = data as? [FormModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: item.full_name, fullname: item.description))
                }
                
                Files.shared.write(filename: K.Source.FORM, item: items)
            }
        case .atc:
            if let items = data as? [AtcModel] {
                for item in items {
                    self.items.append(TextModel(id: item.id, name: "\(item.atc_code) \(item.atc_name_rus)", fullname: ""))
                }
                
                Files.shared.write(filename: K.Source.ATC, item: items)
            }
        }
    }
}

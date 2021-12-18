//
//  SearchView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 13/12/21.
//

import SwiftUI

struct SearchView: View {
    @State var items: [SearchItem] = []
    
    @State var countryBinding: String = ""
    @State var mnnBinding: String = ""
    @State var formBinding: String = ""
    @State var atcBinding: String = ""
    
    @State var countryModal: Bool = false
    @State var mnnModal: Bool = false
    @State var formModal: Bool = false
    @State var atcModal: Bool = false
    
    // variables
    private var blueColor = Color(.sRGB, red: 0, green: 0.64, blue: 1, opacity: 1)
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            totalSubview
            Spacer()
            ForEach(items, id: \.id) { item in
                item
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
            Spacer()
            Button {
                
            } label: {
                Text("ПОИСК")
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color(.systemBackground), lineWidth: 2)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 0, green: 164/255, blue: 255/255))
                    )
            }
            
            Spacer()
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            initItems()
        }
    }
    
    private var totalSubview: some View {
        HStack() {
            Text("Найдено: ")
                .font(.system(size: 30))
            Text("5300")
                .font(.system(size: 40))
                .foregroundColor(blueColor)
                .padding(.trailing, 5)
            Image("pill")
                .resizable()
                .renderingMode(.original)
                .frame(width: 36, height: 36)
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension SearchView {
    private func initItems() {
        items = [
            SearchItem(icon: "paperplane", label: "Страна производителя", modalType: .country, binding: $countryBinding, isPresented: $countryModal, handler: tapCountry),
            SearchItem(icon: "number", label: "МНН", modalType: .mnn, binding: $mnnBinding, isPresented: $mnnModal, handler: tapMNN),
            SearchItem(icon: "pills", label: "Лекарственная форма", modalType: .form, binding: $formBinding, isPresented: $formModal, handler: tapForm),
            SearchItem(icon: "eye", label: "АТХ", modalType: .atc, binding: $atcBinding, isPresented: $atcModal, handler: tapATC),
        ]
    }
    
    private func tapCountry() {
        
    }
    
    private func tapMNN() {
        
    }
    
    private func tapForm() {
        
    }
    
    private func tapATC() {
        
    }
}

enum ModalType {
    case country
    case mnn
    case form
    case atc
}

struct TextModel {
    let id: Int
    let name: String
    let fullname: String
}

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
                    .padding(.bottom, 15)
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


struct SearchItem: View {
    let id: String = UUID().uuidString
    let icon: String
    let label: String
    let modalType: ModalType
    @Binding var binding: String
    @Binding var isPresented: Bool
//    let handler: (Binding<String>) -> ()
    let handler: () -> ()
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
            TextField(label, text: $binding)
                .font(.title3)
                .lineLimit(2)
                .foregroundColor(Color.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding()
        .foregroundColor(.blue)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .strokeBorder(Color(uiColor: UIColor.systemGray3), style: StrokeStyle(lineWidth: 0.5))
        )
        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color(.systemBackground)))
        .sheet(isPresented: $isPresented) { ModalView(presentedAsModal: self.$isPresented, modalType: modalType) }
        .onTapGesture {
            handler()
            isPresented = true
        }
    }
}

struct SearchItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchItem(icon: "number", label: "Страна производителя", modalType: .country, binding: .constant("Test text"), isPresented: .constant(false)) {
        }
        .previewLayout(.sizeThatFits)
    }
}

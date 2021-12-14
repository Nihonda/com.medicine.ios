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
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(items, id: \.id) { item in
                item
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
        }
        .padding(.horizontal)
        .onAppear {
            initItems()
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
            SearchItem(icon: "paperplane", label: "Страна производителя", binding: $countryBinding, isPresented: $countryModal, handler: tapCountry),
            SearchItem(icon: "number", label: "МНН", binding: $mnnBinding, isPresented: $mnnModal, handler: tapMNN),
            SearchItem(icon: "pills", label: "Лекарственная форма", binding: $formBinding, isPresented: $formModal, handler: tapForm),
            SearchItem(icon: "eye", label: "АТХ", binding: $atcBinding, isPresented: $atcModal, handler: tapATC),
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

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    @State var textBinding: String = ""
    @State var hasFocus: Bool = false
    
    var body: some View {
        VStack {
            freewordSubview
            
            
        }
        .padding()
//        Button("dismiss") { self.presentedAsModal = false }
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
        ModalView(presentedAsModal: .constant(false))
    }
}


struct SearchItem: View {
    let id: String = UUID().uuidString
    let icon: String
    let label: String
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
        .sheet(isPresented: $isPresented) { ModalView(presentedAsModal: self.$isPresented) }
        .onTapGesture {
            handler()
            isPresented = true
        }
    }
}

struct SearchItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchItem(icon: "number", label: "Страна производителя", binding: .constant("Test text"), isPresented: .constant(false)) {
        }
        .previewLayout(.sizeThatFits)
    }
}

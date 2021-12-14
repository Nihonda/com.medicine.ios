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
            SearchItem(icon: "paperplane", label: "Страна производителя", binding: $countryBinding, handler: tapCountry),
            SearchItem(icon: "number", label: "МНН", binding: $mnnBinding, handler: tapMNN),
            SearchItem(icon: "pills", label: "Лекарственная форма", binding: $formBinding, handler: tapForm),
            SearchItem(icon: "eye", label: "АТХ", binding: $atcBinding, handler: tapATC),
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

struct SearchItem: View {
    let id: String = UUID().uuidString
    let icon: String
    let label: String
    @Binding var binding: String
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
        .onTapGesture {
            handler()
        }
    }
}

struct SearchItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchItem(icon: "number", label: "Страна производителя", binding: .constant("Test text")) {
        }
        .previewLayout(.sizeThatFits)
    }
}

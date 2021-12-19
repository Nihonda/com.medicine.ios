//
//  SearchItem.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 19/12/21.
//

import SwiftUI

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

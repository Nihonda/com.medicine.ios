//
//  SearchItem.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 19/12/21.
//

import SwiftUI

struct SearchItem: View {
    @EnvironmentObject var numberVM: NumberViewModel
    
    let id: String = UUID().uuidString
    let icon: String
    let label: String
    let modalType: ModalType
    @Binding var binding: String
    @Binding var isPresented: Bool
//    let handler: (Binding<String>) -> ()
    let handler: () -> ()
    
    @State private var frame = CGRect.zero
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: icon)
                
                ZStack(alignment: .leading) {
                    if binding.isEmpty {
                        Text(label)
                            .foregroundColor(Color.gray)
                            .zIndex(1)
                    }
                    TextEditor(text: $binding)
                }
                
                Spacer()
                
                Image(systemName: binding.isEmpty ? "chevron.right" : "delete.left")
                    .foregroundColor(binding.isEmpty ? .blue : Color(UIColor.opaqueSeparator))
                    .onTapGesture {
                        if binding.isEmpty {
                            handler()
                            isPresented = true
                        } else {
                            binding = ""
                            drop(modalType: modalType)
                        }
                    }
            }
            .padding()
            .foregroundColor(.blue)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color(uiColor: UIColor.systemGray3), style: StrokeStyle(lineWidth: 0.5))
            )
            .background(RoundedRectangle(cornerRadius: 10.0).fill(Color(.systemBackground)))
            
            Spacer()
                .frame(height: 20)
        }
        .sheet(isPresented: $isPresented) { ModalView(presentedAsModal: self.$isPresented, modalType: modalType) }
    }
}

struct SearchItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchItem(icon: "number", label: "Страна производителя", modalType: .country, binding: .constant("Test text"), isPresented: .constant(false)) {
        }
        .environmentObject(NumberViewModel())
        .previewLayout(.sizeThatFits)
    }
}

// MARK: PRIVATE FUNCTIONS
extension SearchItem {
    private func drop(modalType: ModalType) {
        switch modalType {
        case .country:            
            numberVM.params = numberVM.params.filter { $0["country[]"] == nil }
        case .mnn:
            numberVM.params = numberVM.params.filter { $0["mnn[]"] == nil }
        case .form:
            numberVM.params = numberVM.params.filter { $0["medicine_form[]"] == nil }
        case .atc:
            numberVM.params = numberVM.params.filter { $0["atc[]"] == nil }
        }
        
        numberVM.update()
    }
}

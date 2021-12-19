//
//  SearchView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 13/12/21.
//

import SwiftUI

struct SearchView: View {
    @AppStorage("country") var countryBinding: String = ""
    @AppStorage("mnn") var mnnBinding: String = ""
    @AppStorage("form") var formBinding: String = ""
    @AppStorage("atc") var atcBinding: String = ""
    
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
            
            List {
                SearchItem(icon: "paperplane", label: "Страна производителя", modalType: .country, binding: $countryBinding, isPresented: $countryModal, handler: tapCountry)
                    .listRowInsets(EdgeInsets())
                SearchItem(icon: "number", label: "МНН", modalType: .mnn, binding: $mnnBinding, isPresented: $mnnModal, handler: tapMNN)
                    .listRowInsets(EdgeInsets())
                SearchItem(icon: "pills", label: "Лекарственная форма", modalType: .form, binding: $formBinding, isPresented: $formModal, handler: tapForm)
                    .listRowInsets(EdgeInsets())
                SearchItem(icon: "eye", label: "АТХ", modalType: .atc, binding: $atcBinding, isPresented: $atcModal, handler: tapATC)
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())

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
    private func tapCountry() {
        
    }
    
    private func tapMNN() {
        
    }
    
    private func tapForm() {
        
    }
    
    private func tapATC() {
        
    }
}

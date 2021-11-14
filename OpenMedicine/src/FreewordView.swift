//
//  FreewordView.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 9/11/21.
//

import SwiftUI

struct FreewordView: View {
    @StateObject var vm = DownloadingDrugListViewModel()
    
    @State private var freewordBinding = ""
    
    var body: some View {
        VStack(spacing: 13) {
            searchSubview
            
            List {
                ForEach(vm.drugListArray) { model in
                    DrugListRow(model: model)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15).stroke(Color(.systemBackground), lineWidth: 2)
                        )
                }
                .listRowBackground(Color(.secondarySystemBackground))
            }

            Spacer()
        }
    }
    
    private var searchSubview: some View {
        HStack(spacing: 10) {
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: 40)
                TextField("Поиск", text: $freewordBinding.onChange(onFreewordChanged))
                    .disableAutocorrection(true)
                    .foregroundColor(freewordBinding == "" ? .gray : .primary)
                    .modifier(ClearButton(text: $freewordBinding))
                    .font(Font.system(size: 17))
            }
            .frame(
                width: Screen.width * 0.8,
                height: 40)
            .background(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
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
            
            Image(systemName: "character.bubble")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: Screen.width * 0.10)
        }
    }
}

struct FreewordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                FreewordView()
            }
            .navigationBarHidden(true)
        }
    }
}

extension FreewordView {
    private func onFreewordChanged(_ text: String) {
        if text.count > 3 {
            vm.downloadData("q=\(text)")
        } else if text.count == 0 {
            print("String is empty")
            vm.clear()
        }
    }
}

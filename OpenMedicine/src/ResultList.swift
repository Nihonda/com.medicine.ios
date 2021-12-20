//
//  ResultList.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 20/12/21.
//

import SwiftUI

struct ResultList: View {
    @StateObject var vm = DownloadingDrugListViewModel()
    
    @State private var freewordBinding = ""
    @State private var currentPage: Int = 0
    
    var body: some View {
        List {
            ForEach(vm.drugListModel.items.enumerated().map({ $0 }), id: \.element.id) { index, model in
                NavigationLink(
                    destination: DetailView(barcode: model.barcode)) {
                        DrugListRow(model: model, number: index)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15).stroke(Color(.systemBackground), lineWidth: 2)
                            )
                            .onAppear {
                                print(index)
                                if vm.shouldLoadData(id: index) {
                                    currentPage += 1
                                    vm.downloadData(freeword: freewordBinding, page: currentPage)
                                }
                            }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
            .listRowBackground(Color(.secondarySystemBackground))
        }
    }
}

struct ResultList_Previews: PreviewProvider {
    static var previews: some View {
        ResultList()
    }
}

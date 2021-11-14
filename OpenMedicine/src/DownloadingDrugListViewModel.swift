//
//  DownloadingDrugListViewModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 11/11/21.
//

import Foundation
import Combine

class DownloadingDrugListViewModel: ObservableObject {
    
    @Published var drugListArray: [DrugItem] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = Api.shared
    
    init(_ params: String = "") {
        dataService.downloadDrugListData(params)
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$drugListModel
            .sink { [weak self] (returnedDrugListModel) in
                self?.drugListArray = returnedDrugListModel?.items ?? []
            }
            .store(in: &cancellables)
    }
}

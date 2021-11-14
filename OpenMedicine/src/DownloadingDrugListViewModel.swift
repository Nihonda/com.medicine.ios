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
        dataService.$drugListItems
            .sink { [weak self] (returnedDrugListItems) in
                self?.drugListArray = returnedDrugListItems
            }
            .store(in: &cancellables)
    }
}

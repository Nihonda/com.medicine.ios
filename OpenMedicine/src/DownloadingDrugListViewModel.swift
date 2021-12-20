//
//  DownloadingDrugListViewModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 11/11/21.
//

import Foundation
import Combine

class DownloadingDrugListViewModel: ObservableObject {
    
//    @Published var drugListArray: [DrugItem] = []
    @Published var drugListModel: DrugListModel = DrugListModel(items: [], count: 0)
    var cancellables = Set<AnyCancellable>()
    
    let dataService = Api.shared
    
    init() {  }
    
    func downloadData(freeword q: String = "", page: Int? = nil, pageSize: Int = 20, isAppend: Bool = true) {
        var params: [String] = []
        params.append("q=\(q)")
        if let page = page {
            params.append("page=\(page)")
        }
        params.append("step=\(pageSize)")
        dataService.downloadDrugListData(params.joined(separator: "&"), isAppend: isAppend)
        addSubscribers(isAppend: isAppend)
    }
    
    func downloadData(param: [[String: String]] = [], page: Int? = nil, pageSize: Int = 20, isAppend: Bool = true) {
        var params: [String] = []
        for p in param {
            for (key, value) in p {
                params.append("\(key)=\(value)")
            }
        }
        if let page = page {
            params.append("page=\(page)")
        }
        params.append("step=\(pageSize)")
        dataService.downloadDrugListData(params.joined(separator: "&"), isAppend: isAppend)
        addSubscribers(isAppend: isAppend)
    }
    
    func addSubscribers(isAppend: Bool) {
        dataService.$drugListItems
            .sink { [weak self] (returnedDrugListItems) in
                guard let self = self else { return }
                if isAppend {
                    self.drugListModel.items.appendDistinct(contentsOf: returnedDrugListItems, where: { (lhs, rhs) -> Bool in
                        return lhs.barcode != rhs.barcode
                }) // append(contentsOf: returnedDrugListItems)
                } else {
                    self.drugListModel.items = returnedDrugListItems
                }
//                print("TOTAL LIST ITEMS: \(self.drugListModel.items.count)")
            }
            .store(in: &cancellables)
    }
    
    func clear() {
        dataService.clear()
    }
    
    func shouldLoadData(id: Int) -> Bool {
        return id == drugListModel.items.count - 1 // && dataService.drugListCount != id
    }
}

//
//  DownloadingDrugDetailViewModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 15/11/21.
//

import Foundation
import Combine

class DownloadingDrugDetailViewModel: ObservableObject {
    
    @Published var drugDetailItem: DrugDetailModel? = nil
    var cancellables = Set<AnyCancellable>()
    
    let dataService = Api.shared
    
    init() {  }
    
    func downloadData(barcode: String) {
        let barcode = "barcode=\(barcode)"
        dataService.downloadDrugDetailData(barcode: barcode)
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$drugDetailItem
            .sink { [weak self] (returnedDrugDetailItem) in
                self?.drugDetailItem = returnedDrugDetailItem
            }
            .store(in: &cancellables)
    }
    
    func clear() {
        drugDetailItem = nil
    }
}

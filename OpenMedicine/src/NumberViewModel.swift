//
//  UserViewModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 3/11/21.
//

import Foundation
import Combine

class NumberViewModel: ObservableObject {
    
    @Published var numberModel: NumberModel?
    var cancellables = Set<AnyCancellable>()
    
    let dataService = Api.shared
    
    init() {
        dataService.downloadNumberData()
        addUser()
    }
    
    func addUser() {
        dataService.$numberModel
            .sink { [weak self] (returnedNumberModel) in
                self?.numberModel = returnedNumberModel
            }
            .store(in: &cancellables)
    }
}

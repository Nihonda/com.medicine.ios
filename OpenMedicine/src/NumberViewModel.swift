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
    @Published var params: [[String: String]] = []
    
    var cancellables = Set<AnyCancellable>()
    
    let dataService = Api.shared
    
    init() {
        addUser()
    }
    
    func addUser() {
        dataService.$numberModel
            .sink { [weak self] (returnedNumberModel) in
                self?.numberModel = returnedNumberModel
            }
            .store(in: &cancellables)
    }
    
    func update(with params: [[String: String]]) {
        dataService.downloadNumberData(param: params)
    }
    
    func update() {
        dataService.downloadNumberData(param: params)
    }
}

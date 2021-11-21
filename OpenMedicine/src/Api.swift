//
//  Api.swift
//  Api
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import Foundation
import Combine

class Api {
    static let shared = Api()
    
    @Published var numberModel: NumberModel = NumberModel(numOf: NumberCount(count: 0))
    @Published var drugListItems: [DrugItem] = [DrugItem]()
    @Published var drugListCount: Int = 0
    @Published var drugDetailItem: DrugDetailModel? = nil
    @Published var drugPlaceList: [DrugPlaceModel] = [DrugPlaceModel]()
    
    var numberSubscription: AnyCancellable?
    var drugListSubscription: AnyCancellable?
    var drugDetailSubscription: AnyCancellable?
    var drugPlaceSubscription: AnyCancellable?
    
    private init() {} // avoid creating object
    
    // GENERIC FUNCTION
    typealias ResultBlock<T> = (Result <T, Error>) -> Void
    
    func fetch<T: Decodable>(of type: T.Type,
                             from str: String,
                             isPost: Bool = false,
                             completion: @escaping ResultBlock<T> ) {
        if let url = URL(string: str) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = isPost ? "POST" : "GET"
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            }
            .resume()
        }
    }
    
    // FROM https://www.youtube.com/watch?v=fmVuOu8XOvQ&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=29
    func downloadNumberData() {
        guard let url = URL(string: K.API.NUMBER_TOTAL) else { return }
        
        numberSubscription = NetworkingManager.download(url: url)
            .decode(type: NumberModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedNumberModel) in
                self?.numberModel = returnedNumberModel
                self?.numberSubscription?.cancel()
            })
    }
    
    func downloadDrugListData(_ params: String = "", isAppend: Bool = true) {
        let urlStr = [K.API.DRUG_LIST, params].joined(separator: "?").encodeUrl

        guard let url = URL(string: urlStr) else { return }
        
        drugListSubscription = NetworkingManager.download(url: url)
            .decode(type: DrugListModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDrugListModel) in
                guard let self = self else { return }
                if isAppend {
                    self.drugListItems.append(contentsOf: returnedDrugListModel.items)
                } else {
                    self.drugListItems = returnedDrugListModel.items
                    self.drugListCount = returnedDrugListModel.items.count
                }
                self.drugListSubscription?.cancel()
            })
    }
    
    func clear() {
        drugListItems = []
    }
    
    func downloadDrugDetailData(barcode: String) {
        let urlStr = [K.API.DRUG_DETAIL, barcode].joined(separator: "?").encodeUrl

        guard let url = URL(string: urlStr) else { return }
        
        drugDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: DrugDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDrugDetailModel) in
                self?.drugDetailItem = returnedDrugDetailModel
                self?.drugDetailSubscription?.cancel()
            })
    }
    
    func downloadDrugPlaceData(lat: Double, long: Double, dist: Double) {
        let params = ["lat=\(lat)", "long=\(long)", "dis=\(dist)"].joined(separator: "&")
        let urlStr = "\(K.API.PLACE_LIST)?\(params)"
        guard let url = URL(string: urlStr) else { return }
        drugPlaceSubscription = NetworkingManager.download(url: url)
            .decode(type: [DrugPlaceModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedPlaceList) in
                self?.drugPlaceList = returnedPlaceList
                self?.drugPlaceSubscription?.cancel()
            })
    }
}

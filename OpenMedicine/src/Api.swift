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
    var cancellables = Set<AnyCancellable>()
    
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
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: NumberModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (returnedNumberModel) in
                self?.numberModel = returnedNumberModel
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
}

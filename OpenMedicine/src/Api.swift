//
//  Api.swift
//  Api
//
//  Created by Nurlan Nihonda on 6/9/21.
//

import Foundation

class Api {
    static let shared = Api()
    
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
}

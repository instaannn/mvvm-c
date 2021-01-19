//
//  NetworkService.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import Foundation

// MARK: - NetworkService

final class NetworkService: INetworkService {
    
    // MARK: - Public methods
    
    func fetchProducts(completion: @escaping(Result<ProductsModel, Error>) -> Void) {
        downloadJson(url: Url.apiV1Products, completion: completion)
    }
    
    func fetchProductCard(for id: Int, completion: @escaping (Result<ProductCardModel, Error>) -> Void) {
        downloadJson(url: "\(Url.apiV1Products)/\(id)", completion: completion)
    }
    
    
    // MARK: - Private methods
    
    private func downloadJson<T: Decodable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                print(object)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

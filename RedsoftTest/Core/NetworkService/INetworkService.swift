//
//  INetworkService.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

//MARK: - INetworkService

protocol INetworkService {
    func fetchProducts(completion: @escaping (Result<ProductsModel, Error>) -> Void)
    func fetchProductCard(for id: Int, completion: @escaping (Result<ProductCardModel, Error>) -> Void)
}

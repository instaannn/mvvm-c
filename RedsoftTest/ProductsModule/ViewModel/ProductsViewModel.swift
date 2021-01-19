//
//  ProductsViewModel.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import Foundation

// MARK: - ProductsViewModel

final class ProductsViewModel: IProductsViewModel {
    
    // MARK: - Public properties
    
    var productsDidChange: ((ProductsModel) -> ())?
    
    // MARK: - Private properties
    
    private var networkService: INetworkService
    
    // MARK: - Init
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    // MARK: Public methods
    
    func didWillappear() {
        fetchProducts()
    }
    
    // MARK: - Private methods
    
    private func fetchProducts() {
        networkService.fetchProducts { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.productsDidChange?(data)
                }
            }
        }
    }
    
}

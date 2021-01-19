//
//  ProductCardViewModel.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 15.01.2021.
//

import Foundation

// MARK: - ProductCardViewModel

final class ProductCardViewModel: IProductCardViewModel {
    
    // MARK: - Public properties
    
    var productCardDidChange: ((ProductCardModel) -> ())?
    var id: Int?
    
    // MARK: - Private properties
    
    private var networkService: INetworkService?
    
    // MARK: - Init
    
    init(networkService: INetworkService, id: Int) {
        self.networkService = networkService
        self.id = id
    }
    
    func didWillappear() {
        fetchProductCard()
    }
    
    // MARK: - Private methods
    
    private func fetchProductCard() {
        guard let id = id else { return }
        networkService?.fetchProductCard(for: id, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.productCardDidChange?(data)
                }
            }
        })
    }
    
}

//
//  Builder.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 18.01.2021.
//

import Foundation

// MARK: Builder

final class Builder: IBuilder {
    
    // MARK: Public methods
    
    static func makeProductsViewController(coordinator: IProductsCoordinator) -> ProductsViewController {
        let viewController = ProductsViewController()
        let networkService = NetworkService()
        let viewModel = ProductsViewModel(networkService: networkService)
        
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    static func makeProductCardViewController(id: Int) -> ProductCardViewController {
        let viewController = ProductCardViewController()
        let networkService = NetworkService()
        let viewModel = ProductCardViewModel(networkService: networkService, id: id)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
}

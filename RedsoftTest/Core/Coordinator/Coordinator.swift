//
//  Coordinator.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import UIKit

// MARK: - Coordinator

final class Coordinator: ICoordinator {
    
    // MARK: - Public properties
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() {
        goToProductsViewController()
    }
    
    // MARK: - Private methods
    
    private func goToProductsViewController() {
        let viewController = Builder.makeProductsViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private IProductsCoordinator

extension Coordinator: IProductsCoordinator {
    
    func goToProductCardViewController(id: Int) {
        let viewController = Builder.makeProductCardViewController(id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

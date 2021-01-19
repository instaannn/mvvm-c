//
//  IBuilder.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 18.01.2021.
//

import Foundation

//MARK: - IBuilder

protocol IBuilder {
    static func makeProductsViewController(coordinator: IProductsCoordinator) -> ProductsViewController
    static func makeProductCardViewController(id: Int) -> ProductCardViewController
}

//
//  IProductsViewModel.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

// MARK: - IProductsViewModel

protocol IProductsViewModel: AnyObject {
    var productsDidChange: ((ProductsModel) -> ())? { get set }
    func didWillappear()
}

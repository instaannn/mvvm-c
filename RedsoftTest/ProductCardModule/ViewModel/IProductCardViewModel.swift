//
//  IProductCardViewModel.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 15.01.2021.
//

// MARK: - IProductCardViewModel

protocol IProductCardViewModel: class {
    var productCardDidChange: ((ProductCardModel) -> ())? { get set }
    func didWillappear()
}

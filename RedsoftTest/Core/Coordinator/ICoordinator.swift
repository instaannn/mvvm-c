//
//  ICoordinator.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import UIKit

// MARK: - ICoordinator

protocol ICoordinator {
    var navigationController: UINavigationController { get }
    func start()
}

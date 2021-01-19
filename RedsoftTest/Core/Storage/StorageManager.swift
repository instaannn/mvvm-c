//
//  StorageManager.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 18.01.2021.
//

import Foundation

// MARK: StorageManager

final class StorageManager {
    
    // MARK: Public properties
    
    static let shared = StorageManager()
    
    // MARK: Public properties

    func save(value: String?, for key: String) {
        UserDefaults.standard.set(value ?? Constants.defaultsValue, forKey: key)
    }
    
    func load(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
}

//MARK: - Constants

extension StorageManager {
    enum Constants {
        static let defaultsValue: String = ""
    }
}

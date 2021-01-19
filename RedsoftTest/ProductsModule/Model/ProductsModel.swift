//
//  ProductsModel.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

// MARK: - ProductsModel

struct ProductsModel: Decodable {
    let data: [Detail]
}

// MARK: - Detail

struct Detail: Decodable {
    let id: Int
    let title: String
    let imageUrl: String
    let amount: Int
    let price: Double
    let producer: String
    let categories: [Categories]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image_url"
        case amount
        case price
        case producer
        case categories
    }
}

// MARK: - Categories

struct Categories: Decodable {
    let title: String
}

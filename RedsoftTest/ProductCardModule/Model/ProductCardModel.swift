//
//  ProductCardModel.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 15.01.2021.
//

// MARK: - ProductsModel

struct ProductCardModel: Decodable {
    let data: ProductCardDetail
}

// MARK: - ProductCardDetail

struct ProductCardDetail: Decodable {
    let title: String
    let shortDescription: String
    let imageUrl: String
    let amount: Int
    let price: Double
    let producer: String
    let categories: [ProductCardCategories]
    
    enum CodingKeys: String, CodingKey {
        case title
        case shortDescription = "short_description"
        case imageUrl = "image_url"
        case amount
        case price
        case producer
        case categories
    }
}

// MARK: - ProductCardCategories

struct ProductCardCategories: Decodable {
    let title: String
}

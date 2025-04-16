//
//  ProductsResponse.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
        case rating
    }
}

extension Product {
    static var empty: Product {
        .init(
            id: 0,
            title: "",
            price: 0.0,
            description: "",
            category: .electronics,
            image: "",
            rating: .init(rate: 0.0, count: 0),
            isFavorite: false
        )
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

// MARK: - Category
enum Category: String, Codable, CaseIterable {
    case mensClothing = "men's clothing"
    case womensClothing = "women's clothing"
    case jewelery = "jewelery"
    case electronics = "electronics"
    case none = "All products"
}

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

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

// MARK: - Category
enum Category: String, Codable {
    case mensClothing = "men's clothing"
    case womensClothing = "women's clothing"
    case jewelery = "jewelery"
    case electronics = "electronics"
}

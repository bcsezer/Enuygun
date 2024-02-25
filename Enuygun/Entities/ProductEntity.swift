//
//  ProductEntity.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import Foundation

struct ProductEntity: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

struct Product: Codable {
    let id, price, stock: Int?
    let title, description, brand, category, thumbnail: String?
    let discountPercentage, rating: Double?
    let images: [String]?
}

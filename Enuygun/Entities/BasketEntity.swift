//
//  BasketEntity.swift
//  Enuygun
//
//  Created by cem sezeroglu on 26.02.2024.
//

import Foundation

struct BasketEntity: Codable {
    let id: Int
    let name: String
    var price: Int
    let image: String
    var count: Int
}

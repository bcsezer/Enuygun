//
//  FavoritesRepository.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import Foundation

struct FavoritesRepository {
    static var shared = FavoritesRepository()
    
    let defaults = UserDefaults.standard
    var favorites: [Product] = []
    
    // MARK: Add Product
    mutating func addProduct(_ product: Product?, completion: (Bool)->()) {
        guard let product = product else { return }
        var favorites = getProduct()
        
        favorites?.append(
            Product(id: product.id,
                    price: product.price,
                    stock: product.stock,
                    title: product.title,
                    description: product.description,
                    brand: product.brand,
                    category: product.category,
                    thumbnail: product.thumbnail,
                    discountPercentage: product.discountPercentage,
                    rating: product.rating,
                    images: product.images
                   )
        )
        
        do {
            try defaults.setObj(favorites, forKey: Keys.key)
            completion(true)
        } catch {
            completion(false)
            print(error.localizedDescription)
        }
        defaults.synchronize()
    }
    
    // MARK: Get Product
    mutating func getProduct() -> [Product]? {
        do {
            favorites = try defaults.getObj(forKey: Keys.key, castTo: [Product].self)
        } catch {
            print(error.localizedDescription)
        }
        
        defaults.synchronize()
        return favorites
    }
    
    mutating func checkProductIsInFavorites(_ product: Product?) -> Bool {
        guard let product = product else { return false }
        
        let products = getProduct()
        
        return products?.contains(where: {$0.id == product.id }) ?? true
    }
    
    // MARK: Delete
    mutating func delete(id: Int) {
        
        var products = getProduct()
        
        products?.removeAll(where: { $0.id == id })
        
        do {
            try defaults.setObj(products, forKey: Keys.key)
        } catch {
            print(error.localizedDescription)
        }
        
        defaults.synchronize()
    }
}


//
//  BasketRepository.swift
//  Enuygun
//
//  Created by cem sezeroglu on 26.02.2024.
//

import Foundation
import UIKit

struct BasketRepository {
    static var shared = BasketRepository()
    
    let defaults = UserDefaults.standard
    var basketEntity: [BasketEntity] = []
    
    //Arttırma fonksiyonu
    mutating func increaseAmount(selectedProductId: Int) {
        
        var basket = getProducts()
        
        var productCount = basket?.first(where: {$0.id == selectedProductId})?.count ?? 0
        let initialPrice = defaults.object(forKey: "InitialPrice") as? Int ?? 0
        
        productCount += 1

        let firstPrice = CGFloat(initialPrice)
        let lastPrice = (firstPrice * CGFloat(productCount))
        
        if let index = basket?.firstIndex(where: {$0.id == selectedProductId}) {
            basket?[index].price = Int(lastPrice)
            basket?[index].count = productCount
        }
        
        updateList(basket: basket ?? [])
    }
    
    //Azaltma Fonksiyonu
    mutating func decreaseAmount(selectedProductId: Int) {
        
        var basket = getProducts()
        
        let productPrice = basket?.first(where: {$0.id == selectedProductId})?.price
        var productCount = basket?.first(where: {$0.id == selectedProductId})?.count ?? 0
        let initialPrice = defaults.object(forKey: "InitialPrice") as? Int ?? 0
        
        productCount -= 1
        
        if productCount >= 1 {
            let lastPrice = (productPrice ?? 0) - initialPrice
            
            if let index = basket?.firstIndex(where: {$0.id == selectedProductId}) {
                basket?[index].price = lastPrice
                basket?[index].count = productCount
            }
        }
        
        updateList(basket: basket ?? [])
    }
    
    mutating func checkProductIsInBasket(_ product: Product?) -> Bool {
        guard
            let product = product
            else {
                return false
        }
        
        let basket = getProducts()
        
        return basket?.contains(where: {$0.id == product.id }) ?? false
    }
    
    // Add Fonksiyonu
    mutating func addProduct(_ product: Product?) {
        guard
            let product = product
        else {
            return
        }
        
        var basket = getProducts()
        let defaultCount = 1
        
        basket?.append(
            BasketEntity(
                id: product.id ?? 0,
                name: product.title ?? "",
                price: product.price ?? 0,
                image: product.thumbnail ?? "",
                count: defaultCount
            )
        )
        
        do {
            defaults.setValue(product.price, forKey: "InitialPrice")
            try defaults.setObj(basket, forKey: Keys.addBasket)
        } catch {
            print(error.localizedDescription)
        }
        
        defaults.synchronize()
    }
    
    // Get Fonksiyonu
    mutating func getProducts() -> [BasketEntity]? {
        
        do {
            basketEntity = try defaults.getObj(forKey: Keys.addBasket, castTo: [BasketEntity].self)
        } catch {
            print(error.localizedDescription)
        }
        
        defaults.synchronize()
        
        return basketEntity
    }
    
    //Remove Fonsksiyonu
    
    mutating func delete(id: Int) {
        
        var basket = getProducts()
        
        basket?.removeAll(where: { $0.id == id })
        
        do {
            try defaults.setObj(basket, forKey: Keys.addBasket)
        } catch {
            print(error.localizedDescription)
        }
        
        defaults.synchronize()
    }
    
    // Update Fonksiyonu
    mutating func updateList(basket: [BasketEntity]) {
        do {
            try defaults.setObj(basket, forKey: Keys.addBasket)
        } catch {
            print(error.localizedDescription)
        }
        defaults.synchronize()
    }
}

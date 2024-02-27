//
//  ProductDetailInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailBusinessLogic {
    func handle(request: ProductDetail.GetData.Request)
    func handle(request: ProductDetail.TapFavorite.Request)
    func handle(request: ProductDetail.AddToBasket.Request)
}

class ProductDetailInteractor: ProductDetailBusinessLogic {
    var presenter: ProductDetailPresentationLogic?
    var product: Product?
    
    // MARK: Business Logic
    
    func handle(request: ProductDetail.GetData.Request) {
        guard let product = self.product else { return }
        presenter?.present(response: ProductDetail.GetData.Response(product: product, hasFav: FavoritesRepository.shared.checkProductIsInFavorites(product)))
    }
    
    func handle(request: ProductDetail.TapFavorite.Request) {
        guard let product = self.product else { return }
        let hasInFavs = FavoritesRepository.shared.checkProductIsInFavorites(product)
        
        if !hasInFavs {
            FavoritesRepository.shared.addProduct(product, completion: { result in
                if result {
                    self.presenter?.present(response: ProductDetail.TapFavorite.Response(hasFav: false))
                }
            })
        } else {
            presenter?.present(response: ProductDetail.TapFavorite.Response(hasFav: true))
        }
    }
    
    func handle(request: ProductDetail.AddToBasket.Request) {
        guard let product = self.product else { return }
        
        if BasketRepository.shared.checkProductIsInBasket(product) {
            presenter?.present(response: ProductDetail.AddToBasket.Response(isItemAdded: true))
        } else {
            BasketRepository.shared.addProduct(product)
            presenter?.present(response: ProductDetail.AddToBasket.Response(isItemAdded: false))
        }
    }
}

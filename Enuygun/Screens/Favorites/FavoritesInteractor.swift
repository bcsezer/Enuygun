//
//  FavoritesInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesBusinessLogic {
    func handle(request: Favorites.GetData.Request)
    func handle(request: Favorites.AddToBasket.Request)
}

class FavoritesInteractor: FavoritesBusinessLogic {
    var presenter: FavoritesPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Favorites.GetData.Request) {
        let response = Favorites.GetData.Response(products: FavoritesRepository.shared.getProduct() ?? [])
        presenter?.present(response: response)
    }
    
    func handle(request: Favorites.AddToBasket.Request) {
        if BasketRepository.shared.checkProductIsInBasket(request.product) {
            presenter?.present(response: Favorites.Error.Response())
        } else {
            BasketRepository.shared.addProduct(request.product)
            presenter?.present(response: Favorites.AddToBasket.Response())
        }
    }
}

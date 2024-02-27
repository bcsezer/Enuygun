//
//  FavoritesPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesPresentationLogic {
    func present(response: Favorites.GetData.Response)
    func present(response: Favorites.AddToBasket.Response)
    func present(response: Favorites.Error.Response)
}

class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Favorites.GetData.Response) {
        var cells: [Favorites.Rows] = []
        
        for product in response.products {
            cells.append(.favorites(
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
            ))
        }
        
        viewController?.display(viewModel: Favorites.GetData.ViewModel(cells: cells))
    }
    
    func present(response: Favorites.AddToBasket.Response) {
        let type : PopupType = .success(text: "Seçilen ürün sepete eklendi.")
        viewController?.display(viewModel: Favorites.AddToBasket.ViewModel(popupType: type))
    }
    
    func present(response: Favorites.Error.Response) {
        let type : PopupType = .error(text: "Seçilen ürün eklenemedi")
        viewController?.display(viewModel: Favorites.Error.ViewModel(popupType: type))
    }
}

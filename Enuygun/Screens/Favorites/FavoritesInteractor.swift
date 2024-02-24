//
//  FavoritesInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesBusinessLogic {
    func handle(request: Favorites.Something.Request)
}

class FavoritesInteractor: FavoritesBusinessLogic {
    var presenter: FavoritesPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Favorites.Something.Request) {
        let response = Favorites.Something.Response()
        presenter?.present(response: response)
    }
}

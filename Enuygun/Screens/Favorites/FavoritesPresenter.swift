//
//  FavoritesPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesPresentationLogic {
    func present(response: Favorites.Something.Response)
}

class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Favorites.Something.Response) {
        let viewModel = Favorites.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}

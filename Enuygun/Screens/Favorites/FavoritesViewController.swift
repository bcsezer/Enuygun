//
//  FavoritesViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func display(viewModel: Favorites.Something.ViewModel)
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic)?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Favorites.Something.Request()
        interactor?.handle(request: request)
    }

    // MARK: Requests

    func display(viewModel: Favorites.Something.ViewModel) {
    
    }
}

//
//  FavoritesRouter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesRoutingLogic {
    func routeToDetail(product: Product)
}

class FavoritesRouter: NSObject, FavoritesRoutingLogic {
    weak var viewController: FavoritesViewController?

    // MARK: Routing Logic
    
    func routeToDetail(product: Product) {
        let detailVC = ViewControllerFactory.shared.makeProductDetail(product: product)
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

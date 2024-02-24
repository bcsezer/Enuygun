//
//  ProductDetailRouter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailRoutingLogic {
    func routeToSomeWhere()
}

class ProductDetailRouter: NSObject, ProductDetailRoutingLogic {
    weak var viewController: ProductDetailViewController?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}

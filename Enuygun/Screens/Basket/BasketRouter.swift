//
//  BasketRouter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketRoutingLogic {
    func routeToSomeWhere()
}

class BasketRouter: NSObject, BasketRoutingLogic {
    weak var viewController: BasketViewController?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}

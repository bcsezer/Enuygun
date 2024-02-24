//
//  HomeRouter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
    func routeToSomeWhere()
}

class HomeRouter: NSObject, HomeRoutingLogic {
    weak var viewController: HomeViewController?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}

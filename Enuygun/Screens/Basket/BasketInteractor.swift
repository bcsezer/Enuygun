//
//  BasketInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketBusinessLogic {
    func handle(request: Basket.Something.Request)
}

class BasketInteractor: BasketBusinessLogic {
    var presenter: BasketPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Basket.Something.Request) {
        let response = Basket.Something.Response()
        presenter?.present(response: response)
    }
}

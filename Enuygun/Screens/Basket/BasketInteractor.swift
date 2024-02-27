//
//  BasketInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketBusinessLogic {
    func handle(request: Basket.GetData.Request)
    func handle(request: Basket.TapRemove.Request)
    func handle(request: Basket.TapDecrease.Request)
    func handle(request: Basket.TapIncrease.Request)
}

class BasketInteractor: BasketBusinessLogic {
    var presenter: BasketPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Basket.GetData.Request) {
        let basket = BasketRepository.shared.getProducts() ?? []
        presenter?.present(response: Basket.GetData.Response(basket: basket))
    }
    
    func handle(request: Basket.TapRemove.Request) {
        BasketRepository.shared.delete(id: request.id)
        let basket = BasketRepository.shared.getProducts() ?? []
        presenter?.present(response: Basket.TapRemove.Response(index: request.index, basket: basket))
    }
    
    func handle(request: Basket.TapDecrease.Request) {
        BasketRepository.shared.decreaseAmount(selectedProductId: request.id)
        presenter?.present(response: Basket.TapDecrease.Response(index: request.index))
    }
    
    func handle(request: Basket.TapIncrease.Request) {
        BasketRepository.shared.increaseAmount(selectedProductId: request.id)
        presenter?.present(response: Basket.TapIncrease.Response(index: request.index))
    }
}

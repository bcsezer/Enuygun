//
//  BasketPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketPresentationLogic {
    func present(response: Basket.Something.Response)
}

class BasketPresenter: BasketPresentationLogic {
    weak var viewController: BasketDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Basket.Something.Response) {
        let viewModel = Basket.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}

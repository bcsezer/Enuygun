//
//  ProductDetailPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailPresentationLogic {
    func present(response: ProductDetail.Something.Response)
}

class ProductDetailPresenter: ProductDetailPresentationLogic {
    weak var viewController: ProductDetailDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: ProductDetail.Something.Response) {
        let viewModel = ProductDetail.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}

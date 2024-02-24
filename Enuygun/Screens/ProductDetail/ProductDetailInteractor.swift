//
//  ProductDetailInteractor.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailBusinessLogic {
    func handle(request: ProductDetail.Something.Request)
}

class ProductDetailInteractor: ProductDetailBusinessLogic {
    var presenter: ProductDetailPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: ProductDetail.Something.Request) {
        let response = ProductDetail.Something.Response()
        presenter?.present(response: response)
    }
}

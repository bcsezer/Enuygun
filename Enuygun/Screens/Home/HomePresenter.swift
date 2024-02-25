//
//  HomePresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func present(response: Home.GetInitial.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Home.GetInitial.Response) {
        var cells: [Home.Rows] = []
        let total = response.product.total ?? 0
        
        if (response.product.products ?? []).isEmpty {
            cells.append(.empty)
        } else {
            for product in response.product.products ?? [] {
                cells.append(.products(
                    product: Product(
                        id: product.id,
                        price: product.price,
                        stock: product.stock,
                        title: product.title,
                        description: product.description,
                        brand: product.brand,
                        category: product.category,
                        thumbnail: product.thumbnail,
                        discountPercentage: product.discountPercentage,
                        rating: product.rating,
                        images: product.images
                    )))
            }
        }
        
        viewController?.display(viewModel: Home.GetInitial.ViewModel(
            hasAnyResults: total > 0,
            totalCount: "Toplam \(total.description) adet",
            rows: cells
        )
        )
    }
}

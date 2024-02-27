//
//  BasketPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketPresentationLogic {
    func present(response: Basket.GetData.Response)
    func present(response: Basket.TapRemove.Response)
    func present(response: Basket.TapDecrease.Response)
    func present(response: Basket.TapIncrease.Response)
}

class BasketPresenter: BasketPresentationLogic {
    weak var viewController: BasketDisplayLogic?
    
    // MARK: Presentation Logic
    
    func present(response: Basket.GetData.Response) {
        
        var cell: [Basket.Rows] = []
        
        if !response.basket.isEmpty {
            for (i, basket) in response.basket.enumerated() {
                cell.append(
                    .basketCell(
                        product: Basket.BasketModel(
                            id: basket.id,
                            name: basket.name,
                            price: basket.price.string(),
                            image: basket.image,
                            index: i,
                            count: basket.count
                        )
                    )
                )
            }
            viewController?.display(viewModel: Basket.GetData.ViewModel(totalPrice: calculateTotalPrice(), cells: cell))
        } else {
            cell.append(.empty(text: "Sepet Boş"))
            viewController?.display(viewModel: Basket.GetData.ViewModel(totalPrice: "", cells: cell))
        }
    }
    
    func present(response: Basket.TapRemove.Response) {
        var totalPrice: CGFloat = 0.0
        
        response.basket.forEach { basket in
            totalPrice += CGFloat(basket.price)
        }
        
        let indexPath = IndexPath(row: response.index, section: 0)
        viewController?.display(viewModel: Basket.TapRemove.ViewModel(indexPath: indexPath, totalPrice: totalPrice.description))
    }
    
    func present(response: Basket.TapDecrease.Response) {
        let basket = BasketRepository.shared.getProducts()
        let selectedProduct = basket?[response.index]
        
        if selectedProduct?.price == 0 {
            return
        }
        
        viewController?.display(
            viewModel: Basket.TapDecrease.ViewModel(
                product: Basket.BasketModel(
                    id: selectedProduct?.id ?? 0,
                    name: selectedProduct?.name ?? "",
                    price: selectedProduct?.price.string() ?? "",
                    image: selectedProduct?.image ?? "",
                    index: response.index,
                    count: basket?.count ?? 0
                )
            )
        )
    }
    
    func present(response: Basket.TapIncrease.Response) {
        let basket = BasketRepository.shared.getProducts()
        let selectedProduct = basket?[response.index]
        
        viewController?.display(
            viewModel: Basket.TapIncrease.ViewModel(
                product: Basket.BasketModel(
                    id: selectedProduct?.id ?? 0,
                    name: selectedProduct?.name ?? "",
                    price: selectedProduct?.price.string() ?? "",
                    image: selectedProduct?.image ?? "",
                    index: response.index,
                    count: basket?.count ?? 0
                )
            )
        )
    }
    
    private func calculateTotalPrice() -> String {
        let basketEntity = BasketRepository.shared.getProducts()
        
        var totalPrice: CGFloat = 0.0
        
        basketEntity?.forEach({ basket in
            let price = basket.price
            
            totalPrice += CGFloat(price)
        })
        
        return totalPrice.description
    }
}

//
//  ProductDetailPresenter.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailPresentationLogic {
    func present(response: ProductDetail.GetData.Response)
    func present(response: ProductDetail.TapFavorite.Response)
    func present(response: ProductDetail.AddToBasket.Response)
}

class ProductDetailPresenter: ProductDetailPresentationLogic {
    weak var viewController: ProductDetailDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: ProductDetail.GetData.Response) {
        var rows: [ProductDetail.Rows] = []
        let image = response.hasFav ? UIImage(systemName: "heart.fill") ?? UIImage() : UIImage(systemName: "heart") ?? UIImage()
        
        for image in response.product.images ?? [] {
            rows.append(.imageCell(image))
        }
        
        viewController?.display(
            viewModel: ProductDetail.GetData.ViewModel(
                title: response.product.title ?? "-",
                price: response.product.price?.string() ?? "-",
                description: response.product.description ?? "-",
                discountRate: "%\(response.product.discountPercentage?.description ?? "-")",
                hasFav: image,
                rows: rows))
    }
    
    func present(response: ProductDetail.TapFavorite.Response) {
        let type: PopupType = response.hasFav ? .error(text: "Bu ürün Favorilerde Mevcut.") : .success(text: "Ürün favorilere eklendi.")
        let image = response.hasFav ?  UIImage(systemName: "heart") ?? UIImage() : UIImage(systemName: "heart.fill") ?? UIImage()
        
        viewController?.display(viewModel: ProductDetail.TapFavorite.ViewModel(popupType: type, hasFav: image))
    }
    
    func present(response: ProductDetail.AddToBasket.Response) {
        let type : PopupType = response.isItemAdded ? .error(text: "Seçilen ürün eklenemedi") : .success(text: "Seçilen ürün sepete eklendi.") 
        viewController?.display(viewModel: ProductDetail.AddToBasket.ViewModel(popupType: type))
    }
}

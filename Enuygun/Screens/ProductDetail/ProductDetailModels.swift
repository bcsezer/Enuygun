//
//  ProductDetailModels.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ProductDetail {
    
    // MARK: Use cases
    enum GetData {
        struct Request {
        }
        struct Response {
            let product: Product
            let hasFav: Bool
        }
        struct ViewModel {
            let title: String
            let price: String
            let description: String
            let discountRate: String
            let hasFav: UIImage
            let rows: [Rows]
        }
    }
    
    enum TapFavorite {
        struct Request {
        }
        struct Response {
            let hasFav: Bool
        }
        struct ViewModel {
            let popupType: PopupType
            let hasFav: UIImage
        }
    }
    
    enum AddToBasket {
        struct Request {
        }
        struct Response {
            let isItemAdded: Bool
        }
        struct ViewModel {
            let popupType: PopupType
        }
    }
    
    enum Rows {
        case imageCell(String)
        
        func identifier() -> String {
            switch self {
            case.imageCell:
                return DetailBannerCell.identifier
            }
        }
    }
}

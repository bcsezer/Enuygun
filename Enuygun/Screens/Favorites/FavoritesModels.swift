//
//  FavoritesModels.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Favorites {
    
    // MARK: Use cases
    enum GetData {
        struct Request {
        }
        struct Response {
            let products: [Product]
        }
        struct ViewModel {
            let cells: [Rows]
        }
    }

    enum AddToBasket {
        struct Request {
            let product: Product
        }
        struct Response {
        }
        struct ViewModel {
            let popupType: PopupType
        }
    }
    
    enum Error {
        struct Response {
        }
        struct ViewModel {
            let popupType: PopupType
        }
    }
    
    enum Rows {
        case favorites(Product)
        
        func identifier() -> String {
            switch self {
            case .favorites:
                return FavoritesCell.identifier
            }
        }
    }
}

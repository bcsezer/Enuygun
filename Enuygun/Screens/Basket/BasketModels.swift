//
//  BasketModels.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Basket {
    struct BasketModel {
        let id: Int
        let name: String
        let price: String
        let image: String
        let index: Int
        let count: Int
    }
    
    // MARK: Use cases
    enum GetData {
        struct Request {
        }
        struct Response {
            let basket: [BasketEntity]
        }
        struct ViewModel {
            let totalPrice: String
            let cells: [Rows]
        }
    }
    
    enum TapRemove {
        struct Request {
            let index: Int
            let id: Int
        }
        struct Response {
            let index: Int
            let basket: [BasketEntity]
        }
        struct ViewModel {
            let indexPath: IndexPath
            let totalPrice: String
        }
    }
    
    enum TapDecrease {
        struct Request {
            let id: Int
            let index: Int
        }
        struct Response {
            let index: Int
        }
        struct ViewModel {
            let product: BasketModel
        }
    }
    
    enum TapIncrease {
        struct Request {
            let id: Int
            let index: Int
        }
        struct Response {
            let index: Int
        }
        struct ViewModel {
            let product: BasketModel
        }
    }
    
    enum Rows {
        case basketCell(product: BasketModel)
        case empty(text: String)
        
        func identifier() -> String {
            switch self {
            case .basketCell:
                return BasketCell.identifier
            case .empty:
                return EmptyCell.identifier
            }
        }
    }
}

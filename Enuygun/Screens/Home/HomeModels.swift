//
//  HomeModels.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home {
    
    // MARK: Use cases
    enum GetInitial {
        struct Request {
        }
        struct Response {
            let totalCount: Int
            let product: [Product]
        }
        struct ViewModel {
            let hasAnyResults: Bool
            let totalCount: String
            let rows: [Rows]
        }
    }
    
    
    enum Search {
        struct Request {
            let text: String
        }
        struct Response {
        }
        struct ViewModel {
            let rows: [Rows]
        }
    }
    
    enum TapSort {
        struct Request {
            let sortType: SortType
        }
        struct Response {
            let product: ProductEntity
        }
        struct ViewModel {
            let rows: [Rows]
        }
    }
    
    enum SelectFilter {
        struct Request {
            let name: String
            let filterType: Filter.FilterType
        }
    }
    
    enum TapFilter {
        struct Request {
        }
        struct Response {
            let product: [Product]
        }
        struct ViewModel {
            let product: [Product]
        }
    }
    
    enum TapSearch {
        struct Request {
            let searchText: String
        }
    }
    
    enum Rows {
        case empty
        case products(product: Product)
        
        func identifier() -> String {
            switch self {
            case .empty:
                return EmptyCell.identifier
            case .products:
                return ProductCell.identifier
            }
        }
    }
}

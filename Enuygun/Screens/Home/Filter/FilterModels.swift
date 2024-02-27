//
//  FilterModels.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Filter {
    
    enum FilterType {
        case brand
        case category
        case clean
    }
    
    // MARK: Use cases
    enum GetData {
        struct Request {
            let type: FilterType
        }
        struct Response {
            let type: FilterType
            let data: [String]
        }
        struct ViewModel {
            let rows: [Rows]
        }
    }
    
    enum TapCell {
        struct Request {
            let name: String
            let type: FilterType
        }
        struct Response {
            let name: String
            let type: FilterType
        }
        struct ViewModel {
            let name: String
            let type: FilterType
        }
    }
    
    enum Rows {
        case filter(title: String, type: FilterType)
        
        func identifier() -> String {
            switch self {
            case .filter:
                return FilterCell.identifier
            }
        }
    }
}

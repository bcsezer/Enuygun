//
//  PopupType.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//

import UIKit

enum PopupType {
    case success(text: String)
    case error(text: String)
    case tryAgain(text: String)
    case custom(text: String)

    func image() -> UIImage? {
        switch self {
        case .success:
            return Images.Popup.success
        case .error:
            return Images.Popup.error
        case .tryAgain:
            return Images.Popup.retry
        case .custom:
            return nil
        }
    }
    
    func text() -> String {
        switch self {
        case .success(let text), .error(let text), .tryAgain(let text), .custom(let text):
            return text
        }
    }
    
    func title() -> String {
        switch self {
        case .success:
            return "Success"
        case .error:
            return "Error"
        case .tryAgain:
            return "Try again"
        case .custom(let text):
            return text
        }
    }
}


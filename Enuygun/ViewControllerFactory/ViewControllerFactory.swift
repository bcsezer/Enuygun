//
//  ViewControllerFactory.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//

import UIKit

struct ViewControllerFactory {
    static let shared = ViewControllerFactory()
 
    func makeMainTabBar() -> UITabBarController {
        let viewController = MainTabBarController(nibName: "MainTabBarController", bundle: nil)
        viewController.createViewControllers()
        return viewController
    }
    
    func makeHome() -> UIViewController {
        let viewController = HomeViewController(nibName: "HomeView", bundle: nil)
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
    
    func makeFavorites() -> UIViewController {
        let viewController = FavoritesViewController(nibName: "FavoritesView", bundle: nil)
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
    
    func makeBasket() -> UIViewController {
        let viewController = BasketViewController(nibName: "BasketView", bundle: nil)
        let interactor = BasketInteractor()
        let presenter = BasketPresenter()
        let router = BasketRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
    
    func makeProductDetail(product: Product) -> UIViewController {
        let viewController = ProductDetailViewController(nibName: "ProductDetailView", bundle: nil)
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.product = product
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

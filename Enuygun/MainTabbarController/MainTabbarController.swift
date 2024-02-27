//
//  MainTabbarController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        handleApperances()
    }

    func createViewControllers() {
        // MARK: 1.Ana Sayfa
        let homeImg = UIImage(systemName: "house.fill")
        let home = ViewControllerFactory.shared.makeHome()
        let tabBarItem = UITabBarItem(title: "Hesaplar", image: homeImg, selectedImage: homeImg)
        home.tabBarItem = tabBarItem
        
        // MARK: 2.Favorites
        let favoritesImage = UIImage(systemName: "heart.fill")
        let favorites = ViewControllerFactory.shared.makeFavorites()
        let tabTwoBarItem = UITabBarItem(title: "Favorites", image: favoritesImage, selectedImage: favoritesImage)
        favorites.tabBarItem = tabTwoBarItem
        
        // MARK: 2.Basket
        let basketImage = UIImage(systemName: "basket.fill")
        let basket = ViewControllerFactory.shared.makeBasket()
        let tabThreeBarItem = UITabBarItem(title: "Basket", image: basketImage, selectedImage: basketImage)
        basket.tabBarItem = tabThreeBarItem
        
        let controllers = [home, favorites, basket]
        
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }
    
    private func handleApperances() {
        if #available(iOS 13.0, *) {
            let tabAppearance = UITabBarAppearance()
            
            tabAppearance.configureWithOpaqueBackground()
            tabAppearance.backgroundImage = UIImage()
            tabAppearance.backgroundColor = UIColor.white
            
            tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
            tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.black
            
            
            tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
            tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            
            UITabBar.appearance().standardAppearance = tabAppearance
            
            if #available(iOS 15, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabAppearance
            }
            
            setNeedsStatusBarAppearanceUpdate()
            
            tabBarController?.tabBar.tintColor = .black
            tabBarController?.tabBar.barTintColor = UIColor.black
            tabBarController?.tabBar.isTranslucent = true
        } else {
            // Handle older versions prior to iOS 13.0
            tabBarController?.tabBar.tintColor = .black
            tabBarController?.tabBar.barTintColor = UIColor.black
            tabBarController?.tabBar.isTranslucent = true
        }
    }
}


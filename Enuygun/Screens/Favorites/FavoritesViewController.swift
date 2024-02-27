//
//  FavoritesViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func display(viewModel: Favorites.GetData.ViewModel)
    func display(viewModel: Favorites.AddToBasket.ViewModel)
    func display(viewModel: Favorites.Error.ViewModel)
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic)?

    @IBOutlet weak var collectionView: UICollectionView!
    private var rows: [Favorites.Rows] = []
    // MARK: View lifecycle

    private struct Constant {
        static let extraSpacesForCell: CGFloat = 24.0
        static let cellHeight: CGFloat = 200.0
        static let cellEdges: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let minimumLineSpacingForSection: CGFloat = 8.0
        static let minimumInteritemSpacingForSectionAt: CGFloat = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        FavoritesCell.registerWithNib(to: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.handle(request: Favorites.GetData.Request())
    }

    // MARK: Requests

    func display(viewModel: Favorites.GetData.ViewModel) {
        DispatchQueue.main.async {
            self.rows = viewModel.cells
            self.collectionView.reloadData()
        }
    }
    
    func display(viewModel: Favorites.AddToBasket.ViewModel) {
        let popup = CustomPopupView()
        popup.present(sender: self, type: viewModel.popupType)
    }
    
    func display(viewModel: Favorites.Error.ViewModel) {
        let popup = CustomPopupView()
        popup.present(sender: self, type: viewModel.popupType)
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = rows[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: data.identifier(), for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        
        switch row {
        case .favorites(let product):
            guard let cell = cell as? FavoritesCell else { return }
            cell.willDisplay(product: product)
            cell.delegate = self
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = rows[indexPath.row]
        
        switch row {
        case .favorites:
            return CGSize(
                width: (collectionView.frame.width - Constant.extraSpacesForCell) / 2,
                height: Constant.cellHeight
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        
        switch row {
        case .favorites(let product):
            router?.routeToDetail(product: product)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constant.cellEdges
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constant.minimumLineSpacingForSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constant.minimumInteritemSpacingForSectionAt
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func didTapAdd(selectedProduct: Product) {
        interactor?.handle(request: Favorites.AddToBasket.Request(product: selectedProduct))
    }
}

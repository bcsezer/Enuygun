//
//  ProductDetailViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 25.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailDisplayLogic: AnyObject {
    func display(viewModel: ProductDetail.GetData.ViewModel)
    func display(viewModel: ProductDetail.TapFavorite.ViewModel)
    func display(viewModel: ProductDetail.AddToBasket.ViewModel)
}

class ProductDetailViewController: UIViewController, ProductDetailDisplayLogic {
    var interactor: ProductDetailBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailRoutingLogic)?
   
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var discountView: UIView!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var addToChart: UIButton!
    @IBOutlet private weak var lastPrice: UILabel!
    @IBOutlet private weak var pagetitle: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    private var cells: [ProductDetail.Rows] = []

    private struct Constant {
        static let cellEdge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let minimumLineSpacingForSectionAt: CGFloat = 0.0
        static let minimumInteritemSpacingForSectionAt: CGFloat = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = ProductDetail.GetData.Request()
        interactor?.handle(request: request)
        DetailBannerCell.registerWithNib(to: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: Requests

    func display(viewModel: ProductDetail.GetData.ViewModel) {
        DispatchQueue.main.async {
            self.pagetitle.text = viewModel.title
            self.cells = viewModel.rows
            self.pageControl.numberOfPages = self.cells.count
            self.collectionView.reloadData()
            self.titleLabel.text = viewModel.title
            self.lastPrice.text = viewModel.price + "₺"
            self.descLabel.text = viewModel.description
            self.discountLabel.text = viewModel.discountRate
            self.favButton.setImage(viewModel.hasFav, for: .normal)
            self.apperence()
        }
    }
    
    func display(viewModel: ProductDetail.TapFavorite.ViewModel) {
        let popup = CustomPopupView()
        popup.present(sender: self, type: viewModel.popupType)
        favButton.setImage(viewModel.hasFav, for: .normal)
    }
    
    func display(viewModel: ProductDetail.AddToBasket.ViewModel) {
        let popup = CustomPopupView()
        popup.present(sender: self, type: viewModel.popupType)
    }
    
    private func apperence() {
        discountView.layer.cornerRadius = discountView.frame.size.width/2
        discountView.clipsToBounds = true
        discountView.isHidden = false
        addToChart.layer.cornerRadius = 6
        addToChart.clipsToBounds = true
    }
    
    @IBAction func tapFavorites(_ sender: Any) {
        interactor?.handle(request: ProductDetail.TapFavorite.Request())
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAddToChart(_ sender: Any) {
        interactor?.handle(request: ProductDetail.AddToBasket.Request())
    }
}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = cells[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.identifier(), for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = cells[indexPath.row]
        
        switch row {
        case .imageCell(let image):
            guard let cell = cell as? DetailBannerCell else { return }
            cell.willdisplay(image: image)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: collectionView.frame.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constant.cellEdge
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constant.minimumLineSpacingForSectionAt
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constant.minimumInteritemSpacingForSectionAt
    }
}

extension ProductDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollCount = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(scrollCount)
    }
}


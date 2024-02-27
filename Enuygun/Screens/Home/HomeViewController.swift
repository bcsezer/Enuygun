//
//  HomeViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func display(viewModel: Home.GetInitial.ViewModel)
    func display(viewModel: Home.TapFilter.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic, UITextFieldDelegate {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic)?

    @IBOutlet private weak var listedCount: UILabel!
    @IBOutlet private weak var sortButton: UIButton!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private var rows: [Home.Rows] = []
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        EmptyCell.registerWithNib(to: tableView)
        ProductCell.registerWithNib(to: tableView)
        interactor?.handle(request: Home.GetInitial.Request())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        apperence()
    }

    
    @IBAction func tapSort(_ sender: Any) {
        let heightRatio = 340 / UIScreen.main.bounds.height
        let filter = ViewControllerFactory.shared.makeSort(previousVC: self)
        
        pushModal.pushModal(
            viewController: filter,
            animated: true,
            heightRatio: heightRatio,
            isPan: false,
            navigation: self.navigationController!
        )
    }
    
    @IBAction func tapFilter(_ sender: Any) {
        interactor?.handle(request: Home.TapFilter.Request())
    }
    
    func display(viewModel: Home.TapFilter.ViewModel) {
        let heightRatio = 548 / UIScreen.main.bounds.height
        let filter = ViewControllerFactory.shared.makeFilter(product: viewModel.product, preVC: self)
        
        pushModal.pushModal(
            viewController: filter,
            animated: true,
            heightRatio: heightRatio,
            isPan: false,
            navigation: self.navigationController!
        )
    }
    
    // MARK: Requests

    func display(viewModel: Home.GetInitial.ViewModel) {
        DispatchQueue.main.async {
            self.rows = viewModel.rows
            self.tableView.reloadData()
            self.listedCount.text = viewModel.totalCount
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        if textField.text != "" {
            interactor?.handle(request: Home.Search.Request(text: textField.text ?? ""))
        }
        textField.resignFirstResponder()
        return false
    }
    
    private func apperence() {
        filterButton.layer.borderWidth = 1
        searchTextField.layer.borderWidth = 1
        sortButton.layer.borderWidth = 1
        
        filterButton.layer.borderColor = Color.lightGray.cgColor
        searchTextField.layer.borderColor = Color.lightGray.cgColor
        sortButton.layer.borderColor = Color.lightGray.cgColor
        
        filterButton.layer.cornerRadius = 6
        searchTextField.layer.cornerRadius = 6
        sortButton.layer.cornerRadius = 6
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier())
        
        switch row {
        case .products(let product):
            guard let cell = cell as? ProductCell else { return UITableViewCell() }
            cell.willDisplay(product: product)
            cell.selectionStyle = .none
            return cell
        case .empty:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        
        switch row {
        case .products(let product):
            router?.routeToDetail(product: product)
        case .empty:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = rows[indexPath.row]
        
        switch row {
        case .products:
            return 70
        case .empty:
            return tableView.bounds.height
        }
    }
}

extension HomeViewController: ProductsSortDelegate {
    func didPressSort(type: SortType) {
        interactor?.handle(request: Home.TapSort.Request(sortType: type))
    }
}

extension HomeViewController: FilterViewDelegate {
    func didTapCell(type: Filter.FilterType, name: String) {
        interactor?.handle(request: Home.SelectFilter.Request(name: name, filterType: type))
    }
}

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
}

class HomeViewController: UIViewController, HomeDisplayLogic {
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
        tableView.delegate = self
        tableView.dataSource = self
        EmptyCell.registerWithNib(to: tableView)
        ProductCell.registerWithNib(to: tableView)
        interactor?.handle(request: Home.GetInitial.Request())
    }

    // MARK: Requests

    func display(viewModel: Home.GetInitial.ViewModel) {
        DispatchQueue.main.async {
            self.rows = viewModel.rows
            self.tableView.reloadData()
            self.listedCount.text = viewModel.totalCount
            self.sortButton.isHidden = !viewModel.hasAnyResults
            self.filterButton.isHidden = !viewModel.hasAnyResults
        }
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

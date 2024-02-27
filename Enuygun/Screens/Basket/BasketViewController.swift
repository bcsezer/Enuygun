//
//  BasketViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 24.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BasketDisplayLogic: AnyObject {
    func display(viewModel: Basket.GetData.ViewModel)
    func display(viewModel: Basket.TapDecrease.ViewModel)
    func display(viewModel: Basket.TapIncrease.ViewModel)
    func display(viewModel: Basket.TapRemove.ViewModel)
}

class BasketViewController: UIViewController, BasketDisplayLogic {
    var interactor: BasketBusinessLogic?
    var router: (NSObjectProtocol & BasketRoutingLogic)?

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var rows: [Basket.Rows] = []
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        BasketCell.registerWithNib(to: tableView)
        EmptyCell.registerWithNib(to: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.handle(request: Basket.GetData.Request())
    }

    // MARK: Requests

    func display(viewModel: Basket.GetData.ViewModel) {
        DispatchQueue.main.async {
            self.totalPrice.text = viewModel.totalPrice.appending("₺")
            self.rows = viewModel.cells
            self.tableView.reloadData()
        }
    }
    
    func display(viewModel: Basket.TapDecrease.ViewModel) {
        interactor?.handle(request: Basket.GetData.Request())
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func display(viewModel: Basket.TapIncrease.ViewModel) {
        interactor?.handle(request: Basket.GetData.Request())
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func display(viewModel: Basket.TapRemove.ViewModel) {
        self.rows.remove(at: viewModel.indexPath.row)
        self.tableView.deleteRows(at: [viewModel.indexPath], with: .fade)
        self.totalPrice.text = viewModel.totalPrice.appending("₺")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier())
        
        switch row {
        case .basketCell(let product):
            guard let cell = cell as? BasketCell else { return UITableViewCell() }
            cell.willDisplay(product: product)
            cell.selectionStyle = .none
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        case .empty(let text):
            guard let cell = cell as? EmptyCell else { return UITableViewCell() }
            cell.willDisplay(text: text)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = rows[indexPath.row]
        
        switch row {
        case .basketCell:
            return 70
        case .empty:
            return tableView.frame.height
        }
    }
}

extension BasketViewController: BasketCellDelegate {
    func didPressRemove(id: Int, index: Int) {
        interactor?.handle(request: Basket.TapRemove.Request(index: index, id: id))
    }
    
    func didPressIncrease(id: Int, index: Int) {
        interactor?.handle(request: Basket.TapIncrease.Request(id: id, index: index))
    }
    
    func didPressDecrease(id: Int, index: Int) {
        interactor?.handle(request: Basket.TapDecrease.Request(id: id, index: index))
    }
}

//
//  FilterViewController.swift
//  Enuygun
//
//  Created by cem sezeroglu on 27.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func didTapCell(type: Filter.FilterType, name: String)
}
 
protocol FilterDisplayLogic: AnyObject {
    func display(viewModel: Filter.GetData.ViewModel)
    func display(viewModel: Filter.TapCell.ViewModel)
}

class FilterViewController: UIViewController, FilterDisplayLogic {
    var interactor: FilterBusinessLogic?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FilterViewDelegate?
    private var rows: [Filter.Rows] = []
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        FilterCell.registerWithNib(to: tableView)
        interactor?.handle(request: Filter.GetData.Request(type: .category))
    }

    // MARK: Requests

    func display(viewModel: Filter.GetData.ViewModel) {
        DispatchQueue.main.async {
            self.rows = viewModel.rows
            self.tableView.reloadData()
        }
    }
    
    func display(viewModel: Filter.TapCell.ViewModel) {
        self.dismiss(animated: true, completion: {
            self.delegate?.didTapCell(type: viewModel.type, name: viewModel.name)
        })
    }
    
    @IBAction func tapSegmented(_ sender: UISegmentedControl) {
        interactor?.handle(request: Filter.GetData.Request(
            type: sender.selectedSegmentIndex == 0 ? .category : .brand
        ))
    }
    
    @IBAction func tapClean(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.didTapCell(type: .clean, name: "")
        })
    }
    
    @IBAction func tapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier())
        
        switch row {
        case let .filter(title, _):
            guard let cell = cell as? FilterCell else { return UITableViewCell() }
            cell.willDisplay(name: title)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        
        switch row {
        case let .filter(name, type):
            interactor?.handle(request: Filter.TapCell.Request(name: name, type: type))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = rows[indexPath.row]
        
        switch row {
        case .filter:
            return 40
        }
    }
}

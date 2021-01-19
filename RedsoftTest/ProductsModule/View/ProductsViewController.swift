//
//  ProductsViewController.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import UIKit

// MARK: - ProductsViewController

final class ProductsViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var coordinator: IProductsCoordinator?
    public var viewModel: IProductsViewModel?
    
    // MARK: - Private properties
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    private var productsModel: ProductsModel?
    private var productsModelFilter = [Detail]()
    private var selectIdOne: Int?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVies()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func goToProductCardViewController(indexPath: Int) {
        let id = productsModelFilter[indexPath].id
        selectIdOne = id
        coordinator?.goToProductCardViewController(id: selectIdOne ?? Constants.defaultValue)
    }
}

// MARK: - Setup

extension ProductsViewController {
    
    private func setupVies() {
        addVies()
        
        setupTableView()
        setupSearchBar()
        
        tableViewLayout()
    }
    
    private func setupBinding() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.didWillappear()
        
        viewModel.productsDidChange = { [weak self] viewModel in
            guard let self = self else { return }
            self.productsModel = viewModel
            guard let productsModelData = self.productsModel?.data else { return }
            self.productsModelFilter = productsModelData
            self.tableView.reloadData()
        }
    }
}

// MARK: - Setup Elements

extension ProductsViewController {
    
    private func addVies() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.register(ProductsViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = NSLocalizedString(
            Constants.searchBarPlaceholder,
            comment: Constants.searchBarPlaceholderComment)
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.isTranslucent = false
    }
}

// MARK: - UITableViewDelegate

extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRowAt
    }
}

// MARK: - UITableViewDataSource

extension ProductsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsModelFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdentifier,
                for: indexPath) as? ProductsViewCell else { return UITableViewCell() }
        
        let products = productsModelFilter[indexPath.row]
        cell.contentView.isUserInteractionEnabled = false
        
        cell.set(products: products)
        
        if cell.amount > Constants.indexZero {
            cell.stepperView.isHidden = false
            cell.shoppingСart.isHidden = true
        } else {
            cell.stepperView.isHidden = true
            cell.shoppingСart.isHidden = false
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToProductCardViewController(indexPath: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate

extension ProductsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        guard let productsModelData = self.productsModel?.data else { return }
        productsModelFilter = productsModelData
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let products = productsModel?.data else { return }
        
        productsModelFilter = textSearched.isEmpty ? products : products.filter({ (model) -> Bool in
            return model.title.range(of: textSearched,
                                     options: .caseInsensitive,
                                     range: nil,
                                     locale: nil) != nil
        })
        tableView.reloadData()
    }
}

// MARK: - Layout

extension ProductsViewController {
    
    private func tableViewLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
             tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
}

// MARK: - Constants

extension ProductsViewController {
    
    enum Constants {
        static let cellIdentifier: String = "ProductsCell"
        static let searchBarPlaceholder: String = "Я ищу..."
        static let searchBarPlaceholderComment: String = " Search..."
        static let defaultValue: Int = 0
        static let heightForRowAt: CGFloat = 150
        static let indexZero: Int = 0
    }
    
}

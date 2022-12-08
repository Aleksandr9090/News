//
//  CategoriesViewController.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit

protocol CategoriesViewInputProtocol: AnyObject {
    func setCategories(categoriesViewModel: CategoriesViewModel)
}

protocol CategoriesViewOutputProtocol {
    func viewDidLoad()
    func didTapCell(with category: String)
    func favoriteButtonPressed()
}

public final class CategoriesViewController: UIViewController {
    
    var presenter: CategoriesViewOutputProtocol?
    
    private let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    private let configurator: CategoriesConfiguratorInputProtocol = CategoriesConfigurator()
    
    private var categories: [String] = []
    
    // MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(withView: self)
        presenter?.viewDidLoad()
        
        setupTableView()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - PrivateMethods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        title = "Сategories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Favorite",
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func favoriteButtonTapped() {
        presenter?.favoriteButtonPressed()
    }
}

// MARK: - TableViewDelegate
extension CategoriesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapCell(with: categories[safe: indexPath.row] ?? "all")
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        }
    }
}

// MARK: - TableViewDataSource
extension CategoriesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = categories[safe: indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - CategoriesViewInputProtocol
extension CategoriesViewController: CategoriesViewInputProtocol {
    func setCategories(categoriesViewModel: CategoriesViewModel) {
        self.categories = categoriesViewModel.categories
        tableView.reloadData()
    }
}

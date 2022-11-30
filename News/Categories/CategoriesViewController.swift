//
//  CategoriesViewController.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit

protocol CategoriesViewInputProtocol: AnyObject {
    func setCategories(categories: [String])
}

protocol CategoriesViewOutputProtocol {
    func viewDidLoad()
    func didTapCell(with category: String)
    func favoriteButtonPressed()
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)

    var presenter: CategoriesViewOutputProtocol?
    private let configurator: CategoriesConfiguratorInputProtocol = CategoriesConfigurator()
    
    private var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(withView: self)
        presenter?.viewDidLoad()
        
        setupTableView()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapCell(with: categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        }
    }

    
    // MARK: - Private methods
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

// MARK: - CategoriesViewInputProtocol
extension CategoriesViewController: CategoriesViewInputProtocol {
    func setCategories(categories: [String]) {
        self.categories = categories
        tableView.reloadData()
    }
}

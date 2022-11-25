//
//  CategoriesViewController.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit

protocol CategoriesViewInputProtocol: AnyObject {
    func setCategories()
}

protocol CategoriesViewOutputProtocol {
    init (view: CategoriesViewInputProtocol)
    func didTapCell()
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: CategoriesViewOutputProtocol!
    //    private let configurator: CategoriesConfiguratorInputProtocol = CategoriesConfigurator()
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    private let categories = DataManager.shared.category
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        view.backgroundColor = .white
        setupNavigationBar()
        //        configurator.configure(withView: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newslineVC = NewslineViewController()
        newslineVC.categoryUrl = "https://inshortsapi.vercel.app/news?category=\(categories[indexPath.row])"
        navigationController?.pushViewController(newslineVC, animated: true)
    }
    
    // MARK: - Privar methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        title = "News Сategories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Favorite News",
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func favoriteButtonTapped() {
        let favoriteListVC = FavoriteListViewController()
        navigationController?.pushViewController(favoriteListVC, animated: true)
    }
    
}

// MARK: - CategoriesViewInputProtocol
extension CategoriesViewController: CategoriesViewInputProtocol {
    func setCategories() {
        
    }
}



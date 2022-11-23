//
//  CategoriesViewController.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit

protocol CategoriesViewInputProtocol: AnyObject {
    func displayCategories(with categories: [String])
}

protocol CategoriesViewOutputProtocol {
    init(view: CategoriesViewInputProtocol)
    func didTapCell(at indexPath: IndexPath)
    func viewDidLoad()
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)

    var presenter: CategoriesViewOutputProtocol!
    
    private let configurator: CategoriesConfiguratorInputProtocol = CategoriesConfigurator()
    
    private var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(withView: self)
        presenter.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
        setupNavigationBar()

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
        
        cell.textLabel?.text = categories[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newslineVC = NewslineViewController()
        newslineVC.categoryUrl = "https://inshortsapi.vercel.app/news?category=\(categories[indexPath.row])"
        navigationController?.pushViewController(newslineVC, animated: true)
    }
    
    // MARK: - Privat methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        title = "News Сategories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
}

// MARK: - CategoriesViewInputProtocol
extension CategoriesViewController: CategoriesViewInputProtocol {
    func displayCategories(with categories: [String]) {
        self.categories = categories
        tableView.reloadData()
    }
}



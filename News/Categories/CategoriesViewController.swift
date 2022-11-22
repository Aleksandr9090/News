//
//  CategoriesViewController.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit
import Alamofire

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
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//       super.viewWillTransition(to: size, with: coordinator)
//       coordinator.animate(alongsideTransition: { (contex) in
//          self.updateLayout(with: size)
//       }, completion: nil)
//    }
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
        newslineVC.categoryUrl = "https://inshortsapi.vercel.app/news?category=all"
        navigationController?.pushViewController(newslineVC, animated: true)
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//    private func updateLayout(with size: CGSize) {
//       self.tableView.frame = CGRect.init(origin: .zero, size: size)
//    }
    
    private func setupNavigationBar() {
        title = "News Сategories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
//    private func setupRefreshControl() {
//        refreshControl = UIRefreshControl()
//        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
//    }
    
    @objc func downloadData() {
       
    }


}

// MARK: - CategoriesViewInputProtocol
extension CategoriesViewController: CategoriesViewInputProtocol {
    func setCategories() {
        
    }
    
    
}



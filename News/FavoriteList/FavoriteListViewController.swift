//
//  FavoriteListViewController.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import UIKit

protocol FavoriteViewControllerDelegate {
    func reloadData()
}

class FavoriteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        
    var news: [FavoriteNews] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        view.backgroundColor = .white
        setupTableView()
        title = "Favorite News"
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
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteNewsCell.identifier,
                                                       for: indexPath) as? FavoriteNewsCell else {
                                                            return UITableViewCell()
                                                        }
        
        let oneNews = news[indexPath.row]
        cell.configureCell(with: oneNews)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = news[indexPath.row]
        let favoriteNewsVC = FavoriteNewsViewController()
        favoriteNewsVC.favoriteNews = news
        favoriteNewsVC.delegate = self
        navigationController?.pushViewController(favoriteNewsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.1,
            options: .curveEaseIn
        ) {
            cell.transform = CGAffineTransform(
                translationX: cell.contentView.frame.width,
                y: cell.contentView.frame.height
            )
        }
    }
    
// MARK: - Private Methods
    private func setupTableView() {
        tableView.rowHeight = 115
        view.addSubview(tableView)
        tableView.register(FavoriteNewsCell.self, forCellReuseIdentifier: FavoriteNewsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let newsArray):
                self.news = newsArray
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension FavoriteListViewController: FavoriteViewControllerDelegate{
    func reloadData() {
        getData()
        tableView.reloadData()
    }
}

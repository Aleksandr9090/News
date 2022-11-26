//
//  FavoriteListViewController.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import UIKit

import UIKit

protocol FavoriteViewControllerDelegate {
    func reloadData()
}

class FavoriteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        
    var news: [FavoriteNews] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        view.backgroundColor = .white
        setupTableView()
        title = "Favorite News"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }

// MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier,
                                                       for: indexPath) as? NewsCell else {
                                                            return UITableViewCell()
                                                        }
        let news = news[indexPath.row]
        
        cell.configure(title: news.title, date: news.date, imageUrl: news.imageUrl)
        
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
    
    private func setupTableView() {
        tableView.rowHeight = 115
        view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData() {
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

// MARK: - Networking
extension NewslineViewController {
    private func fetchNews(from url: String) {
        NetworkManager.shared.fetchData(from: url) { NewsPage in
            self.news = NewsPage.data ?? []
            self.tableView.reloadData()
        }
        
    }
}

extension FavoriteListViewController: FavoriteViewControllerDelegate{
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
    
    
}

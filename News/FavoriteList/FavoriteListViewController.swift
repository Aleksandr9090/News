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
    
    private var sectionViewModel: FavoriteNewsSectionViewModelProtocol = FavoriteNewsSectionViewModel()

        
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

// MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteNewsCell",
                                                       for: indexPath) as? FavoriteNewsCell else {
                                                            return UITableViewCell()
                                                        }
        
//        cell.viewModel =
        
//        let news = news[indexPath.row]
//        cell.configure(title: news.title, date: news.date, imageUrl: news.imageUrl)
        
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
        tableView.register(NewsCell.self, forCellReuseIdentifier: "newsCell")
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

extension FavoriteListViewController: FavoriteViewControllerDelegate{
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}

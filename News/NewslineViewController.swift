//
//  NewslineTableViewController.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import UIKit

class NewslineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    var categoryUrl: String = "https://inshortsapi.vercel.app/news?category=all"
    
//    private var newsPage: NewsPage?
    var news: [News] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        title = "News"
        
        fetchNews(from: categoryUrl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

// MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewslineCell.identifier,
                                                       for: indexPath) as? NewslineCell else {
                                                            return UITableViewCell()
                                                        }
        let news = news[indexPath.row]
        
        cell.configure(with: news)
        
        return cell
    }

    
    private func setupTableView() {
        tableView.rowHeight = 115 
        view.addSubview(tableView)
        tableView.register(NewslineCell.self, forCellReuseIdentifier: NewslineCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - Networking
extension NewslineViewController {
    private func fetchNews(from url: String) {
//        let activityIndicator = showSpinner(in: tableView)
        NetworkManager.shared.fetchData(from: url) { NewsPage in
            self.news = NewsPage.data ?? []
            self.tableView.reloadData()
//            activityIndicator.stopAnimating()
        }
        
    }
//    func fetchNews() {
//        NetworkManager.shared.fetch(dataType: [News].self, from: categoryUrl) { result in
//            switch result {
//            case .success(let news):
//                self.news = news
////                self.newsCategory = newsCategory
//                self.tableView.reloadData()
//                print(news)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

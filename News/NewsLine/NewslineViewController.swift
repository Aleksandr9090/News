//
//  NewslineTableViewController.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import UIKit
protocol NewslineViewInputProtocol: AnyObject {
    func display(newsline: [News])
}

protocol NewslineViewOutputProtocol {
    init(view: NewslineViewInputProtocol)
    func showNewsline()
}

class NewslineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    var categoryUrl: String!
    
    var news: [News] = []
    
    
    var presenter: NewslineViewOutputProtocol!
    
    private let configurator: NewslineConfiguratorInputProtocol = NewslineConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self, and: categoryUrl)
        presenter.showNewsline()
        
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
        let selectedNewsVC = SelectedNewsViewController()
        selectedNewsVC.news = news
        navigationController?.pushViewController(selectedNewsVC, animated: true)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 115
        view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
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

extension NewslineViewController: NewslineViewInputProtocol {
    func display(newsline: [News]) {
        self.news = newsline
        self.tableView.reloadData()
    }
    
    
}

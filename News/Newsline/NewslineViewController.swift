//
//  NewslineTableViewController.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import UIKit

protocol NewslineViewInputProtocol: AnyObject {
    func reloadData(for section: NewslineSectionViewModel)
}

protocol NewslineViewOutputProtocol {
    init(view: NewslineViewInputProtocol)
    func viewDidLoad()
//    func didTapCell(at indexPath: IndexPath)
}

class NewslineViewController: UIViewController, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    var category: String!
    var presenter: NewslineViewOutputProtocol!
    
//    var news: [News] = []
    private var sectionViewModel: NewslineSectionViewModelProtocol = NewslineSectionViewModel()
    private let configurator: NewslineConfiguratorInputProtocol = NewslineConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self, and: category)
        presenter.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        title = "News"
        
//        fetchNews(from: categoryUrl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

// MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdetifier,
                                                       for: indexPath) as? NewslineCell else {
                                                            return UITableViewCell()
                                                        }
        cell.viewModel = cellViewModel
        return cell
    }
    

}
// MARK: - UITableViewDelegate
extension NewslineViewController: UITableViewDelegate {
    private func setupTableView() {
//        tableView.rowHeight = 115
        view.addSubview(tableView)
        tableView.register(NewslineCell.self, forCellReuseIdentifier: NewslineCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(sectionViewModel.rows[indexPath.row].cellHeight)
    }
}



// MARK: - Networking
//extension NewslineViewController {
//    private func fetchNews(from url: String) {
//        NetworkManager.shared.fetchData(from: url) { NewsPage in
//            self.news = NewsPage.data ?? []
//            self.tableView.reloadData()
//        }
//
//    }
//}

// MARK: - Newsline View Input Protocol
extension NewslineViewController: NewslineViewInputProtocol {
    func reloadData(for section: NewslineSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
    }
    
    
}

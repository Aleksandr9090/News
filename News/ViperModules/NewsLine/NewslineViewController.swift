//
//  NewslineTableViewController.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import UIKit
import SnapKit

protocol NewslineViewInputProtocol: AnyObject {
    func reloadData(for section: NewsSectionViewModel)
}

protocol NewslineViewOutputProtocol {
    func showNewsline()
    func didTapCell(at indexPath: IndexPath)
}

class NewslineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    var categoryUrl: String?
    
    private var sectionViewModel: NewsSectionViewModelProtocol = NewsSectionViewModel()
    
    var presenter: NewslineViewOutputProtocol?
    
    private let configurator: NewslineConfiguratorInputProtocol = NewslineConfigurator()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.showNewsline()
        
        view.backgroundColor = .white
        setupTableView()
        title = "News"
        layoutActivityIndicator()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier,
                                                       for: indexPath) as? NewsCell else {
                                                            return UITableViewCell()
                                                        }
        
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.005 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(sectionViewModel.rows[indexPath.row].cellHeight)
    }
    // MARK: - Private Methods
    private func setupTableView() {
        view.addSubview(tableView)
        // надо пофиксить
        tableView.register(NewsCell.self, forCellReuseIdentifier: "newsCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
}

extension NewslineViewController: NewslineViewInputProtocol {
    func reloadData(for section: NewsSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

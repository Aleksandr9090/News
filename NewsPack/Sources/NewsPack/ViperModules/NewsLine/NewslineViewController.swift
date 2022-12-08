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

final class NewslineViewController: UIViewController {
    
    var categoryUrl: String?
    var presenter: NewslineViewOutputProtocol?
    
    private let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    private var sectionViewModel: NewsSectionViewModelProtocol = NewsSectionViewModel()
    private let configurator: NewslineConfiguratorInputProtocol = NewslineConfigurator()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.showNewsline()
        
        configure()
        setupTableView()
        layoutActivityIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - PrivateMethods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCellViewModel.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configure() {
        view.backgroundColor = .white
        title = "News"
    }
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
}

// MARK: - TableViewDelegate
extension NewslineViewController: UITableViewDelegate {
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
        CGFloat(sectionViewModel.rows[safe: indexPath.row]?.cellHeight ?? 100)
    }
}

// MARK: - TableViewDataSource
extension NewslineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellViewModel.cellIdentifier,
                                                       for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        let cellViewModel = sectionViewModel.rows[safe: indexPath.row]
        cell.viewModel = cellViewModel
        return cell
    }
}

extension NewslineViewController: NewslineViewInputProtocol {
    func reloadData(for section: NewsSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

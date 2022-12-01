//
//  NewslinePresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct NewslineData {
    let news: [News]?
}

class NewslinePresenter: NewslineViewOutputProtocol {
    weak var view: NewslineViewInputProtocol?
    
    private let interactor: NewslineInteractorInputProtocol
    private let router: NewslineRouterInputProtocol
    private let categoryUrl: String
    
    private var newslineData: NewslineData?
    
    init(
        interactor: NewslineInteractorInputProtocol,
        router: NewslineRouterInputProtocol,
        categoryUrl: String
    ) {
        self.interactor = interactor
        self.router = router
        self.categoryUrl = categoryUrl
    }
    
    func showNewsline() {
        interactor.fetchNewsline(with: categoryUrl)
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let oneNews = newslineData?.news?[safe: indexPath.row] else { return }
        router.openSelectedNewsViewController(with: oneNews)
    }
    
}

// MARK: - NewslineInteractorOutputProtocol
extension NewslinePresenter: NewslineInteractorOutputProtocol {
    func newslineDidRecive(with newslineData: NewslineData?) {
        self.newslineData = newslineData
        let section = NewsSectionViewModel()
        newslineData?.news?.forEach { news in
            let newsCellViewModel = NewsCellViewModel(news: news)
            section.rows.append(newsCellViewModel)
            view?.reloadData(for: section)
        }
    }
}

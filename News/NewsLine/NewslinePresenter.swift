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
    
    private var newslineData: NewslineData?
    
    init(interactor: NewslineInteractorInputProtocol, router: NewslineRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func showNewsline() {
        interactor.fetchNewsline()
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

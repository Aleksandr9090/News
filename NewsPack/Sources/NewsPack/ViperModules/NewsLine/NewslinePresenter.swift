//
//  NewslinePresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct NewslineViewModel {
    let news: [News]?
}

final class NewslinePresenter {
    weak var view: NewslineViewInputProtocol?
    
    private let interactor: NewslineInteractorInputProtocol
    private let router: NewslineRouterInputProtocol
    private let categoryUrl: String
    
    private var newslineViewModel: NewslineViewModel?
    
    init(
        interactor: NewslineInteractorInputProtocol,
        router: NewslineRouterInputProtocol,
        categoryUrl: String
    ) {
        self.interactor = interactor
        self.router = router
        self.categoryUrl = categoryUrl
    }
}

// MARK: - NewslineInteractorOutputProtocol
extension NewslinePresenter: NewslineViewOutputProtocol {
    func showNewsline() {
        interactor.fetchNewsline(with: categoryUrl)
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let oneNews = newslineViewModel?.news?[safe: indexPath.row] else { return }
        router.openSelectedNewsViewController(with: oneNews)
    }
}

// MARK: - NewslineInteractorOutputProtocol
extension NewslinePresenter: NewslineInteractorOutputProtocol {
    func newslineDidRecive(with newslineViewModel: NewslineViewModel?) {
        self.newslineViewModel = newslineViewModel
        let section = NewsSectionViewModel()
        
        newslineViewModel?.news?.forEach { news in
            let newsCellViewModel = NewsCellViewModel(news: news)
            section.rows.append(newsCellViewModel)
            view?.reloadData(for: section)
        }
    }
}

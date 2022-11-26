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
    unowned private let view: NewslineViewInputProtocol
    
    var interactor: NewslineInteractorInputProtocol!
    var router: NewslineRouterInputProtocol!
    
    private var newslineData: NewslineData?
    
    required init(view: NewslineViewInputProtocol) {
        self.view = view
    }
    
    func showNewsline() {
        interactor.fetchNewsline()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let oneNews = newslineData?.news?[indexPath.row] else { return }
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
            view.reloadData(for: section)
        }
    }
}

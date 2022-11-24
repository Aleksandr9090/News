//
//  NewslinePresenter.swift
//  News
//
//  Created by Aleksandr on 22.11.2022.
//

import Foundation

struct NewslineData {
//    let category: String
//    let newsArray: [News]
    let newsPage: NewsPage
}

class NewslinePresenter: NewslineViewOutputProtocol {
    
    private var dataStore: NewslineData?
    
    unowned private let view: NewslineViewInputProtocol
    var interactor: NewslineInteractorInputProtocol!
    
    required init(view: NewslineViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchNews()
    }
    
    
}

// MARK: - CourseDetailsInteractorOutputProtocol

extension NewslinePresenter: NewslineInteractorOutputProtocol {
    func receiveCourseDetails(with newslineData: NewslineData) {
        self.dataStore = newslineData
        let section = NewslineSectionViewModel()
        dataStore?.newsPage.data?.forEach { section.rows.append(NewslineCellViewModel(news: $0)) }
        view.reloadData(for: section)
    }

}

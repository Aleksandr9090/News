//
//  NewslinePresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct NewslineData {
    let news: [News]

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
    
}

// MARK: - NewslineInteractorOutputProtocol

extension NewslinePresenter: NewslineInteractorOutputProtocol {
    func newslineDidRecive(with newsLineData: NewslineData) {
        
    }
}

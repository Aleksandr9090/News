//
//  NewslineInteractor.swift
//  News
//
//  Created by Aleksandr on 22.11.2022.
//

import Foundation

protocol NewslineInteractorInputProtocol {
    init(presenter: NewslineInteractorOutputProtocol, category: String)
    func fetchNews()
}

protocol NewslineInteractorOutputProtocol: AnyObject {
    func receiveCourseDetails(with newslineData: NewslineData)
}

class NewslineInteractor: NewslineInteractorInputProtocol {
    unowned private let presenter: NewslineInteractorOutputProtocol
    private let category: String
    
    required init(presenter: NewslineInteractorOutputProtocol, category: String) {
        self.presenter = presenter
        self.category = category
    }
    
    func fetchNews() {
        NetworkManager.shared.fetchData(from: category) { [unowned self]  newsPage in
            let newslineData = NewslineData(newsPage: newsPage)
            presenter.receiveCourseDetails(with: newslineData)
        }
        
        
    }
    
    
    
}

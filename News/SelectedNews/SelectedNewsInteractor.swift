//
//  SelectedNewsInteractor.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol SelectedNewsInteractorInputProtocol {
    init(presenter: SelectedNewsInteractorOutputProtocol, news: News)
    func provideSelectedNews()
    func saveSelectedNews()
}

protocol SelectedNewsInteractorOutputProtocol: AnyObject {
    func receiveSelectedNews(with selectedNewsData: SelectedNewsData)
}

class SelectedNewsInteractor: SelectedNewsInteractorInputProtocol {
    
    unowned private let presenter: SelectedNewsInteractorOutputProtocol
    private let news: News
    
    required init(presenter: SelectedNewsInteractorOutputProtocol, news: News) {
        self.presenter = presenter
        self.news = news
    }
    
    func saveSelectedNews() {
        StorageManager.shared.save(news: news)
    }
    
    func provideSelectedNews() {
        let imageData = ImageManager.shared.fetchImageData(from: news.imageUrl)
        let selectedNewsData = SelectedNewsData(
            title: news.title,
            content: news.content,
            imageData: imageData,
            author: news.author
        )
        presenter.receiveSelectedNews(with: selectedNewsData)
    }
    
}

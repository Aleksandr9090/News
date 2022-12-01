//
//  SelectedNewsPresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct SelectedNewsData {
    let title: String?
    let content: String?
    let imageData: Data?
    let author: String?
}

class SelectedNewsPresenter: SelectedNewsViewOutputProtocol {
    weak var view: SelectedNewsViewInputProtocol?
    
    private let interactor: SelectedNewsInteractorInputProtocol
    private var selectedNewsData: SelectedNewsData?
    private let news: News
    
    init(interactor: SelectedNewsInteractorInputProtocol, news: News) {
        self.interactor = interactor
        self.news = news
    }
    
    func showNews() {
        interactor.provideImageData(imageUrl: news.imageUrl)
    }
    
    func saveNewsButtonPressed() {
        interactor.saveSelectedNews(news: news)
    }
}

// MARK: - SelectedNewsInteractorOutputProtocol
extension SelectedNewsPresenter: SelectedNewsInteractorOutputProtocol {
    func receiveSelectedNewsData(with imageData: Data?) {
        view?.displayNewsName(with: news.title ?? "")
        view?.displayNewsContent(with: news.content ?? "")
        view?.displayNewsAuthor(with: news.author ?? "")
        guard let imageData = imageData else { return }
        view?.displayImage(with: imageData)
    }
}

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
    unowned private let view: SelectedNewsViewInputProtocol
    
    var interactor: SelectedNewsInteractorInputProtocol!
    var router: SelectedNewsRouterInputProtocol!
    
    private var selectedNewsData: SelectedNewsData?
    
    required init(view: SelectedNewsViewInputProtocol) {
        self.view = view
    }
    
    func showNews() {
        interactor.provideSelectedNews()
    }
    
    func saveNewsButtonPressed() {
        interactor.saveSelectedNews()
    }
    
//    func readMoreButtonPressed() {
//        guard let readMoreUrl = selectedNewsData?.readMoreUrl else { return }
//        print(readMoreUrl)
//        router.openNewsWebViewController(with: readMoreUrl)
//    }
}

// MARK: - SelectedNewsInteractorOutputProtocol

extension SelectedNewsPresenter: SelectedNewsInteractorOutputProtocol {
    func receiveSelectedNews(with selectedNewsData: SelectedNewsData) {
        view.displayNewsName(with: selectedNewsData.title ?? "")
        view.displayNewsContent(with: selectedNewsData.content ?? "")
        view.displayNewsAuthor(with: selectedNewsData.author ?? "")
        guard let imageData = selectedNewsData.imageData else { return }
        view.displayImage(with: imageData)
    }
}

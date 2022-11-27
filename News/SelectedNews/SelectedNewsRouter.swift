//
//  SelectedNewsRouter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol SelectedNewsRouterInputProtocol {
    init(viewController: SelectedNewsViewController)
    func openNewsWebViewController(with readMoreUrl: String)
}

class SelectedNewsRouter: SelectedNewsRouterInputProtocol {
    unowned private let viewController: SelectedNewsViewController
    
    required init(viewController: SelectedNewsViewController) {
        self.viewController = viewController
    }
    
    func openNewsWebViewController(with readMoreUrl: String) {
        let newsWebVC = NewsWebViewController()
        newsWebVC.newsUrl = readMoreUrl
        print(readMoreUrl)
        viewController.navigationController?.pushViewController(newsWebVC, animated: true)
    }
}

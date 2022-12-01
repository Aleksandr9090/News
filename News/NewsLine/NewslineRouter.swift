//
//  NewslineRouter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol NewslineRouterInputProtocol {
    func openSelectedNewsViewController(with news: News)
}

class NewslineRouter: NewslineRouterInputProtocol {
    weak var viewController: NewslineViewController?
    
    func openSelectedNewsViewController(with news: News) {
        let selectedNewsVC = SelectedNewsViewController()
        let selectedNewsConfigurator: SelectedNewsConfiguratorInputProtocol = SelectedNewsConfigurator()
        selectedNewsConfigurator.configure(with: selectedNewsVC, and: news)
        viewController?.navigationController?.pushViewController(selectedNewsVC, animated: true)
    }
}

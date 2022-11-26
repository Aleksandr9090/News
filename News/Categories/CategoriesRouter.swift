//
//  CategoriesRouter.swift
//  News
//
//  Created by Aleksandr on 26.11.2022.
//

import Foundation

protocol CategoriesRouterInputProtocol {
    init(viewController: CategoriesViewController)
    func openNewslineViewController(with categoryUrl: String)
    func openFavoriteListViewController()
}

class CategoriesRouter: CategoriesRouterInputProtocol {
    unowned private let viewController: CategoriesViewController
    
    required init(viewController: CategoriesViewController) {
        self.viewController = viewController
    }
    
    func openFavoriteListViewController() {
        let favoriteListVC = FavoriteListViewController()
        viewController.navigationController?.pushViewController(favoriteListVC, animated: true)
    }

    func openNewslineViewController(with categoryUrl: String) {
        let newslineVC = NewslineViewController()
        let newslineConfigurator: NewslineConfiguratorInputProtocol = NewslineConfigurator()
        newslineConfigurator.configure(with: newslineVC, and: categoryUrl)
        print(categoryUrl)
        viewController.navigationController?.pushViewController(newslineVC, animated: true)
    }
}

//
//  CategoriesRouter.swift
//  News
//
//  Created by Aleksandr on 26.11.2022.
//

protocol CategoriesRouterInputProtocol {
    func openNewslineViewController(with categoryUrl: String)
    func openFavoriteListViewController()
}

final class CategoriesRouter: CategoriesRouterInputProtocol {
    weak var viewController: CategoriesViewController?
    
    func openFavoriteListViewController() {
        let favoriteListVC = FavoriteListViewController()
        viewController?.navigationController?.pushViewController(favoriteListVC, animated: true)
    }

    func openNewslineViewController(with categoryUrl: String) {
        let newslineVC = NewslineViewController()
        let newslineConfigurator: NewslineConfiguratorInputProtocol = NewslineConfigurator()
        newslineConfigurator.configure(with: newslineVC, and: categoryUrl)
        print(categoryUrl)
        viewController?.navigationController?.pushViewController(newslineVC, animated: true)
    }
}

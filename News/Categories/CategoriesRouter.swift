//
//  CategoriesRouter.swift
//  News
//
//  Created by Aleksandr on 22.11.2022.
//

import Foundation

protocol CategoriesRouterInputProtocol {
    init(viewController: CategoriesViewController)
    func openNewslineViewController(with categoryUrl: String)
}

class CategoriesRouter: CategoriesRouterInputProtocol {
    unowned private let viewController: CategoriesViewController
    
    required init(viewController: CategoriesViewController) {
        self.viewController = viewController
    }
    
    func openNewslineViewController(with categoryUrl: String) {
        let newslineVC = NewslineViewController()
        newslineVC.categoryUrl = "https://inshortsapi.vercel.app/news?category=\(categoryUrl)"
        viewController.navigationController?.pushViewController(newslineVC, animated: true)
    }
    
    
}

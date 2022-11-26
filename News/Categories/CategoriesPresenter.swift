//
//  CategoriesPresenter.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation
struct CategoriesData {
    let categories: [String]
}

class CategoriesPresenter: CategoriesViewOutputProtocol {
    unowned private let view: CategoriesViewInputProtocol
    var interactor: CategoriesInteractorInputProtocol!
    var router: CategoriesRouterInputProtocol!
    
    private var categoriesData: CategoriesData?
    
    required init(view: CategoriesViewInputProtocol) {
        self.view = view
    }
    
    func favoriteButtonPressed() {
        router.openFavoriteListViewController()
    }
    
    func didTapCell(with category: String) {
        let categoryUrl = "https://inshortsapi.vercel.app/news?category=\(category)"
        router.openNewslineViewController(with: categoryUrl)
    }
    
    func viewDidLoad() {
        interactor.getCategories()
    }
    
}

// MARK: - CategoriesInteractorOutputProtocol
extension CategoriesPresenter: CategoriesInteractorOutputProtocol {
    func receiveCategoriesData(_ categoriesData: CategoriesData) {
        view.setCategories(categories: categoriesData.categories)
    }
}

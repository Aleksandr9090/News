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
    weak var view: CategoriesViewInputProtocol?
    
    private let interactor: CategoriesInteractorInputProtocol
    private let router: CategoriesRouterInputProtocol
    
    private var categoriesData: CategoriesData?
    
    init(interactor: CategoriesInteractorInputProtocol, router: CategoriesRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
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
        view?.setCategories(categories: categoriesData.categories)
    }
}

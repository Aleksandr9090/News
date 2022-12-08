//
//  CategoriesPresenter.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

struct CategoriesViewModel {
    let categories: [String]
}

final class CategoriesPresenter {
    weak var view: CategoriesViewInputProtocol?
    
    private let interactor: CategoriesInteractorInputProtocol
    private let router: CategoriesRouterInputProtocol
        
    init(
        interactor: CategoriesInteractorInputProtocol,
        router: CategoriesRouterInputProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - CategoriesInteractorOutputProtocol
extension CategoriesPresenter: CategoriesViewOutputProtocol {
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
    func receiveCategories(_ categories: [String]) {
        let categoriesViewModel = CategoriesViewModel(categories: categories)
        view?.setCategories(categoriesViewModel: categoriesViewModel)
    }
}

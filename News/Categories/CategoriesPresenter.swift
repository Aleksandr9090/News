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
    
    func didTapCell(at indexPath: IndexPath) {
        guard let category = categoriesData?.categories[indexPath.row] else { return }
        router.openNewslineViewController(with: category)

    }
    
    func viewDidLoad() {
        interactor.getCategories()
    }
    
}

// MARK: - CategoriesInteractorOutputProtocol
extension CategoriesPresenter: CategoriesInteractorOutputProtocol {
    func receiveCategoriesData(with categoriesData: CategoriesData) {
        view.displayCategories(with: categoriesData.categories)
        
    }
}

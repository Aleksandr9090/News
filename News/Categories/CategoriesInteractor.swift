//
//  CategoriesInteractor.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

protocol  CategoriesInteractorInputProtocol {
    init(presenter: CategoriesInteractorOutputProtocol)
    func getCategories()
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    func receiveCategoriesData(with categoriesData: CategoriesData)
}

class CategoriesInteractor: CategoriesInteractorInputProtocol {
    unowned private let presenter: CategoriesInteractorOutputProtocol
    
    required init(presenter: CategoriesInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
//    func provideCategoriesData() {
//        let categoriesData = DataManager.shared.category
//        presenter.receiveCategoriesData(with: categoriesData)
//    }
    
    func getCategories() {
        let categoriesData = CategoriesData(categories: DataManager.shared.category)
        presenter.receiveCategoriesData(with: categoriesData)
    }
    
}

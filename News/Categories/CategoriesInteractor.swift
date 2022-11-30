//
//  CategoriesInteractor.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

protocol  CategoriesInteractorInputProtocol: AnyObject {
    func getCategories()
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    func receiveCategoriesData(_ categories: CategoriesData)
}

class CategoriesInteractor: CategoriesInteractorInputProtocol {
    weak var presenter: CategoriesInteractorOutputProtocol?
    
    func getCategories() {
        let categoriesData = CategoriesData(categories: DataManager.shared.category)
        self.presenter?.receiveCategoriesData(categoriesData)
    }
    
    
}

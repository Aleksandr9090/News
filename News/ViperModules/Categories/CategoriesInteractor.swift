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
    func receiveCategoriesViewModel(_ categoriesViewModel: CategoriesViewModel)
}

class CategoriesInteractor: CategoriesInteractorInputProtocol {
    weak var presenter: CategoriesInteractorOutputProtocol?
    
    func getCategories() {
        let categoriesData = CategoriesViewModel(categories: DataManager.shared.category)
        self.presenter?.receiveCategoriesViewModel(categoriesData)
    }
    
    
}

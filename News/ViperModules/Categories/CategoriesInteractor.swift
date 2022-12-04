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
    func receiveCategories(_ categories: [String])
}

class CategoriesInteractor: CategoriesInteractorInputProtocol {
    weak var presenter: CategoriesInteractorOutputProtocol?
    
    func getCategories() {
        self.presenter?.receiveCategories(DataManager.shared.category)
    }
}

//
//  CategoriesInteractor.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

protocol  CategoriesInteractorInputProtocol: AnyObject {
    func getCategories()
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    func categoriesDidReceive(_ categories: [String])
}

final class CategoriesInteractor: CategoriesInteractorInputProtocol {
    weak var presenter: CategoriesInteractorOutputProtocol?
    
    func getCategories() {
        self.presenter?.categoriesDidReceive(DataManager.shared.category)
    }
}

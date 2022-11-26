//
//  Model.swift
//  News
//
//  Created by Aleksandr on 26.11.2022.
//

import CoreData
import Foundation

// from backend
struct Model: Decodable {
    
    let id: String
}


final class SomeClass {
    
    let news: [Model] = []
    // let networkManager = ...
    func getData() {
        
        /*
         networkManager.getNews { news ([Model]) in
            self.news = news
            self.tableView.reloadData()
         }
         */
        
    }
    
//    func addToFavorites(model: Model) {
//        StorageManager.shared.fetchData { result in
//            switch result {
//            case let .success(news):
//                if news.contains { $0.id == model.id } {
//                    // show alert already added
//                } else {
//                    // create new CoreData object
//                }
//            case .failure(_):
//                
//            }
//        }
//    }
}

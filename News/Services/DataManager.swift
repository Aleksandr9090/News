//
//  DataManager.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

struct DataManager {
    static let shared = DataManager()
    
    let category = [
        "all", "business", "sports", "world", "politics", "technology",
        "startup", "entertainment", "miscellaneous", "science", "automobile"
    ]
    
//    let category = Category.allCases.map { $0.rawValue }
   
    private init() {}
}

//enum Category: String, CaseIterable {
//    case all = "All"
//    case business = "Business"
//    case sports = "Sport"
//    case world = "World"
//    case politics = "Politics"
//    case technology = "Technology"
//    case startup = "Start up"
//    case entertainment = "Entertainment"
//    case miscellaneous = "Miscellaneous"
//    case science = "Science"
//    case automobile = "Automobile"
//}

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
       
    private init() {}
}

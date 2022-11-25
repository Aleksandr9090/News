//
//  StorageManager.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation
import CoreData
import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private let viewContext: NSManagedObjectContext
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    
    func fetchData(completion: (Result<[FavoriteNews], Error>) -> Void) {
        let fetchRequest = FavoriteNews.fetchRequest()
        do {
            let favoriteNewsArray = try viewContext.fetch(fetchRequest)
            completion(.success(favoriteNewsArray))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func save(news: News) {
        let favoriteNews = FavoriteNews(context: viewContext)
        
        favoriteNews.readMoreUrl = news.readMoreUrl
        favoriteNews.author = news.author
        favoriteNews.content = news.content
        favoriteNews.title = news.title
        favoriteNews.imageUrl = news.imageUrl
        favoriteNews.date = news.date
        
        saveContext()
    }
    
    func delete(_ favoriteNews: FavoriteNews) {
        viewContext.delete(favoriteNews)
        saveContext()
    }
    
    
//    func create(_ news: News, completion: (FavoriteNews) -> Void) {
//        let favoriteNews = FavoriteNews(context: viewContext)
//
//        completion(task)
//        saveContext()
//    }
//
//    func update(_ task: Task, newName: String) {
//        task.title = newName
//        saveContext()
//    }
//
//    func delete(_ task: Task) {
//        viewContext.delete(task)
//        saveContext()
//    }
    
    
    
    
    
    

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



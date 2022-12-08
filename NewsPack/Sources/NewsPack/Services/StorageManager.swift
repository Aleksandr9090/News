//
//  StorageManager.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation
import CoreData
import UIKit

public final class StorageManager {
    
    public static let shared = StorageManager()
    
    private let viewContext: NSManagedObjectContext
    
    // MARK: - CoreDataStack
    public let persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource: "FavoriteNews", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else { return NSPersistentContainer() }
        
        let container = NSPersistentContainer(name: "FavoriteNews", managedObjectModel: model)
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
    
    // MARK: - PublicMethods
    func fetchFavoriteNews(completion: (Result<[FavoriteNews], Error>) -> Void) {
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
    
    func delete(_ favoriteNews: FavoriteNews?) {
        guard let favoriteNews = favoriteNews else { return }
        viewContext.delete(favoriteNews)
        saveContext()
    }

    // MARK: - CoreDataSavingSupport
    public func saveContext () {
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

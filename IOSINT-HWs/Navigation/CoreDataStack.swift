//
//  CoreDataStack.swift
//  Navigation
//
//  Created by Роман on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {

    private(set) lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DataModels")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func remove(likedPost: LikedPost) {
        viewContext.delete(likedPost)
        
       save(context: viewContext)
    }
    
    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchLikedPosts() -> [LikedPost] {
        let request: NSFetchRequest<LikedPost> = LikedPost.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("app crashed with: \(error.localizedDescription)")
        }
    }
    
    func createNewLikedPost(profilePost: ProfilePost) {
        let newLikedPost = LikedPost(context: viewContext)
        newLikedPost.author = profilePost.author
        newLikedPost.likes = Int32(profilePost.likes)
        newLikedPost.views = Int32(profilePost.views)
        newLikedPost.postDescription = profilePost.description
        newLikedPost.image = profilePost.image
        newLikedPost.id = UUID()
        
        save(context: viewContext)
    }
}

//
//  CoreManager.swift
//  MediaCypher-J22
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import CoreData


class CoreManager {
    
    // MARK: - Core Data stack
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MediaCypher_J22")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save(path: String, isMovie: Bool){
        let entity = NSEntityDescription.entity(forEntityName: "Content", in: context)!
        let content = Content(entity: entity, insertInto: context)
        content.isVideo = isMovie
        content.path = path
        
        saveContext()
        
        print("An Item was Saved: \(path)")
    }
    
    func load() -> [Content]{
        let fetchRequest = NSFetchRequest<Content>(entityName: "Content")
        var content = [Content]()
        do{
            content = try context.fetch(fetchRequest)
        } catch{
            print("couldn't fetch: \(error.localizedDescription)")
            
        }
        print("Content was loaded")
        return content
    }
    
    

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

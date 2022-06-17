//
//  CoreDataStack.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation
import CoreData

// MARK: CoreDataStack has been implemented
// Purpose: Saving the shorten urls received from api
class CoreDataStack {
    static let shared = CoreDataStack()
    
    var managedObjectContext: NSManagedObjectContext { get {
        return self.persistentContainer.viewContext
    }
    }
    
    // It will help in multithreading by returning the context on private queue
    var workingContext: NSManagedObjectContext { get {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.managedObjectContext
        return context
    }
    }
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "shortlyapp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        self.managedObjectContext.performAndWait {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                    print("Main context saved")
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func saveWorkingContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Working context saved")
            saveContext()
        } catch (let error) {
            print(error)
        }
    }
}

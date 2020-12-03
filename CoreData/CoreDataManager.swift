//
//  CoreDataManager.swift
//  itaxo
//
//  Created by Genuine on 19.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ItaxoTrip")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func insertUser(name: String, email : String , password: String,phone : String) -> User? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let user: User =  NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User
        user.name = name
        user.email = email
        user.password = password
        user.phone = phone
        do {
            try managedContext.save()
            return user
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    

    
    func insertRideModel(dateTime: String, lengthRide: String, fromPlace: String, toPlace: String, price: String) -> Drive? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let drive: Drive =  NSEntityDescription.insertNewObject(forEntityName: "Drive", into: managedContext) as! Drive

        drive.date = dateTime
        drive.distance = lengthRide
        drive.from = fromPlace
        drive.to = toPlace
        drive.paiment_id = price

        do {
            try managedContext.save()
            return drive
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func getRideModel() -> Drive? {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Drive")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        guard let fetch = try? context.fetch(request) as? [Drive] else { return nil }
        if !fetch.isEmpty {
            print(fetch)
            return fetch[0]
        } else {
            return nil
        }
    }
    
    func fetchUser() -> User? {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        guard let fetch = try? context.fetch(request) as? [User] else { return nil }
        if !fetch.isEmpty {
            return fetch[0]
        } else {
            return nil
        }
    }
    
    /*delete*/
    func delete(person : User){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            
            managedContext.delete(person)
            
        } catch {
            // Do something in response to error condition
            print(error)
        }
        
        do {
            try managedContext.save()
        } catch {
            // Do something in response to error condition
        }
    }
    
    func delete(object: String) -> [User]? {
        /*get reference to appdelegate file*/
        
        
        /*get reference of managed object context*/
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        /*init fetch request*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        /*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
        fetchRequest.predicate = NSPredicate(format: "" ,object)
        do {
            
            /*managedContext.fetch(fetchRequest) will return array of person objects [personObjects]*/
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedUsers = [User]()
            for i in item {
                
                /*call delete method(aManagedObjectInstance)*/
                /*here i is managed object instance*/
                managedContext.delete(i)
                
                /*finally save the contexts*/
                try managedContext.save()
                
                /*update your array also*/
                arrRemovedUsers.append(i as! User)
            }
            return arrRemovedUsers
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func search () {
        
    }
    
    
    
    
    
    
    //       func fetchAllUser() -> [User]?{
    //
    //
    //         /*Before you can do anything with Core Data, you need a managed object context. */
    //         let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    //
    //         /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
    //
    //          Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
    //          */
    //         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
    //
    //         /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
    //         do {
    //           let people = try managedContext.fetch(fetchRequest)
    //           return people as? [User]
    //         } catch let error as NSError {
    //           print("Could not fetch. \(error), \(error.userInfo)")
    //           return nil
    //         }
    //       }
    
    
    
    
    //  func update(name:String, ssn : Int16, user : User) {
    //
    //    /*1.
    //     Before you can save or retrieve anything from your Core Data store, you first need to get your hands on an NSManagedObjectContext. You can consider a managed object context as an in-memory “scratchpad” for working with managed objects.
    //     Think of saving a new managed object to Core Data as a two-step process: first, you insert a new managed object into a managed object context; then, after you’re happy with your shiny new managed object, you “commit” the changes in your managed object context to save it to disk.
    //     Xcode has already generated a managed object context as part of the new project’s template. Remember, this only happens if you check the Use Core Data checkbox at the beginning. This default managed object context lives as a property of the NSPersistentContainer in the application delegate. To access it, you first get a reference to the app delegate.
    //     */
    //    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    //
    //    do {
    //
    //
    //      /*
    //       With an NSManagedObject in hand, you set the name attribute using key-value coding. You must spell the KVC key (name in this case) exactly as it appears in your Data Model
    //       */
    //      user.setValue(name, forKey: "name")
    //      user.setValue(ssn, forKey: "ssn")
    //
    //      print("\(user.value(forKey: "name"))")
    //      print("\(user.value(forKey: "ssn"))")
    //
    //      /*
    //       You commit your changes to person and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block. Finally, insert the new managed object into the people array so it shows up when the table view reloads.
    //       */
    //      do {
    //        try context.save()
    //        print("saved!")
    //      } catch let error as NSError  {
    //        print("Could not save \(error), \(error.userInfo)")
    //      } catch {
    //
    //      }
    //
    //    } catch {
    //      print("Error with request: \(error)")
    //    }
    //  }
    //
    
}







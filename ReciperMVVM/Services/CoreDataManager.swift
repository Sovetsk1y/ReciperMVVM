//
//  CoreDataManager.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func save(name: String) {
        guard let appDelegate = appDelegate else {
            fatalError("Failed to get app delegate.")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: managedContext)!
        
        let recipe = NSManagedObject(entity: entity, insertInto: managedContext)
        
        recipe.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchRecipes() {
        guard let appDelegate = appDelegate else {
            fatalError("Failed toget app delegate")
        }
        
        var recipes = [NSManagedObject]()
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recipe")
        
        do {
            recipes = try managedContext.fetch(fetchRequest)
//            let recipe = recipes[0]
        } catch {
            print(error)
        }
    }
    
}

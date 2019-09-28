//
//  RecipeModel.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import Foundation
import CoreData

struct RecipeModel {
    var name: String
    var tags: [String]?
    var cookingTime: Int?
    var image: Data?
    var isFavourite: Bool
    
    init(managedObject: NSManagedObject) {
        name = managedObject.value(forKey: "name") as! String
        tags = managedObject.value(forKey: "tags") as? [String]
        cookingTime = managedObject.value(forKey: "cookingTime") as? Int
        image = managedObject.value(forKey: "image") as? Data
        isFavourite = managedObject.value(forKey: "isFavourite") as? Bool ?? false
    }
    
    init(name: String, tags: [String]?, cookingTime: Int?, image: Data?, isFavourite: Bool = false) {
        self.name = name
        self.tags = tags
        self.cookingTime = cookingTime
        self.image = image
        self.isFavourite = isFavourite
    }
}

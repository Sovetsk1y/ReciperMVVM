//
//  RecipeCellViewModel.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit

struct RecipeCellViewModel {
    private var recipe: RecipeModel
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
    }
    
    var recipeName: String {
        get {
            return recipe.name
        }
    }
    
    var cookingTimeText: String? {
        get {
            if let cookingTimeInMinutes = recipe.cookingTime {
                return "Время приготовления: \(cookingTimeInMinutes) мин."
            }
            return nil
        }
    }
    
    var dishImage: Data? {
        get {
            return recipe.image
        }
    }
    
    var tags: [String]? {
        get {
            return recipe.tags
        }
    }
    
    mutating func favouriteButtonColor() -> UIColor {
        if recipe.isFavourite {
            recipe.isFavourite = false
            return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        } else {
            recipe.isFavourite = true
            return #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1)
        }
    }
    
    var cellBackgroundColor: UIColor {
        get {
            return #colorLiteral(red: 1, green: 0.9921568627, blue: 0.8156862745, alpha: 1).withAlphaComponent(0.7)
        }
    }
}

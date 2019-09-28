//
//  RecipeCellViewModel.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit

struct RecipeCellViewModel {
    private let recipe: RecipeModel
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
    }
    
    var recipeName: String {
        get {
            return recipe.name
        }
    }
    
    var cookingTimeText: String {
        get {
            if let cookingTimeInSeconds = recipe.cookingTime {
                let cookingTimeInMinutes = cookingTimeInSeconds / 60
                return "Время приготовления: \(cookingTimeInMinutes)"
            }
            return "Время приготовления: 0"
        }
    }
    
    var dishImage: UIImage? {
        get {
            if let imageData = recipe.image {
                return UIImage(data: imageData)
            }
            return nil
        }
    }
    
    var tags: [String]? {
        get {
            return recipe.tags
        }
    }
    
    var recipeIsFavourite: Bool {
        get {
            return recipe.isFavourite
        }
    }
    
    var cellBackgroundColor: UIColor {
        get {
            return #colorLiteral(red: 1, green: 0.9921568627, blue: 0.8156862745, alpha: 1).withAlphaComponent(0.7)
        }
    }
}

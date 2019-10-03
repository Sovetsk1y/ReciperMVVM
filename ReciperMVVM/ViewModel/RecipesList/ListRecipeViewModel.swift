//
//  ListRecipeViewModel.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit

struct ListRecipeViewModel {
    var cellReuseIdentifier: String {
        get {
            return "recipeCell"
        }
    }
    
    var navigationBarTitle: String {
        get {
            return "Рецепты"
        }
    }
    
    var cellHeight: CGFloat {
        get {
            return CGFloat(70)
        }
    }
    
    var viewBackgroundColor: UIColor {
        get {
            return #colorLiteral(red: 1, green: 0.9921568627, blue: 0.8156862745, alpha: 1)
        }
    }
}

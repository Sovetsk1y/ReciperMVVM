//
//  NewRecipeViewModel.swift
//  ReciperMVVM
//
//  Created by Евгений on 01/10/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//
protocol NewRecipeDelegate {
    func newRecipeDidAdd(_ recipe: RecipeModel)
}

struct NewRecipeViewModel {
    var delegate: NewRecipeDelegate?
}

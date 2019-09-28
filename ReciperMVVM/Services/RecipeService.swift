//
//  RecipeService.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

typealias RecipesCompletion = ([RecipeModel]?, Error?) -> ()

final class RecipeService {
    
    static let shared = RecipeService()
    
    private init() { }
    
    func getRecipes(_ completion: RecipesCompletion) {
        completion(initialRecipes, nil)
    }
    
    
    private let initialRecipes: [RecipeModel] = [
        RecipeModel(name: "Блинчики с мясом", tags: ["Вкусно", "Для детей", "Легко", "На дурачка"], cookingTime: 1234, image: nil),
        RecipeModel(name: "Паста Карбонара", tags: ["Романтический ужин", "Паста"], cookingTime: 5332, image: nil, isFavourite: true),
        RecipeModel(name: "Говно мамонта", tags: nil, cookingTime: nil, image: nil)
        ]
}

//
//  ListRecipeViewController.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit

final class ListRecipeViewController: UITableViewController {
    
    var viewModel: ListRecipeViewModel!
    
    private var recipeCells = [RecipeCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: viewModel.cellReuseIdentifier)
        
        setupViews()
        fetchRecipes()
    }
    
    private func setupViews() {
        tableView.tableFooterView = UIView()
        view.backgroundColor = viewModel.viewBackgroundColor
        navigationItem.title = viewModel.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    private func fetchRecipes() {
        RecipeService.shared.getRecipes { (recipes, error) in
            if error != nil {
                print("Failed to fetch recipes: \(error!)")
            }
            self.recipeCells = recipes?.map({return RecipeCellViewModel(recipe: $0)}) ?? []
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReuseIdentifier, for: indexPath) as? RecipeTableViewCell {
            cell.configure(recipeCellViewModel: recipeCells[indexPath.row])
            return cell
            }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel!.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

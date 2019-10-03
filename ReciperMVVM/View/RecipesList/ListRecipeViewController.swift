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
        tableView.allowsSelection = false
        view.backgroundColor = viewModel.viewBackgroundColor
        navigationItem.title = viewModel.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipeButtonDidTap))
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
    
    //MARK: - @objc Funcs
    
    @objc private func addRecipeButtonDidTap() {
        let newRecipeViewController = NewRecipeViewController()
        newRecipeViewController.viewModel = NewRecipeViewModel()
        newRecipeViewController.viewModel.delegate = self
        present(newRecipeViewController, animated: true, completion: nil)
    }
    
    //MARK: - Table View Delegate, Data Source
    
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
        return viewModel.cellHeight
    }
    
}

//MARK: - Extensions

extension ListRecipeViewController: NewRecipeDelegate {
    func newRecipeDidAdd(_ recipe: RecipeModel) {
        recipeCells.append(RecipeCellViewModel(recipe: recipe))
        tableView.reloadData()
    }
}

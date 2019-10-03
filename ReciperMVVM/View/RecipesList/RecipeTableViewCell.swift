//
//  RecipeTableViewCell.swift
//  ReciperMVVM
//
//  Created by Евгений on 28/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit
import TagListView

final class RecipeTableViewCell: UITableViewCell {
    
    var recipeCellViewModel: RecipeCellViewModel! {
        didSet {
            nameLabel.text = recipeCellViewModel.recipeName
            cookingTimeLabel.text = recipeCellViewModel.cookingTimeText
            tagListView.addTags(recipeCellViewModel.tags ?? [])
            
            DispatchQueue.main.async {
                if let data = self.recipeCellViewModel.dishImage {
                    self.dishImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.6470588235, blue: 0.1254901961, alpha: 1)
        imageView.image = #imageLiteral(resourceName: "dishEmptyImage")
        return imageView
    }()
    
    private var cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.8549019608, green: 0.6470588235, blue: 0.1254901961, alpha: 1)
        return label
    }()
    
    private var tagListView: TagListView = {
        let tagListView = TagListView()
        tagListView.tagBackgroundColor = #colorLiteral(red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
        tagListView.textColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        tagListView.cornerRadius = 10
        tagListView.paddingX = 8
        tagListView.paddingY = 4
        tagListView.marginY = 10
        tagListView.clipsToBounds = true
        tagListView.isUserInteractionEnabled = false
        return tagListView
    }()
    
    private var accessoryViewButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "recipeTableViewAccessoryView"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "favouriteStar"), for: .normal)
        return button
    }()
    
    //MARK: - Private Funcs
    
    private func setFavouriteButtonColor() {
        favouriteButton.tintColor = recipeCellViewModel.favouriteButtonColor()
    }
    
    private func setupViews() {
        backgroundColor = recipeCellViewModel.cellBackgroundColor
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        selectedBackgroundView = backgroundView
        clipsToBounds = true
        
        favouriteButton.addTarget(self, action: #selector(favouriteDidTap), for: .touchUpInside)
        
        addSubview(nameLabel)
        addSubview(dishImageView)
        addSubview(cookingTimeLabel)
        addSubview(tagListView)
        addSubview(accessoryViewButton)
        addSubview(favouriteButton)
        
        dishImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, size: .init(width: 45, height: 45), padding: .init(top: 13, left: 8, bottom: 0, right: 0))
        nameLabel.anchor(top: topAnchor, leading: dishImageView.trailingAnchor, trailing: nil, bottom: nil, size: .zero, padding: .init(top: 8, left: 12, bottom: 0, right: 0))
        cookingTimeLabel.anchor(top: nameLabel.bottomAnchor, leading: dishImageView.trailingAnchor, trailing: nil, bottom: nil, size: .zero, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        if recipeCellViewModel.cookingTimeText == nil {
            cookingTimeLabel.isHidden = true
        }
        if tagListView.tagViews.count != 0 {
            tagListView.anchor(top: cookingTimeLabel.bottomAnchor, leading: dishImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil, size: .init(width: 0, height: 20), padding: .init(top: 4, left: 12, bottom: 0, right: 12))
        } else {
            tagListView.anchor(top: nil, leading: dishImageView.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, size: .zero, padding: .init(top: 6, left: 12, bottom: 6, right: 12))
        }
        
        accessoryViewButton.anchor(top: topAnchor, leading: nil, trailing: trailingAnchor, bottom: nil, size: .init(width: 21, height: 21), padding: .init(top: 8, left: 0, bottom: 0, right: 8))
        favouriteButton.anchor(top: topAnchor, leading: nameLabel.trailingAnchor, trailing: nil, bottom: nil, size: .init(width: 18, height: 18), padding: .init(top: 8, left: 4, bottom: 0, right: 0))
        setFavouriteButtonColor()
    }
    
    //MARK: - @objc Funcs
    
    @objc private func favouriteDidTap() {
        setFavouriteButtonColor()
    }

}

//MARK: - Extensions

extension RecipeTableViewCell {
    func configure(recipeCellViewModel: RecipeCellViewModel) {
        self.recipeCellViewModel = recipeCellViewModel
        setupViews()
    }
}

//
//  NewRecipeViewController.swift
//  ReciperMVVM
//
//  Created by Евгений on 29/09/2019.
//  Copyright © 2019 Евгений. All rights reserved.
//

import UIKit
import TagListView

final class NewRecipeViewController: UIViewController {
    
    //MARK: - Structs
    
    struct Constants {
        static let dishImageViewAspectRatio: CGFloat = 16 / 9
        static let textFieldHeight: CGFloat = 40
        static let addTagButtonSize: CGSize = .init(width: 35, height: 35)
    }
    
    private struct CookingTimeCounter {
        private var hours: Int = 0
        private var minutes: Int = 30
        
        mutating func set(hours: Int?, minutes: Int?) {
            if let hours = hours {
                self.hours = hours
            }
            if let minutes = minutes {
                self.minutes = minutes
            }
        }
        
        func string() -> String {
            return "\(hours) ч. \(minutes) мин."
        }
        func getMinutes() -> Int {
            return self.minutes + self.hours*60
        }
    }
    
    //MARK: - View Properties
    
    private var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 0.5)
        return imageView
    }()
    
    private var addDishImageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addButtonImage"), for: .normal)
        button.tintColor = UIColor.black.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(addDishImageButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        textField.borderWidth = 2
        textField.borderColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
        textField.tintColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
        textField.layerCornerRadius = 5
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.attributedPlaceholder = "Название блюда".toAttributed(alignment: .center, color: #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.6588235294, alpha: 1), font: UIFont.systemFont(ofSize: 15))
        return textField
    }()
    
    private var cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.text = "Время приготовления"
        return label
    }()
    
    private var cookingTimePickerView = UIPickerView()
    private var cookingTimeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        textField.borderWidth = 2
        textField.borderColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
        textField.tintColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
        textField.layerCornerRadius = 5
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.attributedPlaceholder = "HH:mm".toAttributed(alignment: .center, color: #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.6588235294, alpha: 1), font: UIFont.systemFont(ofSize: 15))
        return textField
    }()
    
    private var tagTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        textField.borderWidth = 2
        textField.borderColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
        textField.tintColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
        textField.layerCornerRadius = 5
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = "Ужин, детям, легко...".toAttributed(alignment: .left, color: #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.6588235294, alpha: 1), font: UIFont.systemFont(ofSize: 15))
        return textField
    }()
    
    private var addTagButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addButtonImage"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
        button.addTarget(self, action: #selector(addTagButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private var tagListView: TagListView = {
        let tagListView = TagListView()
        tagListView.tagBackgroundColor = #colorLiteral(red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
        tagListView.textColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        tagListView.cornerRadius = 10
        tagListView.paddingX = 8
        tagListView.paddingY = 4
        tagListView.marginY = 4
        tagListView.textFont = UIFont.systemFont(ofSize: 15)
        tagListView.enableRemoveButton = true
        tagListView.clipsToBounds = true
        return tagListView
    }()
    
    private var addRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
        button.addTarget(self, action: #selector(addRecipeButtonDidTap), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        button.borderColor = #colorLiteral(red: 0.9960784314, green: 0.7294117647, blue: 0.4470588235, alpha: 1)
        button.borderWidth = 2
        button.layerCornerRadius = 20
        return button
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        button.borderColor = #colorLiteral(red: 0.9960784314, green: 0.7294117647, blue: 0.4470588235, alpha: 1)
        button.borderWidth = 2
        button.layerCornerRadius = 20
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARk: - Properties
    
    private var cookingTimeCounter = CookingTimeCounter()
    private var imagePicker: ImagePicker?
    var viewModel: NewRecipeViewModel!
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Private Funcs
    
    private func handleTextFieldError(in textField: UITextField) {
        UIView.transition(with: textField, duration: 1, options: [.transitionCrossDissolve, .autoreverse], animations: {
            textField.borderColor = UIColor.red.cgColor
            textField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        }, completion: { _ in
            textField.borderColor = #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 0.5)
            textField.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.8901960784, alpha: 1)
        })
    }
    
    private func addTag() {
        guard let tagString = tagTextField.text, !tagString.isEmpty else {
            return
        }
        guard tagListView.tagViews.count < 10 else { return }
        tagListView.addTag(tagString)
        tagTextField.text = ""
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.8156862745, alpha: 1)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        view.addSubview(dishImageView)
        view.addSubview(nameTextField)
        view.addSubview(cookingTimeLabel)
        view.addSubview(cookingTimeTextField)
        view.addSubview(tagTextField)
        view.addSubview(addTagButton)
        view.addSubview(tagListView)
        view.addSubview(addRecipeButton)
        view.addSubview(cancelButton)
        view.addSubview(addDishImageButton)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        }
        
        tagListView.delegate = self
        cookingTimePickerView.dataSource = self
        cookingTimePickerView.delegate = self
        cookingTimePickerView.selectRow(29, inComponent: 2, animated: false)
        cookingTimeTextField.inputView = cookingTimePickerView
        nameTextField.delegate = self
        cookingTimeTextField.delegate = self
        tagTextField.delegate = self
        
        dishImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, size: .init(width: view.frame.width, height: view.frame.width / Constants.dishImageViewAspectRatio))
        addDishImageButton.anchorCenter(in: dishImageView)
        nameTextField.anchor(top: dishImageView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, size: .init(width: 0, height: Constants.textFieldHeight), padding: .init(top: 8, left: 16, bottom: 0, right: 16))
        cookingTimeLabel.anchor(top: nameTextField.bottomAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 30, left: 16, bottom: 0, right: 0))
        cookingTimeTextField.anchor(top: nameTextField.bottomAnchor, leading: cookingTimeLabel.trailingAnchor, trailing: view.trailingAnchor, bottom: nil, size: .init(width: 0, height: Constants.textFieldHeight), padding: .init(top: 16, left: 8, bottom: 0, right: 16))
        tagTextField.anchor(top: cookingTimeTextField.bottomAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, size: .init(width: 0, height: Constants.textFieldHeight), padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        addTagButton.anchor(top: cookingTimeTextField.bottomAnchor, leading: tagTextField.trailingAnchor, trailing: view.trailingAnchor, bottom: nil, size: Constants.addTagButtonSize, padding: .init(top: 18, left: 8, bottom: 0, right: 16))
        tagListView.anchor(top: tagTextField.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: addRecipeButton.topAnchor, padding: .init(top: 8, left: 16, bottom: 16, right: 16))
        addRecipeButton.anchor(top: nil, leading: view.leadingAnchor, trailing: nil, bottom: view.bottomAnchor, size: .init(width: view.frame.width / 2 - 24, height: Constants.textFieldHeight), padding: .init(top: 0, left: 16, bottom: 16, right: 0))
        cancelButton.anchor(top: nil, leading: nil, trailing: view.trailingAnchor, bottom: view.bottomAnchor, size: .init(width: view.frame.width / 2 - 24, height: Constants.textFieldHeight), padding: .init(top: 0, left: 0, bottom: 16, right: 16))
    }
    
    //MARK: - @objc Funcs
    
    @objc private func addTagButtonDidTap() {
        addTag()
    }
    
    @objc private func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addDishImageButtonDidTap(_ sender: UIButton) {
        imagePicker?.present(from: sender)
    }
    
    @objc private func addRecipeButtonDidTap() {
        guard let name = nameTextField.text, !name.isEmpty else {
            self.handleTextFieldError(in: nameTextField)
            return
        }
        var cookingTime: Int?
        if let text = cookingTimeTextField.text, !text.isEmpty {
            cookingTime = cookingTimeCounter.getMinutes()
        }
        var tagStrings: [String] = []
        tagListView.tagViews.forEach({tagStrings.append($0.currentTitle!)})
        viewModel.delegate?.newRecipeDidAdd(RecipeModel(name: name, tags: tagStrings, cookingTime: cookingTime, image: dishImageView.image?.pngData()))
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extensions

extension NewRecipeViewController: TagListViewDelegate {
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTagView(tagView)
    }
}

extension NewRecipeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            cookingTimeCounter.set(hours: row, minutes: nil)
            cookingTimeTextField.text = cookingTimeCounter.string()
        case 2:
            cookingTimeCounter.set(hours: nil, minutes: row+1)
            cookingTimeTextField.text = cookingTimeCounter.string()
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 99
        case 1:
            return 1
        case 2:
            return 59
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "ч."
        case 2:
            return "\(row+1)"
        case 3:
            return "мин."
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 70
        case 1:
            return 40
        case 2:
            return 70
        case 3:
            return 70
        default:
            return 0
        }
    }

}

extension NewRecipeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tagTextField:
            addTag()
        default:
            break
        }
        dismissKeyboard()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cookingTimeTextField {
            return false
        }
        if textField == tagTextField {
            if let text = textField.text {
                guard string != "" else { return true }
                if text.count > 12 {
                    return false
                }
            }
        }
        return true
    }
    
}
extension NewRecipeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        dishImageView.image = image
    }
}

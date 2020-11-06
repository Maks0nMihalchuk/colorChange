//
//  SignUpView.swift
//  rgb color palette
//
//  Created by maks on 04.11.2020.
//  Copyright © 2020 maks. All rights reserved.
//

import UIKit

protocol SignUpDelegate: class {
    
    //Правильно ли так ?
    func returnPicker (picker: UIPickerView) -> UIPickerView
    func returnToolBar (bar: UIToolbar) -> UIToolbar
    func returnTextField (textField: UITextField) -> UITextField
    func returnDatePicker (picker: UIDatePicker) -> UIDatePicker
    //
    func genderPickerShow (picker: UIPickerView, textField: UITextField, toolbar: UIToolbar)
    func birthdayPickerShow (picker: UIDatePicker, textField: UITextField, toolbar: UIToolbar)
    
    func genderEndEditing(textField: UITextField, button: UIButton)
    func birthdayEndEditing (textField: UITextField, button: UIButton)
    
    func takeDate (picker: UIDatePicker)
    func nextScreen ()
}

class SignUpView: UIView {
    
    var check = false
    
    var dataSource: PickerDataSource
    
    weak var delegate: SignUpDelegate?
    
    var pickerViewDelegate: UIPickerViewDelegate? {
        didSet {
            genderPicker.delegate = self.pickerViewDelegate
        }
    }
    
    var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            genderTextField.delegate = self.textFieldDelegate
            birthdayTextField.delegate = self.textFieldDelegate
        }
    }

    private lazy var userProfileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "userProfileImage"))
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        
        return image
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "next"), for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        
        button.isEnabled = false
        button.addTarget(self, action: #selector(clickNextButton (button:)), for: .touchUpInside)
        
        return button
    }()
//MARK: - Gender
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Gender:"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private lazy var genderTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 4
        textField.placeholder = "Choose your gender"
        
        
        textField.addTarget(self, action: #selector(genderSelection(textField:)), for: .editingDidBegin)
        return textField
    }()
    private lazy var genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self.dataSource
        picker.isHidden = true
        picker.backgroundColor = .white
        
        return picker
    }()
    
//MARK: - Birthday
    private lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Birthday:"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private lazy var birthdayTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 4
        textField.placeholder = "Choose your date of birth"
        textField.addTarget(self, action: #selector(genderSelection(textField:)), for: .editingDidBegin)
        
        return textField
    }()
    
    private lazy var birthdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .date
        picker.isHidden = true
        
        picker.addTarget(self, action: #selector(datePicker(picker:)), for: .valueChanged)
        
        return picker
    }()
    
    //Gender ToolBar
    private lazy var genderToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.genderPicker.frame.size.width, height: 40))
        toolBar.sizeToFit()
        toolBar.barStyle = .black
        toolBar.tintColor = .white
        toolBar.setItems([genderDoneButton], animated: true)
        
        return toolBar
    }()
    private lazy var genderDoneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressDoneButton(button:)))
        
        return button
    }()

//MARK: - Methods
    @objc func genderSelection (textField: UITextField) {
        
        guard let picker = delegate?.returnPicker(picker: genderPicker) else {return}
        guard let bar = delegate?.returnToolBar(bar: genderToolBar) else {return}
        
        guard let datePicker = delegate?.returnDatePicker(picker: birthdayPicker) else {return}
        
        if textField == genderTextField {
            delegate?.genderPickerShow(picker: picker, textField: textField, toolbar: bar)
        }else {
            delegate?.birthdayPickerShow(picker: datePicker, textField: textField, toolbar: bar)
        }
    }
    @objc func pressDoneButton (button: UIBarButtonItem) {
        
        check = !check
        
        if check {
            guard let gTextField = delegate?.returnTextField(textField: genderTextField) else {return}
            delegate?.genderEndEditing(textField: gTextField, button: nextButton)
        }else {
            guard let bTextField = delegate?.returnTextField(textField: birthdayTextField) else {return}
            delegate?.birthdayEndEditing(textField: bTextField, button: nextButton)
        }
    }
    @objc func datePicker (picker: UIDatePicker) {
        delegate?.takeDate(picker: picker)
    }
    
    //check filling text fields
    @objc func clickNextButton (button: UIButton) {
        delegate?.nextScreen()
    }
    
//MARK: -  init
    override init(frame: CGRect) {
        self.dataSource = PickerDataSource()
        super.init(frame: frame)
        
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - layoutSetup
    func layoutSetup() {
        
        addSubview(userProfileImage)
        addSubview(genderLabel)
        addSubview(genderTextField)
        addSubview(birthdayLabel)
        addSubview(birthdayTextField)
        addSubview(nextButton)
        
        addSubview(genderPicker)
        addSubview(birthdayPicker)
        
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        birthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        birthdayPicker.translatesAutoresizingMaskIntoConstraints = false
        
        userProfileImage.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 2.5).isActive = true
        userProfileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        genderLabel.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor, constant: 20).isActive = true
        genderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        genderTextField.centerYAnchor.constraint(equalTo: genderLabel.centerYAnchor).isActive = true
        genderTextField.leftAnchor.constraint(equalTo: genderLabel.rightAnchor, constant: 20).isActive = true
        genderTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        genderTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        birthdayLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        birthdayTextField.centerYAnchor.constraint(equalTo: birthdayLabel.centerYAnchor).isActive = true
        birthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor, constant: 10).isActive = true
        birthdayTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        birthdayTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor, constant: 16).isActive = true
        nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        nextButton.leftAnchor.constraint(equalTo: birthdayTextField.rightAnchor, constant: 10).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        genderPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        genderPicker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        genderPicker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        birthdayPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        birthdayPicker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        birthdayPicker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
}

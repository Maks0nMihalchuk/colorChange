//
//  SignUoController.swift
//  rgb color palette
//
//  Created by maks on 04.11.2020.
//  Copyright © 2020 maks. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    private lazy var genderTextArray = PickerDataSource.genderArray
    private lazy var genderText = String()
    private lazy var birthdayText = String()
    private lazy var checkTextFields = Bool()
    
    private lazy var contentView: SignUpView = {
        let contentView = SignUpView(frame: self.view.frame)
        
        contentView.delegate = self
        contentView.textFieldDelegate = self
        contentView.pickerViewDelegate = self
        
        contentView.backgroundColor = .blue
        
        return contentView
    }()

    override func loadView() {
        super.loadView()
        
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkTextFields (button: UIButton, genderText: String, birthdayText: String) {
        
        if !genderText.isEmpty && !birthdayText.isEmpty {
            button.backgroundColor = .green
            button.isEnabled = true
            
        }else {
            button.backgroundColor = .lightGray
            button.isEnabled = false
            
        }
        
    }
    
}
extension SignUpController: UITextFieldDelegate, UIPickerViewDelegate, SignUpDelegate {
    
    func takeDate (picker: UIDatePicker) {
        picker.minimumDate = Date()
        let forrmatter = DateFormatter()
        forrmatter.dateStyle = .medium
        forrmatter.timeStyle = .none

        birthdayText = forrmatter.string(from: picker.date)
        
    }
    
    func birthdayPickerShow(picker: UIDatePicker, textField: UITextField, toolbar: UIToolbar) {
        textField.text = ""
        birthdayText = ""
        textField.inputAccessoryView = toolbar
        textField.inputView = picker
        picker.isHidden = false
    }

    func genderPickerShow(picker: UIPickerView, textField: UITextField, toolbar: UIToolbar) {
        textField.text = ""
        genderText = ""
        picker.selectRow(genderTextArray.startIndex, inComponent: 0, animated: true)
        textField.inputAccessoryView = toolbar
        textField.inputView = picker
        picker.isHidden = false
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        genderText = genderTextArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = .boldSystemFont(ofSize: 20)
        label.text =  genderTextArray[row]
        label.textAlignment = .center
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    func returnPicker(picker: UIPickerView) -> UIPickerView {
        return picker
    }
    func returnToolBar (bar: UIToolbar) -> UIToolbar {
        return bar
    }
    func returnTextField (textField: UITextField) -> UITextField {
        return textField
    }
    func returnDatePicker (picker: UIDatePicker) -> UIDatePicker {
        return picker
    }
    func genderEndEditing(textField: UITextField, button: UIButton) {
        
        if genderText.isEmpty || genderText == "--Select--" {
            genderText = ""
        }else {
            textField.text = genderText
        }
        checkTextFields(button: button, genderText: genderText, birthdayText: birthdayText)
        self.view.endEditing(true)
    }
    
    func birthdayEndEditing (textField: UITextField, button: UIButton) {
        
        textField.text = birthdayText
        print(birthdayText)
        checkTextFields(button: button, genderText: genderText, birthdayText: birthdayText)
        self.view.endEditing(true)
    }
    func nextScreen () {
        let paletteController = PaletteController()
        paletteController.modalPresentationStyle = .fullScreen
        self.present(paletteController, animated: true, completion: nil)
    }
}

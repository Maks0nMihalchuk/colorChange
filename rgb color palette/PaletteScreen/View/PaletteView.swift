//
//  View.swift
//  rgb color palette
//
//  Created by maks on 04.11.2020.
//  Copyright © 2020 maks. All rights reserved.
//

import UIKit

protocol ViewDelegate: class {
    
    func setupViewColor (view: UIView, red: Float, green: Float, blue: Float)
    
    func setValueTextFieldForSlider (slider: UISlider, textField: UITextField)
}

class PaletteView: UIView {
    
    weak var delegate: ViewDelegate?
    
    var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            redTextField.delegate = self.textFieldDelegate
            greenTextField.delegate = self.textFieldDelegate
            blueTextField.delegate = self.textFieldDelegate
        }
    }

    private lazy var view: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1.0)
        view.layer.cornerRadius = 150
        
        return view
    }()
    
    //Red Color
    private lazy var redLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Red:"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private lazy var redTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        textField.addTarget(self, action: #selector(setValueRedTextField(textField:)), for: .editingChanged)
        return textField
    }()
    private lazy var redSlider: UISlider = {
        let slider = UISlider()
        
        slider.tintColor = .red
        slider.thumbTintColor = .red
        
        slider.minimumValue = 0.0
        slider.maximumValue = 255.0
        
        return slider
    }()
    
    //Green Color
    private lazy var greenLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Green:"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private lazy var greenTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        textField.addTarget(self, action: #selector(setValueGreenTextField(textField:)), for: .editingChanged)
        return textField
    }()
    private lazy var greenSlider: UISlider = {
        let slider = UISlider()
        
        slider.tintColor = .green
        slider.thumbTintColor = .green
        
        slider.minimumValue = 0.0
        slider.maximumValue = 255.0
        
        return slider
    }()
    
    //Blue Color
    private lazy var blueLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Blue:"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    private lazy var blueTextField: UITextField = {
        let textField = UITextField()
        
        
        textField.borderStyle = .roundedRect
        
        textField.addTarget(self, action: #selector(setValueBlueTextField(textField:)), for: .editingChanged)
        return textField
    }()
    private lazy var blueSlider: UISlider = {
        let slider = UISlider()
        
        slider.tintColor = .blue
        slider.thumbTintColor = .blue
        
        slider.minimumValue = 0.0
        slider.maximumValue = 255.0
        
        return slider
    }()
    
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Methods
    @objc func setValueRedTextField (textField: UITextField) {
        delegate?.setValueTextFieldForSlider(slider: redSlider, textField: textField)
        delegate?.setupViewColor(view: view, red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
    }
    @objc func setValueGreenTextField (textField: UITextField) {
        delegate?.setValueTextFieldForSlider(slider: greenSlider, textField: textField)
        delegate?.setupViewColor(view: view, red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
    }
    @objc func setValueBlueTextField (textField: UITextField) {
        delegate?.setValueTextFieldForSlider(slider: blueSlider, textField: textField)
        delegate?.setupViewColor(view: view, red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
    }
    
    //layout
    func layoutSetup() {
        
        addSubview(view)
        addSubview(redSlider)
        addSubview(greenSlider)
        addSubview(blueSlider)
        
        addSubview(redLabel)
        addSubview(greenLabel)
        addSubview(blueLabel)
        
        addSubview(redTextField)
        addSubview(greenTextField)
        addSubview(blueTextField)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        redSlider.translatesAutoresizingMaskIntoConstraints = false
        greenSlider.translatesAutoresizingMaskIntoConstraints = false
        blueSlider.translatesAutoresizingMaskIntoConstraints = false
        
        redLabel.translatesAutoresizingMaskIntoConstraints = false
        greenLabel.translatesAutoresizingMaskIntoConstraints = false
        blueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        redTextField.translatesAutoresizingMaskIntoConstraints = false
        greenTextField.translatesAutoresizingMaskIntoConstraints = false
        blueTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        redLabel.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        redLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        
        redTextField.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        redTextField.leftAnchor.constraint(equalTo: redLabel.rightAnchor, constant: 25).isActive = true
        redTextField.centerYAnchor.constraint(equalTo: redLabel.centerYAnchor).isActive = true
        redTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        redTextField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        redSlider.topAnchor.constraint(equalToSystemSpacingBelow: self.redLabel.bottomAnchor, multiplier: 1.5).isActive = true
        redSlider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        redSlider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        
        greenLabel.topAnchor.constraint(equalTo: self.redSlider.bottomAnchor, constant: 20).isActive = true
        greenLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        
        greenTextField.topAnchor.constraint(equalTo: self.redSlider.bottomAnchor, constant: 20).isActive = true
        greenTextField.leftAnchor.constraint(equalTo: greenLabel.rightAnchor, constant: 5).isActive = true
        greenTextField.centerYAnchor.constraint(equalTo: greenLabel.centerYAnchor).isActive = true
        greenTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        greenTextField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        greenSlider.topAnchor.constraint(equalToSystemSpacingBelow: self.greenLabel.bottomAnchor, multiplier: 2.0).isActive = true
        greenSlider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        greenSlider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        
        blueLabel.topAnchor.constraint(equalTo: self.greenSlider.bottomAnchor, constant: 20).isActive = true
        blueLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        
        blueTextField.topAnchor.constraint(equalTo: self.greenSlider.bottomAnchor, constant: 20).isActive = true
        blueTextField.leftAnchor.constraint(equalTo: blueLabel.rightAnchor, constant: 20).isActive = true
        blueTextField.centerYAnchor.constraint(equalTo: blueLabel.centerYAnchor).isActive = true
        blueTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blueTextField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        blueSlider.topAnchor.constraint(equalToSystemSpacingBelow: self.blueLabel.bottomAnchor, multiplier: 2.0).isActive = true
        blueSlider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        blueSlider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
    }
    
}


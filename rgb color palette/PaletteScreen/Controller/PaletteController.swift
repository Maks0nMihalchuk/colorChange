//
//  ViewController.swift
//  rgb color palette
//
//  Created by maks on 04.11.2020.
//  Copyright © 2020 maks. All rights reserved.
//

import UIKit

class PaletteController: UIViewController {
    
    private lazy var contentView: PaletteView = {
        let contentView = PaletteView(frame: self.view.frame)
        
        contentView.textFieldDelegate = self
        contentView.delegate = self
        
        contentView.backgroundColor = .white
        
        return contentView
    }()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view = contentView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension PaletteController: ViewDelegate, UITextFieldDelegate {
    
    func setupViewColor(view: UIView, red: Float, green: Float, blue: Float) {
        
        view.backgroundColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
    }
    func setValueTextFieldForSlider(slider: UISlider, textField: UITextField) {
        
        guard let text = textField.text else {return}
        ///Костиль?
        if Int(text) != nil && Int(text)! <= 255 {
            if textField.text == "" {
                slider.value = 0.0
            }else {
                slider.value = Float(textField.text!)!
            }
            
        }else {
           
            textField.text = ""
            slider.value = 0.0
            
            let alert = UIAlertController(title: "Не верный ввод", message: "Введите целое число в пределах от 0 до 255", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}

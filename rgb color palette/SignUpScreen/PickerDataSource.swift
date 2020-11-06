//
//  PickerDataSource.swift
//  rgb color palette
//
//  Created by maks on 04.11.2020.
//  Copyright © 2020 maks. All rights reserved.
//

import UIKit

class PickerDataSource: NSObject, UIPickerViewDataSource {
    
    static let genderArray = ["--Select--", "Man's", "Women's"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerDataSource.genderArray.count
    }

}

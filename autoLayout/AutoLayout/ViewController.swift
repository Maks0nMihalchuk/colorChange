//
//  ViewController.swift
//  AutoLayout
//
//  Created by maks on 05.11.2020.
//  Copyright © 2020 maks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackOfFourViews: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            stackOfFourViews.spacing = 30
        } else {
            stackOfFourViews.spacing = 50
            
        }
    }

}


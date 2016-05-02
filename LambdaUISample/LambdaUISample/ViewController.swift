//
//  ViewController.swift
//  LambdaUISample
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import UIKit
import LambdaUI

class ViewController: UIViewController {

    @IBOutlet weak var button: LDAButton!
    @IBOutlet weak var noHButton: UIButton!
    @IBOutlet weak var stepper: LDAStepper!
    @IBOutlet weak var textField: LDATextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.events.touchUpInside = { button, event in
            self.view.backgroundColor = UIColor.purpleColor()
            print(event)
        }
        
        stepper.events.valueChanged = { stepper, event in
            print(rand())
        }
        
        textField.events.valueChanged = { field, event in
            print(rand())
        }
    }


}


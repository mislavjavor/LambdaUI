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
    @IBOutlet weak var stepper: LDAStepper!
    @IBOutlet weak var datePicker: LDADatePicker!
    @IBOutlet weak var textField: LDATextField!
    @IBOutlet weak var segmentedConrol: LDASegmentedControl!
    @IBOutlet weak var slider: LDASlider!
    @IBOutlet weak var uiSwitch: LDASwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.events.touchUpInside += { _ in
            print("button touched")
        }
        
        stepper.events.valueChanged += { _ in
            print("stepper val changed")
        }
        
        datePicker.events.valueChanged += { _ in
            print("date picker val changed")
        }
        
        textField.events.editingDidBegin += { _ in
            print("text field editing did begin")
        }
        
        segmentedConrol.events.valueChanged += { _ in
            print("segmented control value changed")
        }
        
        slider.events.valueChanged += { _ in
            print("slider value changed")
        }
        
        uiSwitch.events.valueChanged += { _ in
            print("switch value changed")
        }
        
    }
}
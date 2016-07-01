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
	
	@IBOutlet weak var stepper: UIStepper!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var counter = 1
		
		stepper.events.valueChanged += { _ in
			print(self.stepper.value)
		}
	}
}
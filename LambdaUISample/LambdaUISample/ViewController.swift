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
	
	@IBOutlet weak var regularButton: UIButton!
	@IBOutlet weak var regularStepper: UIStepper!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		regularButton.events.touchUpInside += { _ in
			print("did it")
		}
		
		regularButton.events.touchUpInside += { _ in
			print("did it again")
		}
		
		regularButton.events.touchUpInside += async { _ in
			for _ in 0..<100000 {
				print("first event")
			}
		}
		
		regularButton.events.touchUpInside += async(queue: DispatchQueue.BackgroundQueue) { stuff in
			for _ in 0..<100000 {
				print("background event")
			}
		}
		
		regularStepper.events.valueChanged += { _ in
			print(self.regularStepper.value)
		}
	}
}
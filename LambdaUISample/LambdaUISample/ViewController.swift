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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.events.touchUpInside = { button, event in
            self.view.backgroundColor = UIColor.purpleColor()
            print(event)
        }
        
        let hHandler = LDABaseHandler(control: noHButton)
        hHandler.touchUpInside = { button, event in
            self.view.backgroundColor = UIColor.redColor()
        }
        
    }


}


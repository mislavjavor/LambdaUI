//
//  LDATextField.swift
//  LambdaUI
//
//  Created by Mislav Javor on 03/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class LDATextField : UITextField {
    
    public var events : LDABaseHandler<UITextField>!

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func addEventsToLambda() {
        events = LDABaseHandler(control: self)
    }
}
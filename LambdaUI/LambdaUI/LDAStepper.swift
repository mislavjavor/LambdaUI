//
//  LDAStepper.swift
//  LambdaUI
//
//  Created by Mislav Javor on 03/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
public class LDAStepper : UIStepper {
    
    public var events : LDABaseHandler<UIStepper>!
    public var asyncEvents : LDABaseHandler<UIStepper>!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addEventsToLambda()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addEventsToLambda()
    }
    
    private func addEventsToLambda() {
        events = LDABaseHandler(control: self)
    }
    
}
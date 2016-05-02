//
//  LDAButton.swift
//  LambdaUI
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class LDAButton : UIButton {
    
    public var events : LDABaseHandler<UIButton>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addEventsToLambda()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addEventsToLambda()
    }
    
    func addEventsToLambda() {
        events = LDABaseHandler(control: self)
    }
}
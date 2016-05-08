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
    
    public var events : LDAControlHandler<UIButton>!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addEventsToLambda()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addEventsToLambda()
    }
    
    private func addEventsToLambda() {
        events = LDAControlHandler(control: self)
    }
}
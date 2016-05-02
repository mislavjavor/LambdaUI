//
//  LBDBaseHandler.swift
//  LambdaUI
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public class LDABaseHandler<TControlType : UIControl>  {
    
    public typealias LDBEventHandler = (TControlType, UIEvent) -> Void
    
    public var touchUpInside : LDBEventHandler = { _ in }
    
    private let currentControl : UIControl
    
    public init(control: TControlType) {
        currentControl = control
        generateLambdaHandlers()
    }
    
    private func generateLambdaHandlers() {
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchUpInside(_:event:)), forControlEvents: .TouchUpInside)
    }
    
    @objc internal func touchUpInside(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchUpInside(castedControl, event)
    }
    
}
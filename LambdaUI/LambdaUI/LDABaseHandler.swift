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
    public var touchDown : LDBEventHandler = { _ in }
    public var touchDragInside : LDBEventHandler = { _ in }
    public var touchDragOutside : LDBEventHandler = { _ in }
    public var touchDragEnter : LDBEventHandler = { _ in }
    public var touchDragExit : LDBEventHandler = { _ in }
    public var touchUpOutside : LDBEventHandler = { _ in }
    public var touchCancel : LDBEventHandler = { _ in }
    public var valueChanged : LDBEventHandler = { _ in }
    
    private let currentControl : UIControl
    
    public init(control: TControlType) {
        currentControl = control
        generateLambdaHandlers()
    }
    
    public init(inout controlRef : UIButton) {
        currentControl = controlRef
    }
    
    private func generateLambdaHandlers() {
        
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchUpInsideHandler(_:event:)), forControlEvents: .TouchUpInside)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.valueChangedHandler(_:event:)), forControlEvents: .ValueChanged)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchDownHandler(_:event:)), forControlEvents: .TouchDown)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchDragInsideHandler(_:event:)), forControlEvents: .TouchDragInside)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchDragOutsideHandler(_:event:)), forControlEvents: .TouchDragOutside)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchDragEnterHandler(_:event:)), forControlEvents: .TouchDragEnter)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchDragExitHandler(_:event:)), forControlEvents: .TouchDragExit)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchUpOutsideHandler(_:event:)), forControlEvents: .TouchUpOutside)
        currentControl.addTarget(self, action: #selector(LDABaseHandler.touchCancelHandler(_:event:)), forControlEvents: .TouchCancel)
    }
    
    @objc internal func touchUpInsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchUpInside(castedControl, event)
    }
    
    @objc internal func touchDownHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchDown(castedControl, event)
    }
    
    @objc internal func touchDragInsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchDragInside(castedControl, event)
    }
    
    @objc internal func touchDragOutsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchDragOutside(castedControl, event)
    }
    
    @objc internal func touchDragEnterHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchDragEnter(castedControl, event)
    }
    
    @objc internal func touchDragExitHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchDragExit(castedControl, event)
    }
    
    @objc internal func touchUpOutsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchUpOutside(castedControl, event)
    }
    
    @objc internal func touchCancelHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        touchCancel(castedControl, event)
    }
    
    @objc internal func valueChangedHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        valueChanged(castedControl, event)
    }
    
    
}
//
//  LBDBaseHandler.swift
//  LambdaUI
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public class LDAControlHandler<TControlType : UIControl>  {
    
    public typealias LDAEventHandler = (TControlType, UIEvent) -> Void
    
    public var touchUpInside : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchDown : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchDragInside : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchDragOutside : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchDragEnter : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchDragExit : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchUpOutside : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var touchCancel : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var valueChanged : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var editingChanged : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var allEditingEvents : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var allEvents :  [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var allTouchEvents : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var editingDidEnd : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var editingDidBegin : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var editingDidEndOnExit : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    public var primaryActionTriggered : [LDAEvent<TControlType, Void>] = [LDAEvent<TControlType, Void>]()
    

    private let currentControl : TControlType
    
    public init(control: TControlType) {
        currentControl = control
        generateLambdaHandlers()
    }
    
    
    private func generateLambdaHandlers() {
        
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchUpInsideHandler(_:event:)), forControlEvents: .TouchUpInside)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.valueChangedHandler(_:event:)), forControlEvents: .ValueChanged)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchDownHandler(_:event:)), forControlEvents: .TouchDown)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchDragInsideHandler(_:event:)), forControlEvents: .TouchDragInside)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchDragOutsideHandler(_:event:)), forControlEvents: .TouchDragOutside)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchDragEnterHandler(_:event:)), forControlEvents: .TouchDragEnter)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchDragExitHandler(_:event:)), forControlEvents: .TouchDragExit)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchUpOutsideHandler(_:event:)), forControlEvents: .TouchUpOutside)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchCancelHandler(_:event:)), forControlEvents: .TouchCancel)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.editingChanged(_:event:)), forControlEvents: .EditingChanged)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.allEditingEvents(_:event:)
            ), forControlEvents: .AllEditingEvents)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.allEventsHandler(_:event:)), forControlEvents: .AllEvents)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.allTouchEventsHandler(_:event:)), forControlEvents: .AllTouchEvents)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.editingDidEndHandler(_:event:)), forControlEvents: .EditingDidEnd)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.editingDidBeginHandler(_:event:)), forControlEvents: .EditingDidBegin)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.editingDidEndOnExitHandler(_:event:)), forControlEvents: .EditingDidEndOnExit)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.primaryActionTriggeredHandler(_:event:)), forControlEvents: .PrimaryActionTriggered)
        currentControl.addTarget(self, action: #selector(LDAControlHandler.touchCancelHandler(_:event:)), forControlEvents: .TouchCancel)
        
        
    }
    
    @objc internal func touchCancelHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchCancel {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func primaryActionTriggeredHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in primaryActionTriggered {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func editingDidEndOnExitHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in editingDidEndOnExit {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func editingDidBeginHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in editingDidBegin {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func editingDidEndHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in editingDidEnd {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func allTouchEventsHandler(control : UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in allTouchEvents {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func allEventsHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in allEvents {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func allEditingEvents(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in allEditingEvents {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func editingChanged(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in editingChanged {
            handler.performEvent(castedControl, event: event)
        }
    }

    
    @objc internal func touchUpInsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchUpInside {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func touchDownHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchDown {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func touchDragInsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchDragInside {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func touchDragOutsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchDragOutside {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func touchDragEnterHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchDragEnter {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func touchDragExitHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchDragExit {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func touchUpOutsideHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in touchUpOutside {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    @objc internal func valueChangedHandler(control: UIControl, event: UIEvent) {
        let castedControl = control as! TControlType
        for handler in valueChanged {
            handler.performEvent(castedControl, event: event)
        }
    }
    
    
}
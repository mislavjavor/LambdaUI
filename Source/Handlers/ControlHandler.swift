//
//  LBDBaseHandler.swift
//  LambdaUI
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

public class ControlHandler {
    
    public typealias EventHandler = (UIEvent) -> Void
    
    public var touchUpInside : [Event] = [Event]()
    public var touchDown : [Event] = [Event]()
    public var touchDragInside : [Event] = [Event]()
    public var touchDragOutside : [Event] = [Event]()
    public var touchDragEnter : [Event] = [Event]()
    public var touchDragExit : [Event] = [Event]()
    public var touchUpOutside : [Event] = [Event]()
    public var touchCancel : [Event] = [Event]()
    public var valueChanged : [Event] = [Event]()
    public var editingChanged : [Event] = [Event]()
    public var allEditingEvents : [Event] = [Event]()
    public var allEvents :  [Event] = [Event]()
    public var allTouchEvents : [Event] = [Event]()
    public var editingDidEnd : [Event] = [Event]()
    public var editingDidBegin : [Event] = [Event]()
    public var editingDidEndOnExit : [Event] = [Event]()
    
    public var primaryActionTriggered : [Event] = [Event]()
    
    

    private let currentControl : UIControl
    
    public init(control: UIControl) {
        currentControl = control
        generateLambdaHandlers()
    }
    
    
    private func generateLambdaHandlers() {
        
        currentControl.addTarget(self, action: #selector(ControlHandler.touchUpInsideHandler(_:event:)), forControlEvents: .TouchUpInside)
        currentControl.addTarget(self, action: #selector(ControlHandler.valueChangedHandler(_:event:)), forControlEvents: .ValueChanged)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDownHandler(_:event:)), forControlEvents: .TouchDown)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragInsideHandler(_:event:)), forControlEvents: .TouchDragInside)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragOutsideHandler(_:event:)), forControlEvents: .TouchDragOutside)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragEnterHandler(_:event:)), forControlEvents: .TouchDragEnter)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragExitHandler(_:event:)), forControlEvents: .TouchDragExit)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchUpOutsideHandler(_:event:)), forControlEvents: .TouchUpOutside)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchCancelHandler(_:event:)), forControlEvents: .TouchCancel)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingChanged(_:event:)), forControlEvents: .EditingChanged)
        currentControl.addTarget(self, action: #selector(ControlHandler.allEditingEvents(_:event:)
            ), forControlEvents: .AllEditingEvents)
        currentControl.addTarget(self, action: #selector(ControlHandler.allEventsHandler(_:event:)), forControlEvents: .AllEvents)
        currentControl.addTarget(self, action: #selector(ControlHandler.allTouchEventsHandler(_:event:)), forControlEvents: .AllTouchEvents)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingDidEndHandler(_:event:)), forControlEvents: .EditingDidEnd)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingDidBeginHandler(_:event:)), forControlEvents: .EditingDidBegin)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingDidEndOnExitHandler(_:event:)), forControlEvents: .EditingDidEndOnExit)
        if #available(iOS 9, *) {
        currentControl.addTarget(self, action: #selector(ControlHandler.primaryActionTriggeredHandler(_:event:)), forControlEvents: .PrimaryActionTriggered)
        }
        currentControl.addTarget(self, action: #selector(ControlHandler.touchCancelHandler(_:event:)), forControlEvents: .TouchCancel)
        
        
    }
    
    @objc internal func touchCancelHandler(control: UIControl, event: UIEvent) {
        let control = control
        for handler in touchCancel {
            handler.performEvent(event)
        }
    }
    
    @objc internal func primaryActionTriggeredHandler(control: UIControl, event: UIEvent) {
        
        for handler in primaryActionTriggered {
            handler.performEvent(event)
        }
    }
    
    @objc internal func editingDidEndOnExitHandler(control: UIControl, event: UIEvent) {
        
        for handler in editingDidEndOnExit {
            handler.performEvent(event)
        }
    }
    
    @objc internal func editingDidBeginHandler(control: UIControl, event: UIEvent) {
        
        for handler in editingDidBegin {
            handler.performEvent(event)
        }
    }
    
    @objc internal func editingDidEndHandler(control: UIControl, event: UIEvent) {
        
        for handler in editingDidEnd {
            handler.performEvent(event)
        }
    }
    
    @objc internal func allTouchEventsHandler(control : UIControl, event: UIEvent) {
        
        for handler in allTouchEvents {
            handler.performEvent(event)
        }
    }
    
    @objc internal func allEventsHandler(control: UIControl, event: UIEvent) {
        
        for handler in allEvents {
            handler.performEvent(event)
        }
    }
    
    @objc internal func allEditingEvents(control: UIControl, event: UIEvent) {
        
        for handler in allEditingEvents {
            handler.performEvent(event)
        }
    }
    
    @objc internal func editingChanged(control: UIControl, event: UIEvent) {
        
        for handler in editingChanged {
            handler.performEvent(event)
        }
    }

    
    @objc internal func touchUpInsideHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchUpInside {
            handler.performEvent(event)
        }
    }
    
    @objc internal func touchDownHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchDown {
            handler.performEvent(event)
        }
    }
    
    @objc internal func touchDragInsideHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchDragInside {
            handler.performEvent(event)
        }
    }
    
    @objc internal func touchDragOutsideHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchDragOutside {
            handler.performEvent(event)
        }
    }
    
    @objc internal func touchDragEnterHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchDragEnter {
            handler.performEvent(event)
        }
    }
    
    @objc internal func touchDragExitHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchDragExit {
            handler.performEvent(event)
        }
    }
    
    @objc internal func touchUpOutsideHandler(control: UIControl, event: UIEvent) {
        
        for handler in touchUpOutside {
            handler.performEvent(event)
        }
    }
    
    @objc internal func valueChangedHandler(control: UIControl, event: UIEvent) {
        
        for handler in valueChanged {
            handler.performEvent(event)
        }
    }
    
    
}
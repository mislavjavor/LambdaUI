//
//  LBDBaseHandler.swift
//  LambdaUI
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import UIKit

open class ControlHandler {
    
    open var touchUpInside : [Event] = [Event]()
    open var touchDown : [Event] = [Event]()
    open var touchDragInside : [Event] = [Event]()
    open var touchDragOutside : [Event] = [Event]()
    open var touchDragEnter : [Event] = [Event]()
    open var touchDragExit : [Event] = [Event]()
    open var touchUpOutside : [Event] = [Event]()
    open var touchCancel : [Event] = [Event]()
    open var valueChanged : [Event] = [Event]()
    open var editingChanged : [Event] = [Event]()
    open var allEditingEvents : [Event] = [Event]()
    open var allEvents :  [Event] = [Event]()
    open var allTouchEvents : [Event] = [Event]()
    open var editingDidEnd : [Event] = [Event]()
    open var editingDidBegin : [Event] = [Event]()
    open var editingDidEndOnExit : [Event] = [Event]()
    
    open var primaryActionTriggered : [Event] = [Event]()
    
    
    

    fileprivate let currentControl : UIControl
    
    public init(control: UIControl) {
        currentControl = control
        generateLambdaHandlers()
    }
    
    
    
    fileprivate func generateLambdaHandlers() {
        
        currentControl.addTarget(self, action: #selector(ControlHandler.touchUpInsideHandler(_:event:)), for: .touchUpInside)
        currentControl.addTarget(self, action: #selector(ControlHandler.valueChangedHandler(_:event:)), for: .valueChanged)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDownHandler(_:event:)), for: .touchDown)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragInsideHandler(_:event:)), for: .touchDragInside)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragOutsideHandler(_:event:)), for: .touchDragOutside)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragEnterHandler(_:event:)), for: .touchDragEnter)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchDragExitHandler(_:event:)), for: .touchDragExit)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchUpOutsideHandler(_:event:)), for: .touchUpOutside)
        currentControl.addTarget(self, action: #selector(ControlHandler.touchCancelHandler(_:event:)), for: .touchCancel)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingChanged(_:event:)), for: .editingChanged)
        currentControl.addTarget(self, action: #selector(ControlHandler.allEditingEvents(_:event:)
            ), for: .allEditingEvents)
        currentControl.addTarget(self, action: #selector(ControlHandler.allEventsHandler(_:event:)), for: .allEvents)
        currentControl.addTarget(self, action: #selector(ControlHandler.allTouchEventsHandler(_:event:)), for: .allTouchEvents)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingDidEndHandler(_:event:)), for: .editingDidEnd)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingDidBeginHandler(_:event:)), for: .editingDidBegin)
        currentControl.addTarget(self, action: #selector(ControlHandler.editingDidEndOnExitHandler(_:event:)), for: .editingDidEndOnExit)
        if #available(iOS 9, *) {
        currentControl.addTarget(self, action: #selector(ControlHandler.primaryActionTriggeredHandler(_:event:)), for: .primaryActionTriggered)
        }
        currentControl.addTarget(self, action: #selector(ControlHandler.touchCancelHandler(_:event:)), for: .touchCancel)
        
        
    }
    
    
    @objc internal func touchCancelHandler(_ control: UIControl, event: UIEvent) {
        for handler in touchCancel {
            handler.performEvent(EventWrapper(event: event, type: .touchCancel))
        }
    }
    
    @objc internal func primaryActionTriggeredHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in primaryActionTriggered {
            if #available(iOS 9.0, *) {
                handler.performEvent(EventWrapper(event: event, type: .primaryActionTriggered))
            }
        }
    }
    
    @objc internal func editingDidEndOnExitHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in editingDidEndOnExit {
            handler.performEvent(EventWrapper(event: event, type: .editingDidEndOnExit))
        }
    }
    
    @objc internal func editingDidBeginHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in editingDidBegin {
            handler.performEvent(EventWrapper(event: event, type: .editingDidBegin ))
        }
    }
    
    @objc internal func editingDidEndHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in editingDidEnd {
            handler.performEvent(EventWrapper(event: event, type: .editingDidEnd))
        }
    }
    
    @objc internal func allTouchEventsHandler(_ control : UIControl, event: UIEvent) {
        
        for handler in allTouchEvents {
            handler.performEvent(EventWrapper(event: event, type: .allTouchEvents))
        }
    }
    
    @objc internal func allEventsHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in allEvents {
            handler.performEvent(EventWrapper(event: event, type: .allEvents))
        }
    }
    
    @objc internal func allEditingEvents(_ control: UIControl, event: UIEvent) {
        
        for handler in allEditingEvents {
            handler.performEvent(EventWrapper(event: event, type: .allEditingEvents))
        }
    }
    
    @objc internal func editingChanged(_ control: UIControl, event: UIEvent) {
        
        for handler in editingChanged {
            handler.performEvent(EventWrapper(event: event, type: .editingChanged))
        }
    }

    
    @objc internal func touchUpInsideHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchUpInside {
            handler.performEvent(EventWrapper(event: event, type: .touchUpInside))
        }
    }
    
    @objc internal func touchDownHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchDown {
            handler.performEvent(EventWrapper(event: event, type: .touchDown))
        }
    }
    
    @objc internal func touchDragInsideHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchDragInside {
            handler.performEvent(EventWrapper(event: event, type: .touchDragInside))
        }
    }
    
    @objc internal func touchDragOutsideHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchDragOutside {
            handler.performEvent(EventWrapper(event: event, type: .touchDragOutside))
        }
    }
    
    @objc internal func touchDragEnterHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchDragEnter {
            handler.performEvent(EventWrapper(event: event, type: .touchDragEnter))
        }
    }
    
    @objc internal func touchDragExitHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchDragExit {
            handler.performEvent(EventWrapper(event: event, type: .touchDragExit))
        }
    }
    
    @objc internal func touchUpOutsideHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in touchUpOutside {
            handler.performEvent(EventWrapper(event: event, type: .touchUpOutside))
        }
    }
    
    @objc internal func valueChangedHandler(_ control: UIControl, event: UIEvent) {
        
        for handler in valueChanged {
            handler.performEvent(EventWrapper(event: event, type: .valueChanged))
        }
    }
    
    
}

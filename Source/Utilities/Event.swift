//
//  Event.swift
//  LambdaUI
//
//  Created by Mislav Javor on 05/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation


public struct Event {

    public typealias EventFunction = (EventWrapper) -> Void

    
    private var shouldPerformAsync : Bool = false
    private var asyncQueue : dispatch_queue_t? = dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
    private var eventFunction : EventFunction = { _ in }
    public var uuid : String!
    
    init(shouldAsync: Bool = false, queue : dispatch_queue_t? = nil, eventFunction: EventFunction) {
        self.shouldPerformAsync = shouldAsync
        self.asyncQueue = queue
        self.eventFunction = eventFunction
        self.uuid = NSUUID().UUIDString
    }
    
    
    private func performAsync(event: EventWrapper) {
        if let queue = asyncQueue {
            dispatch_async(queue) {
                self.eventFunction(event)
            }
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                self.eventFunction(event)
            }
        }
        
    }
    
    private func performSync(event: EventWrapper) {
        eventFunction(event)
    }
    
    public func performEvent(event: EventWrapper) {
        if shouldPerformAsync {
            performAsync(event)
        } else {
            performSync(event)
        }
    }
    
}
//
//  Event.swift
//  LambdaUI
//
//  Created by Mislav Javor on 05/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation


public struct Event {

    public typealias EventFunction = (UIEvent) -> Void

    
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
    
    
    private func performAsync(event: UIEvent) {
        dispatch_async(asyncQueue!) {
            self.eventFunction(event)
        }
    }
    
    private func performSync(event: UIEvent) {
        eventFunction(event)
    }
    
    public func performEvent(event: UIEvent) {
        if shouldPerformAsync {
            performAsync(event)
        } else {
            performSync(event)
        }
    }
    
}
//
//  Event.swift
//  LambdaUI
//
//  Created by Mislav Javor on 05/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation


public struct Event<Parameters, ReturnValue> {

    public typealias EventFunction = (Parameters, UIEvent) -> ReturnValue?

    
    private var shouldPerformAsync : Bool = false
    private var asyncQueue : dispatch_queue_t? = dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
    private var eventFunction : EventFunction = { _ in return nil}
    public var uuid : String!
    
    init(shouldAsync: Bool = false, queue : dispatch_queue_t? = nil, eventFunction: EventFunction) {
        self.shouldPerformAsync = shouldAsync
        self.asyncQueue = queue
        self.eventFunction = eventFunction
        self.uuid = NSUUID().UUIDString
    }
    
    
    private func performAsync(params: Parameters, event: UIEvent) {
        dispatch_async(asyncQueue!) {
            self.eventFunction(params, event)
        }
    }
    
    private func performSync(params: Parameters, event: UIEvent) {
        eventFunction(params, event)
    }
    
    public func performEvent(params : Parameters, event: UIEvent) {
        if shouldPerformAsync {
            performAsync(params, event: event)
        } else {
            performSync(params, event: event)
        }
    }
    
}
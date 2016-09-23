//
//  Event.swift
//  LambdaUI
//
//  Created by Mislav Javor on 05/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation
import Dispatch

public struct Event {

    public typealias EventFunction = (EventWrapper) -> Void

    
    fileprivate var shouldPerformAsync : Bool = false
    fileprivate var asyncQueue : Dispatch.DispatchQueue? = DispatchQueue.global(qos: DispatchQoS.userInteractive.qosClass)
    fileprivate var eventFunction : EventFunction = { _ in }
    public var uuid : String!
    
    init(shouldAsync: Bool = false, queue : Dispatch.DispatchQueue? = nil, eventFunction: @escaping EventFunction) {
        self.shouldPerformAsync = shouldAsync
        self.asyncQueue = queue
        self.eventFunction = eventFunction
        self.uuid = UUID().uuidString
    }
    
    
    fileprivate func performAsync(_ event: EventWrapper) {
        if let queue = asyncQueue {
            queue.async {
                self.eventFunction(event)
            }
        } else {
            DispatchQueue.main.async {
                self.eventFunction(event)
            }
        }
        
    }
    
    fileprivate func performSync(_ event: EventWrapper) {
        eventFunction(event)
    }
    
    public func performEvent(_ event: EventWrapper) {
        if shouldPerformAsync {
            performAsync(event)
        } else {
            performSync(event)
        }
    }
    
}

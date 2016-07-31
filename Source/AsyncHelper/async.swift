//
//  async.swift
//  LambdaUI
//
//  Created by Mislav Javor on 06/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation

public struct async{
    
    public typealias asyncFuncSignature = (EventWrapper) -> Void
    
    var queue : dispatch_queue_t
    var eventFunction : asyncFuncSignature
    
    public init(funct: asyncFuncSignature) {
        queue = GlobalMainQueue
        eventFunction = funct
    }
    
    public init(queue: dispatch_queue_t, funct: asyncFuncSignature) {
        self.queue = queue
        eventFunction = funct
    }
    
    public init(queue: DispatchQueue, funct: asyncFuncSignature) {
        self.queue = queue.queue
        eventFunction = funct
    }
}

public enum DispatchQueue {
    
    case MainQueue, UserInteractiveQueue, UserInitiatedQueue, UtilityQueue, BackgroundQueue
    
    public var queue : dispatch_queue_t {
        switch self {
        case .MainQueue:
            return GlobalMainQueue
        case .UserInteractiveQueue:
            return GlobalUserInteractiveQueue
        case .UserInitiatedQueue:
            return GlobalUserInitiatedQueue
        case .UtilityQueue:
            return GlobalUtilityQueue
        case .BackgroundQueue:
            return GlobalBackgroundQueue
        }
    }
}

private var GlobalMainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
}

private var GlobalUserInteractiveQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
}

private var GlobalUserInitiatedQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
}

private var GlobalUtilityQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)
}

private var GlobalBackgroundQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
}

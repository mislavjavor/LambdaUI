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
    
    var queue : Dispatch.DispatchQueue
    var eventFunction : asyncFuncSignature
    
    public init(funct: @escaping asyncFuncSignature) {
        queue = Dispatch.DispatchQueue.main
        eventFunction = funct
    }
    
    public init(queue: Dispatch.DispatchQueue, funct: @escaping asyncFuncSignature) {
        self.queue = queue
        eventFunction = funct
    }
    
}

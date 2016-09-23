//
//  Operators.swift
//  LambdaUI
//
//  Created by Mislav Javor on 06/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation

public func += (left: inout [Event], right: @escaping (EventWrapper) -> Void) -> String {
	let newEvent = Event(eventFunction: right)
	left.append(newEvent)
	return newEvent.uuid
}

public func -= (left: inout [Event], right: String) -> Bool {
	for item in left.enumerated() {
		if item.element.uuid == right {
            left.remove(at: item.offset)
			return true
		}
	}
	return false
}

public func += (left: inout [Event], right: async) -> String {
	let newEvent = Event(shouldAsync: true, queue: right.queue, eventFunction: right.eventFunction)
	left.append(newEvent)
	return newEvent.uuid
}

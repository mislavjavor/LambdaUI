//
//  Operators.swift
//  LambdaUI
//
//  Created by Mislav Javor on 06/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation

public func += (inout left: [Event], right: (UIEvent) -> Void) -> String {
	let newEvent = Event(eventFunction: right)
	left.append(newEvent)
	return newEvent.uuid
}

public func -= (inout left: [Event], right: String) -> Bool {
	for item in left.enumerate() {
		if item.element.uuid == right {
			left.removeAtIndex(item.index)
			return true
		}
	}
	return false
}

public func += (inout left: [Event], right: async) -> String {
	let newEvent = Event(shouldAsync: true, queue: right.queue, eventFunction: right.eventFunction)
	left.append(newEvent)
	return newEvent.uuid
}
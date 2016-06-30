//
//  OperatorExtensions.swift
//  LambdaUI
//
//  Created by Mislav Javor on 30/06/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation

private var buttonEventsKey: UInt8 = 0
extension UIControl {
	
	/**
	 Property containing all of the events associated with a UIControl. Access the properties by assigning them via += or addHandler
	 */
	public var events: LDAControlHandler<UIControl> {
		get {
			return associatedObject(self, key: &buttonEventsKey) {
				return LDAControlHandler<UIControl>(control: self)
			}
		}
		set {
			associateObject(self, key: &buttonEventsKey, value: newValue)
		}
	}
}

func associatedObject<ValueType: AnyObject>(
	base: AnyObject,
	key: UnsafePointer<UInt8>,
	initialiser: () -> ValueType)
	-> ValueType {
		if let associated = objc_getAssociatedObject(base, key)
		as? ValueType { return associated }
		let associated = initialiser()
		objc_setAssociatedObject(base, key, associated,
				.OBJC_ASSOCIATION_RETAIN)
		return associated
}

func associateObject<ValueType: AnyObject>(
	base: AnyObject,
	key: UnsafePointer<UInt8>,
	value: ValueType) {
		objc_setAssociatedObject(base, key, value,
				.OBJC_ASSOCIATION_RETAIN)
}


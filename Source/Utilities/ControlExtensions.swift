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
	public var events: ControlHandler {
		get {
			return associatedObject(self, key: &buttonEventsKey) {
				return ControlHandler(control: self)
			}
		}
		set {
			associateObject(self, key: &buttonEventsKey, value: newValue)
		}
	}
}


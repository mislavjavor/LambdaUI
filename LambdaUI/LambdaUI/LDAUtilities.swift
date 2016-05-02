//
//  LDAUtilities.swift
//  LambdaUI
//
//  Created by Mislav Javor on 02/05/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import Foundation

public typealias LDAHandlerFunc = () -> Void

extension UIControlEvents : Hashable {
    
    public var hashValue : Int {
        get {
            return Int(self.rawValue)
        }
    }
    
}
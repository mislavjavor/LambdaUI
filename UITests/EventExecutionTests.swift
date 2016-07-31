//
//  UITests.swift
//  UITests
//
//  Created by Mislav Javor on 31/07/16.
//  Copyright © 2016 Mislav Javor. All rights reserved.
//

import XCTest
@testable import TestApp
import LambdaUI

class EventExecutionTests: XCTestCase {
    
    var vc: TestViewController!
    
    override func setUp() {
        super.setUp()

        vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TestViewController
        vc.loadView()
        vc.viewDidLoad()
    }
    
    func test_SingleSyncEvent() {
        
        let expectation = expectationWithDescription("Event has been triggered")
        
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func test_MultipleSyncEvents() {
        let firstExpectation = expectationWithDescription("First event triggered")
        let secondExpectation = expectationWithDescription("Second event triggered")
    
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            firstExpectation.fulfill()
        }
        
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            secondExpectation.fulfill()
        }
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func test_RemoveSyncEvent() {
        let notTriggeredExpectation = expectationWithDescription("Event not triggered")
        let triggeredExpectation = expectationWithDescription("Event triggered")
        
        let identifier = vc.testButton.events.touchUpInside += { _ in
            //Make sure first event doesn't trigger
            XCTAssertTrue(false)
        }
        
        //Second event not removed and should trigger
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            triggeredExpectation.fulfill()
        }
        
        //Remove first event
        vc.testButton.events.touchUpInside -= identifier
        
        dispatch_after(1, dispatch_get_main_queue(), {
            notTriggeredExpectation.fulfill()
        })
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        waitForExpectationsWithTimeout(1, handler: nil)
        
    }
    
    func test_AsyncEventsExecution() {
        
        var passedCounter = 0
        let expectation = expectationWithDescription("Main queue event triggered")
        
        //Default queue test
        vc.testButton.events.touchUpInside += async { _ in
            //Calls fullfill since it's on the main queue by default - thus being blocked by sleep
            expectation.fulfill()
        }
        
        
        //Syntactic sugar queues test
        vc.testButton.events.touchUpInside += async(queue: DispatchQueue.UserInitiatedQueue) { _ in
            passedCounter += 1
        }
        
        //Regular GCD queue test
        vc.testButton.events.touchUpInside += async(queue: dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)) { _ in
            passedCounter += 1
        }
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        sleep(1)
        
        XCTAssertTrue(passedCounter == 2)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func test_RemoveAsyncEvent() {
        
        let notTriggeredExpectation = expectationWithDescription("Event not triggered")
        let triggeredExpectation = expectationWithDescription("Event triggered")
        
        let identifier = vc.testButton.events.touchUpInside +=  async(queue: .UserInteractiveQueue){ _ in
            //Make sure first event doesn't trigger
            XCTAssertTrue(false)
        }
        
        //Second event not removed and should trigger
        vc.testButton.events.touchUpInside += async(queue: .BackgroundQueue){ _ in
            XCTAssertTrue(true)
            triggeredExpectation.fulfill()
        }
        
        //Remove first event
        vc.testButton.events.touchUpInside -= identifier
        
        dispatch_after(1, dispatch_get_main_queue(), {
            notTriggeredExpectation.fulfill()
        })
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        waitForExpectationsWithTimeout(1, handler: nil)
        
    }
    
    func test_removeFromEmpty() {
        
        vc.testButton.events.touchUpInside -= NSUUID().UUIDString
        
        XCTAssertTrue(true)
        
    }
    
    func test_RemoveSameIdentifierMultipleTimes() {
        
        let notTriggeredExpectation = expectationWithDescription("Event not triggered")
        let triggeredExpectation = expectationWithDescription("Control event triggered")
        
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            triggeredExpectation.fulfill()
        }
        
        let identifier = vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(false)
        }
        
        vc.testButton.events.touchUpInside -= identifier
        vc.testButton.events.touchUpInside -= identifier
        
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        dispatch_after(1, dispatch_get_main_queue()) {
            notTriggeredExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(5, handler: nil)
        
    }
}

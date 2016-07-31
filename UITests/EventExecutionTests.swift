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
    
    let queues : Set<DispatchQueue> = [
        .MainQueue,
        .BackgroundQueue,
        .UtilityQueue,
        .UserInitiatedQueue,
        .UserInteractiveQueue,
    ]
    
    override func setUp() {
        super.setUp()
        
        vc = nil
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TestViewController
        vc.loadView()
        vc.viewDidLoad()
    }
    
    func test_SingleSyncEvent() {
        
        let expectation = expectationWithDescription("Event has been triggered")
        
        vc.testButton.events.touchUpInside += { _ in
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
        let triggeredExpectation = expectationWithDescription("Event triggered")
        
        let identifier = vc.testButton.events.touchUpInside += { _ in
            //Make sure first event doesn't trigger
            XCTFail("Removed event was triggered")
        }
        
        //Second event not removed and should trigger
        vc.testButton.events.touchUpInside += { _ in
            triggeredExpectation.fulfill()
        }
        
        //Remove first event
        vc.testButton.events.touchUpInside -= identifier
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        waitForExpectationsWithTimeout(1, handler: nil)
        
    }
    
    
    
    func passForTouchUpInside(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectationWithDescription("TouchUpInside triggered asynchronously on \(control)")
            control.events.touchUpInside += async(queue: queue) { event in
                XCTAssert(event.type == .TouchUpInside)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectationWithDescription("TouchUpInside triggered synchronously on \(control)")
        control.events.touchUpInside += { event in
            XCTAssert(event.type == .TouchUpInside)
            syncExpectation.fulfill()
        }
        control.sendActionsForControlEvents(.TouchUpInside)
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func passForTouchDown(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectationWithDescription("TouchDown triggered asynchronously on \(control)")
            control.events.touchDown += async(queue: queue) { event in
                XCTAssert(event.type == .TouchDown)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectationWithDescription("TouchDown triggered synchronously on \(control)")
        control.events.touchDown += { event in
            XCTAssert(event.type == .TouchDown)
            syncExpectation.fulfill()
        }
        control.sendActionsForControlEvents(.TouchDown)
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func passForValueChanged(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectationWithDescription("ValueChanged triggered asynchronously on \(control)")
            control.events.valueChanged += async(queue: queue) { event in
                XCTAssert(event.type == .ValueChanged)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectationWithDescription("ValueChanged triggered synchronously on \(control)")
        control.events.valueChanged += { event in
            XCTAssert(event.type == .ValueChanged)
            syncExpectation.fulfill()
        }
        control.sendActionsForControlEvents(.ValueChanged)
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func passForAllEditingEvents(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectationWithDescription("AllEditingEvents triggered asynchronously on \(control)")
            control.events.allEditingEvents += async(queue: queue) { event in
                XCTAssert(event.type == .AllEditingEvents)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectationWithDescription("AllEditingEvents triggered synchronously on \(control)")
        control.events.allEditingEvents += { event in
            XCTAssert(event.type == .AllEditingEvents)
            syncExpectation.fulfill()
        }
        control.sendActionsForControlEvents(.AllEditingEvents)
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func passForAllEvents(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectationWithDescription("AllEvents triggered asynchronously on \(control)")
            control.events.allEvents += async(queue: queue) { event in
                XCTAssert(event.type == .AllEvents)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectationWithDescription("AllEvents triggered synchronously on \(control)")
        control.events.allEvents += { event in
            XCTAssert(event.type == .AllEvents)
            syncExpectation.fulfill()
        }
        control.sendActionsForControlEvents(.AllEvents)
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func makeFullEventTriggerRun(withControl control: UIControl) {
        passForTouchUpInside(withControl: control)
        passForTouchDown(withControl: control)
        passForValueChanged(withControl: control)
        passForAllEditingEvents(withControl: control)
        //passForAllEvents(withControl: control)
    }
    
    func test_UIButtonEvents() {
        let control = vc.testButton
        makeFullEventTriggerRun(withControl: control)
        
    }
    
    func test_UIStepperEvents() {
        let control = vc.testStepper
        makeFullEventTriggerRun(withControl: control)

    }
    
    func test_UISwitchEvents() {
        let control = vc.testSwitch
        makeFullEventTriggerRun(withControl: control)

    }
    
    func test_UISegmentedControlEvents() {
        let control = vc.testSegmentedControl
        makeFullEventTriggerRun(withControl: control)
    }
    
    func test_UISliderEvents() {
        let control = vc.testSlider
        makeFullEventTriggerRun(withControl: control)
    }
    
    func test_UIPageControlEvents() {
        let control = vc.testPageControl
        makeFullEventTriggerRun(withControl: control)
    }
    
    func test_UITextFieldEvents() {
        let control = vc.testTextField
        makeFullEventTriggerRun(withControl: control)


    }
    
    func test_UIDatePickerEvents() {
        let control = vc.testDatePicker
        makeFullEventTriggerRun(withControl: control)


    }
    
    
    
    
    func test_RemoveAsyncEvent() {
        
        let triggeredExpectation = expectationWithDescription("Event triggered")
        
        let identifier = vc.testButton.events.touchUpInside +=  async(queue: .UserInteractiveQueue){ event in
            //Make sure first event doesn't trigger
            XCTFail("Non removed event triggered")
        }
        
        //Second event not removed and should trigger
        vc.testButton.events.touchUpInside += async(queue: .BackgroundQueue){ event in
            XCTAssertTrue(event.type == .TouchUpInside)
            triggeredExpectation.fulfill()
        }
        
        //Remove first event
        vc.testButton.events.touchUpInside -= identifier
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        waitForExpectationsWithTimeout(1, handler: nil)
        
    }
    
    func test_removeFromEmpty() {
        
        let firstCount = vc.testButton.events.touchUpInside.count
        
        vc.testButton.events.touchUpInside -= NSUUID().UUIDString
        
        XCTAssertTrue(vc.testButton.events.touchUpInside.count == firstCount)
        
    }
    
    func test_RemoveSameIdentifierMultipleTimes() {
        
        let triggeredExpectation = expectationWithDescription("Control event triggered")
        
        vc.testButton.events.touchUpInside += { _ in
            triggeredExpectation.fulfill()
        }
        
        let identifier = vc.testButton.events.touchUpInside += { event in
            XCTAssertTrue(event.type == .TouchUpInside)
            XCTFail("Triggered event that was removed")
        }
        
        let initialCount = vc.testButton.events.touchUpInside.count
        vc.testButton.events.touchUpInside -= identifier
        let midCount = vc.testButton.events.touchUpInside.count
        vc.testButton.events.touchUpInside -= identifier
        let lateCount = vc.testButton.events.touchUpInside.count
        
        
        if midCount != (initialCount - 1) {
            XCTFail("Didnt remove event from handler")
        }
        
        if lateCount != midCount {
            XCTFail("Removed nonexisting event from handler")
        }
        
        vc.testButton.sendActionsForControlEvents(.TouchUpInside)
        
        
        waitForExpectationsWithTimeout(1, handler: nil)
        
    }
    
    
}



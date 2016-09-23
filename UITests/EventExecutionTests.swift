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
    
    let queues = [
        DispatchQueue.main,
        DispatchQueue.global(qos: DispatchQoS.background.qosClass),
        DispatchQueue.global(qos: DispatchQoS.userInteractive.qosClass)
    ]
    
    override func setUp() {
        super.setUp()
        
        vc = nil
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TestViewController
        vc.loadView()
        vc.viewDidLoad()
    }
    
    func test_SingleSyncEvent() {
        
        let expectation = self.expectation(description: "Event has been triggered")
        
        _ = vc.testButton.events.touchUpInside += { _ in
            expectation.fulfill()
        }
        
        vc.testButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_MultipleSyncEvents() {
        let firstExpectation = expectation(description: "First event triggered")
        let secondExpectation = expectation(description: "Second event triggered")
        
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            firstExpectation.fulfill()
        }
        
        vc.testButton.events.touchUpInside += { _ in
            XCTAssertTrue(true)
            secondExpectation.fulfill()
        }
        
        vc.testButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_RemoveSyncEvent() {
        let triggeredExpectation = expectation(description: "Event triggered")
        
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
        
        vc.testButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    
    
    func passForTouchUpInside(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectation(description: "TouchUpInside triggered asynchronously on \(control)")
            control.events.touchUpInside += async(queue: queue) { event in
                XCTAssert(event.type == .touchUpInside)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectation(description: "TouchUpInside triggered synchronously on \(control)")
        control.events.touchUpInside += { event in
            XCTAssert(event.type == .touchUpInside)
            syncExpectation.fulfill()
        }
        control.sendActions(for: .touchUpInside)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func passForTouchDown(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectation(description: "TouchDown triggered asynchronously on \(control)")
            control.events.touchDown += async(queue: queue) { event in
                XCTAssert(event.type == .touchDown)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectation(description: "TouchDown triggered synchronously on \(control)")
        control.events.touchDown += { event in
            XCTAssert(event.type == .touchDown)
            syncExpectation.fulfill()
        }
        control.sendActions(for: .touchDown)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func passForValueChanged(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectation(description: "ValueChanged triggered asynchronously on \(control)")
            control.events.valueChanged += async(queue: queue) { event in
                XCTAssert(event.type == .valueChanged)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectation(description: "ValueChanged triggered synchronously on \(control)")
        control.events.valueChanged += { event in
            XCTAssert(event.type == .valueChanged)
            syncExpectation.fulfill()
        }
        control.sendActions(for: .valueChanged)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func passForAllEditingEvents(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectation(description: "AllEditingEvents triggered asynchronously on \(control)")
            control.events.allEditingEvents += async(queue: queue) { event in
                XCTAssert(event.type == .allEditingEvents)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectation(description: "AllEditingEvents triggered synchronously on \(control)")
        control.events.allEditingEvents += { event in
            XCTAssert(event.type == .allEditingEvents)
            syncExpectation.fulfill()
        }
        control.sendActions(for: .allEditingEvents)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func passForAllEvents(withControl control : UIControl) {
        for queue in queues {
            let asyncExpectation = expectation(description: "AllEvents triggered asynchronously on \(control)")
            control.events.allEvents += async(queue: queue) { event in
                XCTAssert(event.type == .allEvents)
                asyncExpectation.fulfill()
            }
        }
        let syncExpectation = expectation(description: "AllEvents triggered synchronously on \(control)")
        control.events.allEvents += { event in
            XCTAssert(event.type == .allEvents)
            syncExpectation.fulfill()
        }
        control.sendActions(for: .allEvents)
        waitForExpectations(timeout: 2, handler: nil)
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

        makeFullEventTriggerRun(withControl: control!)
        
    }
    
    func test_UIStepperEvents() {
        let control = vc.testStepper
        makeFullEventTriggerRun(withControl: control!)

    }
    
    func test_UISwitchEvents() {
        let control = vc.testSwitch
        makeFullEventTriggerRun(withControl: control!)

    }
    
    func test_UISegmentedControlEvents() {
        let control = vc.testSegmentedControl
        makeFullEventTriggerRun(withControl: control!)
    }
    
    func test_UISliderEvents() {
        let control = vc.testSlider
        makeFullEventTriggerRun(withControl: control!)
    }
    
    func test_UIPageControlEvents() {
        let control = vc.testPageControl
        makeFullEventTriggerRun(withControl: control!)
    }
    
    func test_UITextFieldEvents() {
        let control = vc.testTextField
        makeFullEventTriggerRun(withControl: control!)


    }
    
    func test_UIDatePickerEvents() {
        let control = vc.testDatePicker
        makeFullEventTriggerRun(withControl: control!)


    }
    
    
    
    
    func test_RemoveAsyncEvent() {
        
        let triggeredExpectation = expectation(description: "Event triggered")
        
        let identifier = vc.testButton.events.touchUpInside +=  async(queue: .global(qos: .userInteractive)){ event in
            //Make sure first event doesn't trigger
            XCTFail("Removed event triggered")
        }
        
        //Second event not removed and should trigger
        vc.testButton.events.touchUpInside += async(queue: .global(qos: .background)){ event in
            XCTAssertTrue(event.type == .touchUpInside)
            triggeredExpectation.fulfill()
        }
        
        //Remove first event
        vc.testButton.events.touchUpInside -= identifier
        
        vc.testButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_removeFromEmpty() {
        
        let firstCount = vc.testButton.events.touchUpInside.count
        
        vc.testButton.events.touchUpInside -= UUID().uuidString
        
        XCTAssertTrue(vc.testButton.events.touchUpInside.count == firstCount)
        
    }
    
    func test_RemoveSameIdentifierMultipleTimes() {
        
        let triggeredExpectation = expectation(description: "Control event triggered")
        
        vc.testButton.events.touchUpInside += { _ in
            triggeredExpectation.fulfill()
        }
        
        let identifier = vc.testButton.events.touchUpInside += { event in
            XCTAssertTrue(event.type == .touchUpInside)
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
        
        vc.testButton.sendActions(for: .touchUpInside)
        
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    
}



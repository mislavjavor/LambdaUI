# LambdaUI

Lambda driven event handling in CocoaTouch framework

## 1. Goals

### 1.1 Short term (MVP)
- Have all `UIControl` instances wrapped in a lambda event handler
- Have `UITableView` and `UICollectionView` controller, delegate and data source wrapped in lambda event handlers
- Have CocoaPods compatibility

### 1.2 Longer term
- Have Swift Package Manager compatibiltiy
- Have Asynchronous versions of event lambdas working with GCD
- Have all events wrapped as with lambdas

## 2. Usage

## 2.1 `UIControl`

### 2.1.1 Preparation

In the `storyboard`, change the class of the UIControl to the equivalent LambdaUI control.

### 2.1.2 Standard usage

UIButton equivalent is called `LDAButton`. Drag the outlet and call use the method like this

```swift
button.events.touchUpInside = { button, event in
    self.view.backgroundColor = UIColor.purpleColor()
    print(event)
}
```

### 2.1.3 Event invalidation / chaining

Have one event start waiting for some action only after another element has been played, or invalidate the current event 

```swift
// Invalidation example
stepper.events.valueChanged = { stepper, event in 
    self.view.backgroundColor = UIColor.redColor()
    stepper.events.valueChanged = { _ in }
}
```

```swift
// Chaining example
stepper.events.valueChanged = { stepper, event in
    self.view.backgroundColor = UIColor.redColor()
    stepper.events.touchDown = { _ in
        self.view.backgroundColor = UIColor.blueColor()
    }
}
```

Your usage can be the same as with the usual methods, the only different thing is the assignment

```swift
class SomeVC : ... {
    @IBOutlet weak var someButton : LDAButton!
    ...
    
    override viewDidLoad ... {
        someButton.events.touchUpInside = someButtonClicked
    }
    
    func someButtonClicked(button : LDAButton, event : UITouchEvent) {
        // Handle
    }
}
```
The usage will be equivalent for all the other `UIControl` instances once the wrappers are made

### 2.1.? Not yet implemented, example syntax

#### 2.1.?.1 Multiple lambdas for the same event

```swift
let eventIdentifier = button.events.touchUpInside += { stepper, event in 
    // Handle some work
}

let otherIdentifier = button.events.touchUpInside += { stepper, event in
    //Handle some other work
}

// Temporarily stopping events
button.events.touchUpInside.makeIdle(eventIdentifier)

// Reassigning events
button.events.touchUpInside.resume(eventIdentifier)

// Removing events
button.events.touchUpInside -= eventIdentifier
// Alternate syntax
button.events.touchUpInside.remove(eventIdentifier)
```

#### 2.1.?.2 Automatic asynchronous event handling

Library should use GCD for aynchronous event dispatching

```swift
let eventHandler = button.events.touchUpInside += async { button, event in
    // Perform event asynchronously
}
// Alternate syntax
let anotherHandler = button.events.touchUpInside.addAsyncEventHandler { button, event in
    // Do sth
}

let otherHandler = button.events.touchUpInside += async { button, event in
    // Once called, these actions will be performed concurrently
}

// Define a running queue for the action (NOTE: If the return value is ignored is ommited, you cannot control the event)
button.events.touchUpInside += async(dispatch_get_global_queue(Int(queueName)) { button, event
    // Handle
}

// Helper enums
button.events.touchUpInside += async(.UtilityQueue) { button, event in
    // Handle
}

// Alternative syntax
button.events.touchUpInside.addAsyncEventHandler(.UtilityQueue) {
    // Handle
}
```


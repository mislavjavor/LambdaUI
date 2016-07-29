# LambdaUI


![Logo](http://i.imgur.com/90cVzLB.png)

[![Version](https://img.shields.io/cocoapods/v/LambdaUI.svg?style=flat)](http://cocoapods.org/pods/LambdaUI)

## Requirements

Minimum `iOS 8.0`

## Example

To run the example project, clone the repo, and open `LambdaUI.xcworkspace`

## Installation

LambdaUI is available through [CocoaPods](http://cocoapods.org). To install
it, add the following line to your Podfile:

```ruby
pod "LambdaUI"
```

## What is LambdaUI?

LambdaUI is an closure driven event handling framework for Swift. It reduces the effort needed when assigning events to UI elements in Swift. It also features easy and intuitive GCD support.

## Why do it this way?


In my personal opinion, the event system in iOS/CocoaTouch is somewhat broken. It leads to unreadable code and creates clutter. The long term goal of this library is to cover all the events in the CocoaTouch framework as lambda functions.

Having badly designed code forces you to focus on the syntax instead of thinking about the algorithm and implementation.

This library attempts to shift the developers focus from the syntax and onto the algorithm
### Setup

Once you've added the `LambdaUI` framework to your project, a new `events` property will be available on all instances of `UIControl` objects (for example, `UIButton`, `UIStepper`, `UISlider`, etc.). This property contains all of the supported events for a given `UIControl`

### 1. Easy and intuitive events in CocoaTouch

Adding targets and `#selector(...)` arguments is sometimes cumbersome. Dragging outlets can be worse; you have to look at the storyboard to see what's related to what and no functionality can be seen at a glance.

That's where LambdaUI comes into play!

Add events simply by calling the `+=` operator on the `<event name>` property of the  `events` property of your `view`
```swift
let button = UIButton(frame : CGRect(...))
button.events.touchUpInside += { button, event in
    // Handle event here
}
```

### 2. Easily handle multiple events

There are situations when you need to add multiple events to a single `view`. LambdaUI handles this with ease.


```swift
@IBOutlet weak var button : UIButton!
...
...
... viewDidLoad ...{
    button.events.touchUpInside += { _ in
        // Event no. 1
    }

    button.events.touchUpInside += { _ in
        // Event n0. 2 -> triggered synchronously after the first event is complete
    }
}
```

### 3. Manage (add/remove) events easily
Event management has never been easier. Add events with the `+=` operator which returns the unique identifier of each event. Then when you want, delete the event with the `-=` operator, simply by calling `<view>.events.<event name> -= <event identifier>` . This gives you expressiveness and freedom to do conditional event assignment and removal, recursive event creation, etc.

```swift
let stepper = UIStepper(...)

let eventOneIdentifier = stepper.events.valueChanged += { _, event in
    // Do first event
}

let eventTwoIdentifier = stepper.events.touchUpInside += { stepper, event in
    // Do second event
    stepper.events.valueChanged -= eventOneIdentifier // Remove the first event -> when value changes, it wont be fired again
}
```

### 4. Paineless Asynchronous event management using GCD
Asynchronous event management can be tiring with CocoaTouch. You need to define a function which then takes another function (or a block of code) that is executed on a queue that you need. Also, the queue names are inherited from C and don't fit the Swift syntax nicely (`dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)` + putting that into `dispatch_async(...)` - it gets really long really fast)


Async events support all of the features (remove/add/identifiers/management) that the "regular" events support

LambdaUI makes adding async events extremely easy
```swift
@IBOutlet weak var slider : UISlider!
...
...
...viewDidLoad...{
    // Add an async event (defaults to Main Queue)
    slider.events.valueChanged += async { _ in
        // Do stuff async
    }
    let identifier = slider.events.valueChanged += async { _ in
        // These two events will be done concurrently
    }

    // Add to a gloabl queue with helper enum
    slider.events.valueChanged += async(queue: .UserInteractiveQueue) { _ in
        // Do stuff on user interactive queue
    }

    // Add to any dispatch_queue_t
    let queue = dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
    slider.events.valueChanged += async(queue) { _ in
        slider.events.valueChanged -= identifier // Remove the async event normally
    }
}
```

## Contributing
Any contributions are welcome. Just respect the usual contribution etiquette. Submit a pull request and it will be reviewed as soon as possible.

## Author

Mislav Javor, mislav.javor@outlook.com

## License

LambdaUI is available under the MIT license. See the LICENSE file for more info.

# LambdaUI

[![Version](https://img.shields.io/cocoapods/v/LambdaUI.svg?style=flat)](http://cocoapods.org/pods/LambdaUI)

![Logo](http://i.imgur.com/cGwZ8w2.png)

## Note

The project is still under construction - the final product should include stuff like TableView, CollectionView, ViewControllers etc... or maybe not, I'm still considering some stuff. Anyway, think of this as the showcase, and expect more to come

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

LambdaUI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LambdaUI"
```

## What is LambdaUI

LambdaUI is an lambda driven event handling framework for Swift. (Obj-C support coming soon!)
It dramatically reduces the effort needed when assiging events to UI elements in Swift

## Why do it this way

In my personal opinion, the event system in iOS/CocoaTouch is severely broken. It leads to unreadable code and creates clutter. The long term goal of this library is to cover all the events in the CocoaTouch framework as lambda functions

### Setup

In order for your component to be able to use the `LambdaUI` framework either:

1. Go to the storyboard and change the `class` of the view with the equivalent `LambdaUI` view. E.g. change the `UIButton` class to `LDAButton`. This pattern is respected everywhere, so `UIStepper` becomes `LDAStepper` and `UISegmentedControl` becomes `LDASegmentedControl` etc...
2. Initialize your element as the `LambdaUI` equivalent. For example `let button = LDAButton(frame: CGRect(...))`

### 1. Pain free events in CocaTouch
Adding targets and `#selector(...)` arguments is cumbersome and stupid. Dragging outlets is even worse - you must look at the storyboard to see what is related to what and no functionallity is glanceable. A modern framework should have a better way of handling these issues.

That's where LambdaUI comes into play

Ad events simply by calling the `+=` operator on the `<event name>` property of the  `events` propery of you `view`
```swift
let button = LDAButton(frame : CGRect(...))
button.events.touchUpInside += { button, event in
    // Handle event here
}
```

### 2. Easily handle multiple events
There are situations when you need to add multiple events to a single `view`. Current `CocoaTouch` behaves terribly in this regard also. LambdaUI handles this with ease

```swift
@IBOutlet weak var button : LDAButton!
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
Event management has never been easier. Add events with the `+=` operator which returns the unique identifier of each event. Then when you want, delete the event with the `-=` operator, simply by calling `<view>.events.<event name> -= <event identifier>` . This gives you expressivenes and freedom to do conditional event assignement and removal, recursive event creation, etc...

```swift
let stepper = LDAStepper(...)

let eventOneIdentifier = stepper.events.valueChanged += { _, event in 
    // Do first event
}

let eventTwoIdentifier = stepper.events.touchUpInside += { stepper, event in
    // Do second event
    stepper.events.valueChanged -= eventOneIdentifier // Remove the first event -> when value changes, it wont be fired again
}
```

### 4. Paineless Asynchronous event management using GCD
Asynchronous event management is a pain the ass with CocoaTouch. You need to define a function which then takes another function (or a block of code) that is executed on a queue that you need. Also, the queue names are unnecessarily ugly (`dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)` + putting that into `dispatch_async(...)` - come ON, give me a break)

Async events support all of the features (remove/add/identifiers/management) that the "regular" events support

LambdaUI makes adding async events extremely easy
```swift
@IBOutlet weak var slider : LDASlider!
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
Any contributions are welcome. Just respect the usual contribution etiquette. Submit a pull request and it will be reviewed as soon as possible

## Author

Mislav Javor, mislav.javor@outlook.com

## License

LambdaUI is available under the MIT license. See the LICENSE file for more info.

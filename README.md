# LambdaUI


![Logo](https://i.imgur.com/4Iubz3e.png)

[![Version](https://img.shields.io/cocoapods/v/LambdaUI.svg?style=flat)](http://cocoapods.org/pods/LambdaUI)
[![Build Status](https://travis-ci.org/mislavjavor/LambdaUI.svg?branch=master)](https://travis-ci.org/mislavjavor/LambdaUI)
[![Coverage Status](https://coveralls.io/repos/github/mislavjavor/LambdaUI/badge.svg?branch=add-control-sender)](https://coveralls.io/github/mislavjavor/LambdaUI?branch=master)

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

### Setup

Once you've added the `LambdaUI` framework to your project, a new `events` property will be available on all instances of `UIControl` objects (for example, `UIButton`, `UIStepper`, `UISlider`, etc.). This property contains all of the supported events for a given `UIControl`

## Using LambdaUI

### Add events to `UIControl` instances

```swift
let button = UIButton()
button.events.touchUpInside += { _ in
  print("Touched the button")
}
```

### Remove added events easily

```swift
let stepper = UIStepper()
let eventIdentidier = stepper.events.valueChanged += { _ in
  print("Stepper changed value")
}

if shouldDisableStepperEvents {
  stepper.events.valueChanged -= eventIdentidier
}
```

### Easily add async events

```swift
let slider = UISlider()
slider.events.valueChanged += async {
  print("async event")
}

slider.events.valueChanged += async(queue: .UserInteractiveQueue) { _ in
  print("async event on user interactive queue")
}
```

### Mix and match/add multiple events

```swift
@IBOutlet weak var button : UIButton!

override func viewDidLoad() {
  super.viewDidLoad()
  let firstEventIdentifier = button.events.touchUpInside += { _ in
    print("Do first event")
  }

  button.events.touchUpInside += async(queue: .BackgroundQueue) { _ in
    //Disable first event once the second event has been triggered
    button.events.touchUpInside -= firstEventIdentifier
  }
}
```

## Contributing
Any contributions are welcome. Just respect the usual contribution etiquette. Submit a pull request and it will be reviewed as soon as possible.

## Author

Mislav Javor, mislav.javor@outlook.com

## License

LambdaUI is available under the MIT license. See the LICENSE file for more info.

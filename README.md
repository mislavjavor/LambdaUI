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

The usage will be equivalent for all the other `UIControl` instances once the wrappers are made



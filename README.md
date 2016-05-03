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

In the `storyboard`, change the class of the UIControl to the equivalent LambdaUI control. 

UIButton equivalent is called `LDAButton`. Drag the outlet and call use the method like this

```swift
button.events.touchUpInside = { button, event in
    self.view.backgroundColor = UIColor.purpleColor()
    print(event)
}
```

The usage will be equivalent for all the other `UIControl` instances once the wrappers are made



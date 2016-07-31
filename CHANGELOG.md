# CHANGELOG

## 1.x.x versions

### 1.1.0

* Refactored library to match Swift naming better
  * Changed `LDA[ClassName]` to `[ClassName]`. e.g. `LDAEvent` to `Event`
* Added testing and Travis CI integration

### 1.0.0

* Moved the library from wrapper form (`LDAButton(button...)`) to being an extension on the instances of `UIControl`
* Fixed bug where ARC would deallocate objects before being used

## Pre 1.0.0 versions

Undocumented

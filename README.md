
# Cahcing Library
> An easy to use and integrate image and JSON library

[![Swift Version][swift-image]][swift-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)



## Features

- [x] Cache Image
- [x] Cache JSON
- [x] Load image in a collectionView
- [x] Custom transition animation

## Requirements

- iOS 9.0+
- Xcode 10.0

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `CacheFramework` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'CacheFramework', :path => '../CacheFramework'
```


``` swift
import UIKit
import CacheFramework
```

```
github "sagaya/CacheLibrary"
```
#### Manually
1. Download and drop ```CacheFramework``` folder in your project.
2. Congratulations!

## Usage example

```swift
import CacheFramework
imageView.setImage(withUrl: url, placeholder: nil)
```

## Contribute

We would love you for the contribution to **CacheFramework**

## Meta

Sagaya Abdulhafeez – [@Twitter](https://twitter.com/sagaya_hafeez) – shaggy.hafeez@gmail.com



[swift-image]:https://img.shields.io/badge/swift-swift%204-yellow.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com

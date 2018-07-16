# Bohrium

![Bohrium](Assets/logo.png)

Bohrium is part of the **[E-sites iOS Suite](https://github.com/e-sites/iOS-Suite)**.

---

A small helper class to benchmark specific code parts at runtime.

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/built-with-swag.svg)](http://forthebadge.com)

[![Platform](https://img.shields.io/cocoapods/p/Bohrium.svg?style=flat)](http://cocoadocs.org/docsets/Bohrium)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Bohrium.svg)](http://cocoadocs.org/docsets/Bohrium)
[![Quality](https://apps.e-sites.nl/cocoapodsquality/Bohrium/badge.svg?004)](https://cocoapods.org/pods/Bohrium/quality)
[![Travis-ci](https://travis-ci.org/e-sites/Bohrium.svg?branch=master&001)](https://travis-ci.org/e-sites/Bohrium)


# Installation

Podfile:

```ruby
pod 'Bohrium'
```

And then

```
pod install
```

# Implementation

```swift
import Bohrium

let timer = Bohrium.Timer(name: "APIRequest")

Alamofire.request("https://httpbin.org/get").responseJSON { response in
   timer.tick("Response received")
   
   YourSpecialParser.parse(response) { result in
   	   timer.stop("Parser finished")
   }
}
```

Would result into something like this:

```
[Bohrium] 🔫 Start 'APIRequest' 
[Bohrium] ⏱ 'APIRequest' at 1.036: "Response received" (+ 1.036)
[Bohrium] 🏁 'APIRequest' at 2.346: "Parser finished" (+ 1.309)
```
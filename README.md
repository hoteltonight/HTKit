HTKit
=====

#### HTKit is a collection of 8 podspecs published by the HotelTonight iOS team:

* [HTAutocompleteTextField](https://github.com/hoteltonight/HTAutocompleteTextField) is a subclass of UITextField that automatically displays text suggestions in real-time.

* [HTRasterView](https://github.com/hoteltonight/HTRasterView) is a rasterization system that caches rendered components based on state.

* [HTGraphics](https://github.com/hoteltonight/HTGraphics) is a set of tools for drawing custom UI elements, allowing you to do cool things like highlight an arbitrary UIBezierPath.

* [HTCoreImage](https://github.com/hoteltonight/HTCoreImage) is a collection of convenience categories for Core Image. There are convenience constructors for every filter, annotated with NS_AVAILABLE_SINCE() macros so you know what's in iOS 5 vs iOS 6.

* [HTDelegateProxy](https://github.com/hoteltonight/HTDelegateProxy) is an NSProxy subclass that allows you to assign multiple delegates to a single source.  Void return type messages are sent to all delegates.

* [HTGradientEasing](https://github.com/hoteltonight/HTGradientEasing) allows you to easily add smooth easing to CAGradientLayers, like SineEaseInOut.

* [HTUpdateAggregator](https://github.com/hoteltonight/HTUpdateAggregator) improves update logic in NSObject/UIView/UIViewController subclasses.

* [HTCopyableLabel](https://github.com/hoteltonight/HTCopyableLabel) is a subclass of UILabel that makes it easy to allow users to copy a label's text.

This project serves as a collection podspec and a centralized demo project for our published code.  If you don't use cocoapods, refer to the individual repos above for installation.

## Installation

Add the following line to your podfile:
```
pod 'HTKit'
```

## Contributions welcome!

## Use it? Love/hate it?

Tweet the authors [@jakej](https://twitter.com/jakej), [@jonsibs](https://twitter.com/jonsibs), [@raylillywhite](https://twitter.com/RayLillywhite) and [@lavoy](https://twitter.com/lavoy), and check out HotelTonight's engineering blog: http://engineering.hoteltonight.com

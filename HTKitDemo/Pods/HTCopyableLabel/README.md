HTCopyableLabel
===============
<img src="https://raw.github.com/hoteltonight/HTCopyableLabel/master/ht-logo-black.png" alt="HotelTonight" title="HotelTonight" style="display:block; margin: 10px auto 30px auto;">

## Overview

HTCopyableLabel is a subclass of UILabel that makes it easy to allow users to copy a label's text.

<img src="https://raw.github.com/hoteltonight/HTCopyableLabel/master/demo.gif" alt="HotelTonight" title="HTAutocompleteTextField in action" style="display:block; margin: 10px auto 30px auto; align:center">

Read the accompanying [blog post](http://engineering.hoteltonight.com/htcopyablelabel/) on the [HotelTonight Engineering Blog](http://engineering.hoteltonight.com/).  For an excellent explanation how copying on a UILabel is implemented, be sure to read [UIMenuController](http://nshipster.com/uimenucontroller/) on [NSHipster](http://nshipster.com).

# Usage

## Installation

### With Cocoapods:
* Add `pod 'HTCopyableLabel'` to your `Podfile`

### Without Cocoapods:
Manually add the following files into your project:
* `HTCopyableLabel.m`
* `HTCopyableLabel.h`

## Quickstart Guide

Create an `HTCopyableLabel` instance exactly as as you would `UILabel`, or subclass `HTCopyableLabel` if you'd like.  You can do this or in Interface Builder.  Programmatically, this looks like:

    HTCopyableLabel *copyableLabel = [[HTCopyableLabel alloc] init];
    [self.view addSubview:copyableLabel];
    
Now, long pressing on the label will make a UIMenuController appear with a "Copy" option.  Pressing "Copy" will copy the label's `text`.  Make sure the superview of the label has `userInteractionEnabled` set to `YES`.

## Advanced Usage

Implementing the `HTCopyableLabelDelegate` protocol allows you more fine-tuned control of the `UIMenuController`'s position, as well as the actual string that is to be copied.

### UIMenuController appearance and position

`UIMenuController` positions itself according to a frame passed to it by `HTCopyableLabel`.  By default, `HTCopyableLabel` will pass its own bounds.  To specify the frame explicitly, implement the following in your `HTCopyableLabelDelegate`:

    - (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(HTCopyableLabel *)copyableLabel
    
Furthermore, `UIMenuController` will try to intelligently position itself above, below, or along side the frame you pass it according to its position within the screen.  If you wish to override this behavior, you should set `[HTCopyableLabel copyMenuArrowDirection]` explicitly.

### Specifying the text to be copied

If you wish to specify which string is copied to the pasteboard, implement the following method in your `HTCopyableLabelDelegate`:

    - (NSString *)stringToCopyForCopyableLabel:(HTCopyableLabel *)copyableLabel
    
# Etc.

* Use this in your apps whenever you can, particularly email addresses -- your users will appreciate it!
* Contributions are very welcome.
* Attribution is appreciated (let's spread the word!), but not mandatory.

## Use it? Love/hate it?

Tweet the author @jonsibs, and check out HotelTonight's engineering blog: http://engineering.hoteltonight.com

Also, check out HotelTonight's other iOS open source:
* https://github.com/hoteltonight/HTAutocompleteTextField
* https://github.com/hoteltonight/HTGradientEasing
* https://github.com/hoteltonight/HTStateAwareRasterImageView
* https://github.com/hoteltonight/HTDelegateProxy

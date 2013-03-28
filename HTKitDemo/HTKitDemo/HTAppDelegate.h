//
//  HTAppDelegate.h
//  HTKitDemo
//
//  Created by Jacob Jennings on 3/23/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTViewController;

@interface HTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HTViewController *viewController;

@end

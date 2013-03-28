//
//  HTExampleTableViewController.h
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTExampleTableViewController : UIViewController

@property (nonatomic, assign) BOOL shouldCARasterize;

- (id)initWithCellClass:(Class)cellClass;

@end

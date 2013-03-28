//
//  HTExampleTableCell.h
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTExampleRasterizableComponent.h"
#import "HTExampleTableCellProtocol.h"

static NSString * const HTExampleTableCellReuseIdentifier = @"HTExampleTableCellReuseIdentifier";

@interface HTExampleTableCell : UITableViewCell <HTExampleTableCellProtocol>

@end

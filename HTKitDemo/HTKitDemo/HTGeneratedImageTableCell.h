//
//  HTGeneratedImageTableCell.h
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/7/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const HTGeneratedImageTableCellReuseIdentifier = @"HTGeneratedImageTableCellReuseIdentifier";

@interface HTGeneratedImageTableCell : UITableViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *cacheKey;

@end

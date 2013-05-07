//
//  HTHighlightedShapeView.h
//  HotelTonight
//
//  Created by Jacob Jennings on 12/29/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

//  An 'inner shadow' effect or a mask-and-fill for highlight effects on arbitrary shapes.

#import <UIKit/UIKit.h>
#import "HTRasterView.h"

typedef NS_ENUM(NSInteger, HTHighlightedShapeViewStyle)
{
    HTHighlightedShapeViewStyleInnerShadow,
    HTHighlightedShapeViewStyleFill
};

@class HTHighlightedShapeView;

@protocol HTHighlightedShapeViewDataSource <NSObject>

- (UIBezierPath *)highlightedShapeView:(HTHighlightedShapeView *)shapeView pathForSize:(CGSize)size;

// Must be a clockwise closed path if you want it inverted.
- (UIBezierPath *)highlightedShapeView:(HTHighlightedShapeView *)shapeView highlightPathForSize:(CGSize)size highlightThickness:(CGFloat)highlightThickness;

@optional
// Name the path type (ex. "Circle" or "RoundedRectWithCornerRadius:6").  It's not worth it to programmatically describe UIBezierPath for caching.
- (NSString *)pathTypeDescriptionForHighlightedShapeView:(HTHighlightedShapeView *)shapeView;

@end

@interface HTHighlightedShapeView : UIView <HTRasterizableView>

 // If rasterizing with HTRasterView, this must conform to HTRasterizable, and be set BEFORE you set rasterizableView on HTRasterView
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) HTHighlightedShapeViewStyle style;
@property (nonatomic, weak) id<HTHighlightedShapeViewDataSource> dataSource;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, assign) CGFloat highlightThickness;
@property (nonatomic, assign) CGFloat highlightAngle;
@property (nonatomic, assign) CGFloat highlightSoftness;
@property (nonatomic, assign) BOOL invertHighlightPath;  // default is YES
@property (nonatomic, assign) BOOL invertShapePath;
@property (nonatomic, assign) UIEdgeInsets capEdgeInsets;  // for rasterization. defaults to UIEdgeInsetsZero which means no capping.

- (id)initWithDataSource:(__weak id<HTHighlightedShapeViewDataSource>)dataSource;

@end

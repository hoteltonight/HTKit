//
//  HTHighlightedShapeView.m
//  HotelTonight
//
//  Created by Jacob Jennings on 12/29/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "HTHighlightedShapeView.h"
#import "UIBezierPath+HTUtilities.h"
#import "HTShapeView.h"
#import "HTGraphicsUtilities.h"

@interface HTHighlightedShapeView ()

@property (nonatomic, readonly) NSString *pathDescription;
@property (nonatomic, strong) CAShapeLayer *maskShapeLayer;
@property (nonatomic, strong) HTShapeView *highlightShapeView;

@end

@implementation HTHighlightedShapeView

- (id)initWithDataSource:(id<HTHighlightedShapeViewDataSource>)dataSource;
{
    self = [super init];
    if (self)
    {
        _dataSource = dataSource;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        self.opaque = YES;
        
        _maskShapeLayer = [CAShapeLayer layer];
        self.layer.mask = _maskShapeLayer;
        
        _highlightShapeView = [[HTShapeView alloc] init];
        _highlightShapeView.shapeLayer.fillColor = [UIColor grayColor].CGColor;
        [self addSubview:_highlightShapeView];
        
        self.highlightThickness = 2;
        self.highlightColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        self.highlightAngle = 3 * M_PI_2;
        self.highlightSoftness = 0;
        
        _invertHighlightPath = YES;
        _invertShapePath = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    UIBezierPath *path = [self.dataSource highlightedShapeView:self
                                                   pathForSize:self.bounds.size];
    UIBezierPath *highlightPath = [self.dataSource highlightedShapeView:self
                                                   highlightPathForSize:self.bounds.size
                                                     highlightThickness:self.highlightThickness];
    
    self.maskShapeLayer.frame = self.bounds;
    
    self.maskShapeLayer.path = self.invertShapePath ? [path inversePathInBounds:self.bounds].CGPath : path.CGPath;
    
    CGSize highlightOffset = [self highlightOffset];
    self.highlightShapeView.frame = self.style == HTHighlightedShapeViewStyleInnerShadow ? self.bounds : CGRectOffset(self.bounds, highlightOffset.width, highlightOffset.height);
    
    UIBezierPath *highlightMaskPath = self.invertHighlightPath ? [highlightPath inversePathInBounds:self.bounds] : highlightPath;
    self.highlightShapeView.shapeLayer.path = highlightMaskPath.CGPath;
}

#pragma mark - Private

- (CGSize)highlightOffset
{
    CGPoint offsetPoint = HTPointAtAngleAndDistanceFromPoint(CGPointZero, self.highlightAngle + M_PI, self.highlightThickness);
    return CGSizeMake(offsetPoint.x, offsetPoint.y);
}

- (void)configureShadowOffset
{
    switch (self.style) {
        case HTHighlightedShapeViewStyleInnerShadow:
            self.highlightShapeView.shapeLayer.shadowOpacity = 1;
            self.highlightShapeView.shapeLayer.shadowOffset = [self highlightOffset];
            break;
            
        case HTHighlightedShapeViewStyleFill:
            self.highlightShapeView.shapeLayer.shadowOpacity = 0;
            self.highlightShapeView.shapeLayer.shadowOffset = CGSizeMake(0, 0);
            break;
            
        default:
            break;
    }
}

- (void)configureHighlightColor
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    switch (self.style) {
        case HTHighlightedShapeViewStyleInnerShadow:
            self.highlightShapeView.shapeLayer.shadowColor = self.highlightColor.CGColor;
            self.highlightShapeView.shapeLayer.fillColor = [UIColor grayColor].CGColor;
            break;
            
        case HTHighlightedShapeViewStyleFill:
            self.highlightShapeView.shapeLayer.shadowColor = [UIColor clearColor].CGColor;
            self.highlightShapeView.shapeLayer.fillColor = self.highlightColor.CGColor;
            break;
            
        default:
            break;
    }
    [CATransaction commit];
}

#pragma mark - HTRasterizableView

- (NSArray *)keyPathsThatAffectState
{
    NSArray *ourPaths = @[
    @"highlightColor",
    @"highlightThickness",
    @"highlightAngle",
    @"pathDescription",
    @"bounds",
    @"invertHighlightPath",
    @"invertShapePath",
    @"backgroundColor"
    ];
    
    if (self.contentView)
    {
        NSMutableArray *allPaths = [NSMutableArray arrayWithArray:ourPaths];
        for (NSString *contentViewKeyPath in [(id<HTRasterizableView>)self.contentView keyPathsThatAffectState])
        {
            [allPaths addObject:[@"contentView." stringByAppendingString:contentViewKeyPath]];
        }
        return [NSArray arrayWithArray:allPaths];
    }
    else
    {
        return ourPaths;
    }
}

#pragma mark - Properties

- (NSString *)pathDescription
{
    if ([self.dataSource respondsToSelector:@selector(pathTypeDescriptionForHighlightedShapeView)])
    {
        return [self.dataSource pathTypeDescriptionForHighlightedShapeView:self];
    }
    return NSStringFromClass(self.dataSource.class);
}

- (void)setDataSource:(id<HTHighlightedShapeViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setNeedsLayout];
}

- (void)setHighlightThickness:(CGFloat)highlightThickness
{
    _highlightThickness = highlightThickness;
    [self configureShadowOffset];
    [self setNeedsLayout];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    [self configureHighlightColor];
}

- (void)setHighlightAngle:(CGFloat)highlightAngle
{
    _highlightAngle = highlightAngle;
    [self configureShadowOffset];
}

- (void)setHighlightSoftness:(CGFloat)highlightSoftness
{
    _highlightSoftness = highlightSoftness;
    self.highlightShapeView.shapeLayer.shadowRadius = highlightSoftness;
}

- (void)setStyle:(HTHighlightedShapeViewStyle)style
{
    _style = style;
    [self configureShadowOffset];
    [self configureHighlightColor];
    [self setNeedsLayout];
}

- (void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self insertSubview:contentView belowSubview:self.highlightShapeView];
    [self setNeedsLayout];
}

- (void)setInvertHighlightPath:(BOOL)invertHighlightPath
{
    _invertHighlightPath = invertHighlightPath;
    [self setNeedsLayout];
}

- (void)setInvertShapePath:(BOOL)invertShapePath
{
    _invertShapePath = invertShapePath;
    [self setNeedsLayout];
}

@end

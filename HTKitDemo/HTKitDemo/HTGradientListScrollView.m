//
//  HTGradientListScrollView.m
//  HTGradientEasingDemo
//
//  Created by Jacob Jennings on 2/26/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HTGradientListScrollView.h"
#import "CAGradientLayer+AHEasing.h" 

static CGFloat const kGradientHeight = 80;

@interface HTGradientListScrollView ()

@property (nonatomic, strong) NSMutableArray *gradientLayers;
@property (nonatomic, strong) NSMutableArray *gradientNameLabels;

@end

@implementation HTGradientListScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self sharedInit];
}

- (void)sharedInit
{
    self.backgroundColor = [UIColor blackColor];
    self.showsVerticalScrollIndicator = YES;
    self.gradientLayers = [NSMutableArray array];
    self.gradientNameLabels = [NSMutableArray array];
    [self createAndAddGradientWithEasingFunction:LinearInterpolation name:@"LinearInterpolation"];
    [self createAndAddGradientWithEasingFunction:SineEaseInOut name:@"SineEaseInOut"];
    [self createAndAddGradientWithEasingFunction:QuadraticEaseOut name:@"QuadraticEaseOut"];
    [self createAndAddGradientWithEasingFunction:CubicEaseInOut name:@"CubicEaseInOut"];
    [self createAndAddGradientWithEasingFunction:QuarticEaseInOut name:@"QuarticEaseInOut"];
    [self createAndAddGradientWithEasingFunction:QuinticEaseInOut name:@"QuinticEaseInOut"];
    [self createAndAddGradientWithEasingFunction:CircularEaseInOut name:@"CircularEaseInOut"];
    [self createAndAddGradientWithEasingFunction:ExponentialEaseInOut name:@"ExponentialEaseInOut"];
    [self createAndAddGradientWithEasingFunction:ElasticEaseInOut name:@"ElasticEaseInOut"];
    [self createAndAddGradientWithEasingFunction:BackEaseInOut name:@"BackEaseInOut"];
    [self createAndAddGradientWithEasingFunction:BounceEaseInOut name:@"BounceEaseInOut"];
}

- (CAGradientLayer *)createAndAddGradientWithEasingFunction:(AHEasingFunction)easingFunction name:(NSString *)name
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setEasedGradientColors:@[[UIColor blueColor], [UIColor redColor]]
                                locations:@[@0, @1]
                           easingFunction:easingFunction
                keyframesBetweenLocations:32];
    gradientLayer.startPoint = CGPointMake(0.2, 0.5);
    gradientLayer.endPoint = CGPointMake(0.8, 0.5);
    [self.layer addSublayer:gradientLayer];
    [self.gradientLayers addObject:gradientLayer];
    
    UILabel *gradientNameLabel = [[UILabel alloc] init];
    gradientNameLabel.backgroundColor = [UIColor blackColor];
    gradientNameLabel.textColor = [UIColor whiteColor];
    gradientNameLabel.textAlignment = NSTextAlignmentCenter;
    gradientNameLabel.text = name;
    [self addSubview:gradientNameLabel];
    [self.gradientNameLabels addObject:gradientNameLabel];
    return gradientLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat lastY = 0;
    CGFloat labelHeight = [self.gradientNameLabels[0] sizeThatFits:self.bounds.size].height;
    for (NSUInteger idx = 0; idx < [self.gradientNameLabels count]; idx++)
    {
        CAGradientLayer *gradientLayer = self.gradientLayers[idx];
        UILabel *gradientNameLabel = self.gradientNameLabels[idx];
        
        gradientNameLabel.frame = (CGRect) {
            .origin.x = 0,
            .origin.y = lastY,
            .size.width = self.bounds.size.width,
            .size.height = labelHeight
        };
        lastY = CGRectGetMaxY(gradientNameLabel.frame) + 4;

        gradientLayer.frame = (CGRect) {
            .origin.x = 0,
            .origin.y = lastY,
            .size.width = self.bounds.size.width,
            .size.height = kGradientHeight
        };
        lastY = CGRectGetMaxY(gradientLayer.frame) + 4;
    }
    self.contentSize = (CGSize) { .width = self.bounds.size.width, .height = lastY };
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [self flashScrollIndicators];
}

@end

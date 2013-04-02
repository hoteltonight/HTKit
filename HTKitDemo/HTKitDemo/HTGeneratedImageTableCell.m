//
//  HTGeneratedImageTableCell.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/7/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HTGeneratedImageTableCell.h"

static CGFloat const horizontalMargin = 6;

@interface HTGeneratedImageTableCell ()

@property (nonatomic, strong) UILabel *cacheKeyLabel;
@property (nonatomic, strong) UIImageView *actualSizeImageView;
@property (nonatomic, strong) UIImageView *standardSizeImageView;

@end

@implementation HTGeneratedImageTableCell

- (instancetype)init
{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HTGeneratedImageTableCellReuseIdentifier];
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cacheKeyLabel = [[UILabel alloc] init];
        _cacheKeyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
        [self.contentView addSubview:_cacheKeyLabel];
        
        _actualSizeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_actualSizeImageView];
        
        _standardSizeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_standardSizeImageView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageViewSizeThatFits = [self.actualSizeImageView sizeThatFits:self.bounds.size];
    CGFloat imageWidthForCellHeight = imageViewSizeThatFits.height ? (imageViewSizeThatFits.width / imageViewSizeThatFits.height) * self.bounds.size.height : 0;
    
    self.standardSizeImageView.frame = CGRectMake(self.bounds.size.width - imageWidthForCellHeight,
                                                  0,
                                                  imageWidthForCellHeight,
                                                  self.bounds.size.height);
    
    self.actualSizeImageView.frame = CGRectMake(CGRectGetMinX(self.standardSizeImageView.frame) - imageViewSizeThatFits.width - horizontalMargin,
                                                0,
                                                imageViewSizeThatFits.width,
                                                imageViewSizeThatFits.height);
    
    self.cacheKeyLabel.frame = CGRectMake(0,
                                          0,
                                          CGRectGetMinX(self.actualSizeImageView.frame) - horizontalMargin,
                                          self.bounds.size.height);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.actualSizeImageView.image = image;
    self.standardSizeImageView.image = [UIImage imageWithCGImage:image.CGImage];
    
    [self setNeedsLayout];
}

- (void)setCacheKey:(NSString *)cacheKey
{
    _cacheKey = cacheKey;
    
    self.cacheKeyLabel.text = cacheKey;
    
    [self setNeedsLayout];
}

@end

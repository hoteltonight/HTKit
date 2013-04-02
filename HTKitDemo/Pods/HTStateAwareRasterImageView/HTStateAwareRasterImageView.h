//
//  HTStateAwareRasterImageView.h
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HTSARIVVoidBlock)();

@protocol HTRasterizableView <NSObject>

- (NSArray *)keyPathsThatAffectState;

@optional
- (UIEdgeInsets)capEdgeInsets;

// YES means 1pt between caps vertically and horizontally for draw size.  capEdgeInsets must be implemented for this.
- (BOOL)useMinimumFrameForCaps;

- (BOOL)shouldRegenerateRasterForKeyPath:(NSString *)keyPath change:(NSDictionary *)dictionary;

@end

@class HTStateAwareRasterImageView;
@protocol HTStateAwareRasterImageViewDelegate <NSObject>

@optional
- (void)rasterImageViewWillRegenerateImage:(HTStateAwareRasterImageView *)rasterImageView; // May be called outside main thread
- (void)rasterImageViewImageLoaded:(HTStateAwareRasterImageView *)rasterImageView;

@end

@interface HTStateAwareRasterImageView : UIImageView

@property (nonatomic, strong) UIView<HTRasterizableView> *rasterizableView;
@property (nonatomic, assign) BOOL drawsOnMainThread;
@property (atomic, assign) id<HTStateAwareRasterImageViewDelegate> delegate;

@property (nonatomic, assign) BOOL rasterized; // Default YES, change to NO to add rasterizableView as a subview

- (NSString *)cacheKey;
- (void)registerDescendantRasterImageView:(HTStateAwareRasterImageView *)descendant;
- (void)unregisterDescendantRasterImageView:(HTStateAwareRasterImageView *)descendant;

// For prerendering only
@property (nonatomic, assign) BOOL kvoEnabled;
- (void)regenerateImage:(HTSARIVVoidBlock)complete;

@end

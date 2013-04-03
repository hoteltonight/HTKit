//
//  HTCardViewController.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "HTCardViewController.h"
#import "HTCardView.h"

@interface HTCardViewController () <HTCardViewDelegate>

@property (nonatomic, strong) HTCardView *view;

@end

@implementation HTCardViewController
@dynamic view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    self.view = [[HTCardView alloc] initWithDelegate:self];
}

- (void)cardTapped
{
    switch (self.view.state)
    {
        case HTCardViewStateTuckedIn:
        {
            [self.view setState:HTCardViewStateCardPresented animated:YES];
            break;
        }
        case HTCardViewStateCardPresented:
        {
            [self.view setState:HTCardViewStateTuckedIn animated:YES];
            break;
        }
        default:break;
    }
}

@end

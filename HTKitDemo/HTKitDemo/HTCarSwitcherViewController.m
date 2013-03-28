//
// Created by Jacob Jennings on 3/24/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//


#import "HTCarSwitcherViewController.h"
#import "HTCarDetailsViewV1.h"
#import "HTCarDetailsViewV2.h"

@interface HTCarSwitcherViewController()

@property (nonatomic, readonly) HTCarSwitcherView *carSwitcherView;

@end

@implementation HTCarSwitcherViewController
@dynamic carSwitcherView;

- (void)awakeFromNib
{
    switch ([self.carSwitcherVersion integerValue]) {
        case 0:
        {
            self.carSwitcherView.carDetailsView = [[HTCarDetailsViewV1 alloc] init];
            break;
        }
        case 1:
        {
            self.carSwitcherView.carDetailsView = [[HTCarDetailsViewV2 alloc] init];
            break;
        }
        case 2:
        {
            
            break;
        }
        default:
            break;
    }
}

- (HTCarSwitcherView *)carSwitcherView
{
    return (HTCarSwitcherView *)self.view;
}

- (IBAction)switchCarsTapped:(id)sender {
    NSLog(@"switchCarsTapped");
    
    [self.carSwitcherView.carDetailsView setMake:[self randomMake]];
    [self.carSwitcherView.carDetailsView setModel:[self randomModel]];
    [self.carSwitcherView.carDetailsView setCarDescription:[self randomDescription]];
    [self.carSwitcherView.carDetailsView setColorName:[self randomColorName]];
    [self.carSwitcherView setNeedsLayout];
}

- (NSString *)randomStringFromList:(NSArray *)list
{
    return list[arc4random() % [list count]];
}

- (NSString *)randomMake
{
    return [self randomStringFromList:@[@"Dodge", @"Ford", @"BMW", @"Mercedes"]];
}

- (NSString *)randomModel
{
    return [self randomStringFromList:@[@"Challenger", @"Mustang", @"M3", @"C300"]];
}

- (NSString *)randomDescription
{
    return [self randomStringFromList:@[
            @"A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. ",
            @"A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. ",
            @"A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. A longer description. ",
            @"A longer description. A longer description. A longer description. A longer description. "]];
}

- (NSString *)randomColorName
{
    return [self randomStringFromList:@[@"Blue", @"Black", @"Silver", @"Orange"]];
}

@end

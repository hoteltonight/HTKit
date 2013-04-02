//
// Created by Jacob Jennings on 3/24/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

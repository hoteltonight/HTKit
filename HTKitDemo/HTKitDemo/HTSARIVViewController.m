//
//  HTSARIVViewController.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 3/23/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HTSARIVViewController.h"
#import "HTExampleTableViewController.h"
#import "HTGeneratedImagesViewController.h"
#import "HTExampleTableCell.h"
#import "HTNoRasterizationCell.h"

@interface HTSARIVViewController ()

@end

@implementation HTSARIVViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            HTExampleTableViewController *exampleTableViewController = [[HTExampleTableViewController alloc] initWithCellClass:[HTNoRasterizationCell class]];
            [self.navigationController pushViewController:exampleTableViewController animated:YES];
            break;
        }
        case 1:
        {
            HTExampleTableViewController *exampleTableViewController = [[HTExampleTableViewController alloc] initWithCellClass:[HTNoRasterizationCell class]];
            exampleTableViewController.shouldCARasterize = YES;
            [self.navigationController pushViewController:exampleTableViewController animated:YES];
            break;
        }
        case 2:
        {
            HTExampleTableViewController *exampleTableViewController = [[HTExampleTableViewController alloc] initWithCellClass:[HTExampleTableCell class]];
            [self.navigationController pushViewController:exampleTableViewController animated:YES];
            break;
        }
        case 3:
        {
            HTGeneratedImagesViewController *generatedImagesViewController = [[HTGeneratedImagesViewController alloc] init];
            [self.navigationController pushViewController:generatedImagesViewController animated:YES];
            break;
        }
        default:
            break;
    }
}

@end

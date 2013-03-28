//
//  HTSARIVViewController.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 3/23/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
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

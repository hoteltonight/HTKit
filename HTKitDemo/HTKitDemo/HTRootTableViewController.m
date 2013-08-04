//
//  HTRootTableViewController.m
//  HTKitDemo
//
//  Created by Jonathan Sibley on 4/3/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "HTRootTableViewController.h"

@interface HTRootTableViewController ()
@end

@implementation HTRootTableViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard;
    
    if (indexPath.row == 0)
    {
        storyboard = [UIStoryboard storyboardWithName:@"HTAutocompleteTextFieldDemo" bundle:nil];
        UINavigationController *navigationController = [storyboard instantiateInitialViewController];
        UIViewController *viewController = navigationController.viewControllers[0];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (indexPath.row == 6)
    {
        storyboard = [UIStoryboard storyboardWithName:@"HTCopyableLabelDemo" bundle:nil];
        UITabBarController *tabController = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:tabController animated:YES];
    }
}

@end

//
//  HTGeneratedImagesViewController.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import "HTGeneratedImagesViewController.h"
#import "MSCachedAsyncViewDrawing.h"
#import "HTGeneratedImageTableCell.h"
#import "HTCacheKeyCollector.h"

@interface HTGeneratedImagesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *cacheCopyDictionary;
@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation HTGeneratedImagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)loadView
{
    self.view = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 88;
}

- (UITableView *)tableView
{
    return (UITableView *)self.view;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSCache *cache = [[MSCachedAsyncViewDrawing sharedInstance] performSelector:@selector(cache)];
    NSArray *cacheKeys = [[[HTCacheKeyCollector shared] cacheKeys] copy];
    NSMutableDictionary *cacheCopyDictionaryMutable = [NSMutableDictionary dictionaryWithCapacity:[cacheKeys count]];
    for (NSString *key in cacheKeys)
    {
        NSObject *cachedObject = [cache objectForKey:key];
        if (cachedObject) [cacheCopyDictionaryMutable setObject:cachedObject forKey:key];
    }
    self.cacheCopyDictionary = [cacheCopyDictionaryMutable copy];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource,Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.cacheCopyDictionary allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTGeneratedImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HTGeneratedImageTableCellReuseIdentifier];
    if (!cell)
    {
        cell = [[HTGeneratedImageTableCell alloc] init];
    }
    
    cell.cacheKey = [self.cacheCopyDictionary allKeys][indexPath.row];
    cell.image = self.cacheCopyDictionary[cell.cacheKey];
    
    return cell;
}

@end

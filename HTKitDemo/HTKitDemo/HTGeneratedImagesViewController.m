//
//  HTGeneratedImagesViewController.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

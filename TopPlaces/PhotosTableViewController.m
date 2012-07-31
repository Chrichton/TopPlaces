//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 27.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "PhotoViewController.h"
#import "FlickrFetcher.h"
#import "RecentPhotosTableViewController.h"

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController

@synthesize photos = _photos;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotosTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [photo valueForKeyPath:@"description._content"];
    
    NSString *title = [photo valueForKey:@"title"];
    if (title.length == 0) {
        if (cell.detailTextLabel.text.length > 0)
            title = cell.detailTextLabel.text;
        else
            title = NSLocalizedString(@"unknown", @"unknown");
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PhotoSegue"]) {
        PhotoViewController *photoController = segue.destinationViewController;
        
        UITableViewCell * cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
        photoController.photo = photo;
        [RecentPhotosTableViewController addPhoto:photo];
    }
}

- (void) setPhotos:(NSArray *)photos {
    if (_photos != photos) {
        _photos = photos;
        [self.tableView reloadData];

    }
}

@end

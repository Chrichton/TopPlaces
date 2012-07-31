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
#import "FlickrPhoto.h"

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
    FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithPhoto:photo];
    
    cell.textLabel.text = flickrPhoto.title;
    cell.detailTextLabel.text = flickrPhoto.description;;

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

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.splitViewController) {
        PhotoViewController *photoController = self.splitViewController.viewControllers.lastObject;
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

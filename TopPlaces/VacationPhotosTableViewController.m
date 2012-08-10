//
//  VacationPhotosTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationPhotosTableViewController.h"
#import "Photo.h"
#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface VacationPhotosTableViewController ()

@end

@implementation VacationPhotosTableViewController

@synthesize photos = _photos;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VacationPhotosTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VacationPhotosToPhoto"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        PhotoViewController *controller = segue.destinationViewController;
        controller.photo = [PhotoDefintion createWithPhoto:photo];
    }
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS self", self.photos];
    request.sortDescriptors = [NSArray array];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:((Photo *)[self.photos lastObject]).managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)setPhotos:(NSArray *)photos {
    if (_photos != photos) {
        _photos = photos;
        [self setupFetchedResultsController];
    }
}

@end

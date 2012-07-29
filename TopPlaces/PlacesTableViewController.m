//
//  PlacesTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 27.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotosTableViewController.h"
#import "FlickrPlace.h"

@interface PlacesTableViewController ()

@property (nonatomic, strong) NSArray *places;

@end
 
@implementation PlacesTableViewController

@synthesize places = _places;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlacesTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *place = [self.places objectAtIndex:indexPath.row];
    FlickrPlace *flickrPlace = [[FlickrPlace alloc] initWithPlace:place];
        
    cell.textLabel.text = flickrPlace.city;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", flickrPlace.region, flickrPlace.country];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlacesToPhotosSegue"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *place = [self.places objectAtIndex:indexPath.row];
        
        PhotosTableViewController *photosController = [segue destinationViewController];
        photosController.photos = [FlickrFetcher photosInPlace:place maxResults:50];
    }
}

- (NSArray *)places {
    if (! _places)
        _places = [[FlickrFetcher topPlaces] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
            NSString *first = [a valueForKey:@"_content"];
            NSString *second = [b valueForKey:@"_content"];
            return [first compare:second];
        }];
        
    return _places;
}

@end

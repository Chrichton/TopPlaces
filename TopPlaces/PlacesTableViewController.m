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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [self.places count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *countryPlaces = [self.places objectAtIndex:section];
    return [countryPlaces count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *countryPlaces = [self.places objectAtIndex:section];
    NSDictionary *place = [countryPlaces objectAtIndex:0];
    FlickrPlace * flickrPlace = [[FlickrPlace alloc] initWithPlace:place];
    return flickrPlace.country;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlacesTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *countryPlaces = [self.places objectAtIndex:indexPath.section];
    NSDictionary *place = [countryPlaces objectAtIndex:indexPath.row];
    FlickrPlace *flickrPlace = [[FlickrPlace alloc] initWithPlace:place];
    
    cell.textLabel.text = flickrPlace.city;
    cell.detailTextLabel.text = flickrPlace.region;
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlacesToPhotosSegue"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSArray *countryPlaces = [self.places objectAtIndex:indexPath.section];

        NSDictionary *place = [countryPlaces objectAtIndex:indexPath.row];
        
        PhotosTableViewController *photosController = [segue destinationViewController];
        photosController.photos = [FlickrFetcher photosInPlace:place maxResults:50];
    }
}

- (NSArray *)places {
    if (! _places) {
        NSArray *flickrPlaces = [[FlickrFetcher topPlaces] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
            FlickrPlace *first = [[FlickrPlace alloc ] initWithPlace:a];
            FlickrPlace *second = [[FlickrPlace alloc] initWithPlace:b];
            if ([first.country isEqualToString:second.country])
                return [first.city compare: second.city];
            
            return [first.country compare:second.country];
        }];
        
        NSMutableArray *sectionsArrary = [NSMutableArray array];
        NSString *lastCountry = nil;
        NSMutableArray *countryPlaces;
        
        for (NSDictionary *place in flickrPlaces) {
            FlickrPlace *flickrPlace = [[FlickrPlace alloc] initWithPlace:place];
            if (![flickrPlace.country isEqualToString:lastCountry]) {
                lastCountry = flickrPlace.country;
                countryPlaces = [NSMutableArray array];
                [sectionsArrary addObject:countryPlaces];
            }
            
            [countryPlaces addObject:place];
        }
        
        _places = sectionsArrary;
    }
    return _places;
}

@end

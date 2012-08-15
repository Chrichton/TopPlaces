//
//  TagPhotosTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 15.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "TagPhotosTableViewController.h"
#import "Photo.h"
#import "VacationPhotoViewController.h"

@interface TagPhotosTableViewController ()

@end

@implementation TagPhotosTableViewController

@synthesize tag = _tag, vacationDatabase = _vacationDatabase;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TagPhotosTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TagPhotosToVacationPhoto"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        VacationPhotoViewController *controller = segue.destinationViewController;
        controller.vacationDatabase = self.vacationDatabase;
        controller.photo = [PhotoDefintion createWithPhoto:photo];
    }
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"%@ IN tags", self.tag];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.vacationDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)setTag:(Tag *)tag {
    if (_tag != tag) {
        _tag = tag;
        [self setupFetchedResultsController];
    }
}

@end

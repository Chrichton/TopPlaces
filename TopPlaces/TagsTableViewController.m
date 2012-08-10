//
//  TagsTableViewController.m
//  TopPlaces
//
//  Created by cp on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "TagsTableViewController.h"
#import "VacationHelper.h"
#import "Photo.h"
#import "Tag.h"

@interface TagsTableViewController ()

@property (nonatomic, strong) UIManagedDocument *vacationDatabase;

@end

@implementation TagsTableViewController

@synthesize vacationName = _vacationName, vacationDatabase = _vacationDatabase;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TagsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tag.content;
    
    return cell;
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES selector: @selector(localizedCaseInsensitiveCompare:)];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.vacationDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)setVacationName:(NSString *)vacationName {
    if (vacationName != self.vacationName) {
        _vacationName = vacationName;
        [VacationHelper openVacation:vacationName usingBlock:^(UIManagedDocument *vacation) {
            self.vacationDatabase = vacation;
            [self setupFetchedResultsController];
        }];
    }
}

@end

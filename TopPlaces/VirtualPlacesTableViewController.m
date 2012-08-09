//
//  VirtualPlacesTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VirtualPlacesTableViewController.h"
#import "VacationHelper.h"

@interface VirtualPlacesTableViewController ()

@property (nonatomic, strong) NSArray *vacations;

@end

@implementation VirtualPlacesTableViewController

@synthesize vacations = _vacations;

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSError *error;
    _vacations = [[NSFileManager defaultManager]
                  contentsOfDirectoryAtURL:[VacationHelper rootURL]
                  includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.vacations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VirtualVacationsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSURL *url = [self.vacations objectAtIndex:indexPath.row];
    cell.textLabel.text = [url lastPathComponent];
    
    return cell;
}

@end

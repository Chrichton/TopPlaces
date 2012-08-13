//
//  VirtualPlacesTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VirtualVacationsTableViewController.h"
#import "VacationHelper.h"
#import "VirtualVacationTableViewController.h"

@interface VirtualVacationsTableViewController ()

@property (nonatomic, strong) NSArray *vacations;

@end

@implementation VirtualVacationsTableViewController

@synthesize vacations = _vacations;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSError *error;
    _vacations = [[NSFileManager defaultManager]
                  contentsOfDirectoryAtURL:[VacationHelper rootURL]
                  includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
    [self.tableView reloadData];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    VirtualVacationTableViewController * controller = [segue destinationViewController];
    UITableViewCell *cell = sender;
    controller.vacationName = cell.textLabel.text;
}

@end

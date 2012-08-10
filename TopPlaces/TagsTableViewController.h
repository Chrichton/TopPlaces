//
//  TagsTableViewController.h
//  TopPlaces
//
//  Created by cp on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Place.h"

@interface TagsTableViewController : CoreDataTableViewController

@property (nonatomic, strong) NSString *vacationName;

@end

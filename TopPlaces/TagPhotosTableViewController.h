//
//  TagPhotosTableViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 15.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tag.h"
#import "CoreDataTableViewController.h"

@interface TagPhotosTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *vacationDatabase;
@property (nonatomic, strong) Tag *tag;

@end

//
//  VacationPhotosTableViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Place.h"

@interface VacationPhotosTableViewController : CoreDataTableViewController

@property (nonatomic, strong) Place *place;

@end

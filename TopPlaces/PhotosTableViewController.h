//
//  PhotosTableViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 27.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosMapViewController.h"

@interface PhotosTableViewController : UITableViewController<PhotosMapViewControllerDelegate>

@property (nonatomic, strong) NSArray *photos;

@end

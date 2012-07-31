//
//  TopPhotosViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 31.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosTableViewController.h"

@interface TopPhotosTableViewController : PhotosTableViewController

@property (nonatomic, strong) NSDictionary *place;

@end

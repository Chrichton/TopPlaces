//
//  RecentPhotosTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "RecentPhotosTableViewController.h"

@interface RecentPhotosTableViewController ()

@end

@implementation RecentPhotosTableViewController

#define RECENT_PHOTOS_KEY @"RecentPhotosTableViewControllerKey"

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY];
    if (!self.photos)
        self.photos = [NSArray array];
}

+ (void) addPhoto: (NSDictionary *) photo; {
    NSMutableArray *photos = [[[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY] mutableCopy];
    if (!photos)
        photos = [NSMutableArray array];
    
    [photos insertObject:photo atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:photos forKey:RECENT_PHOTOS_KEY];
}

@end

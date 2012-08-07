//
//  RecentPhotosTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "RecentPhotosTableViewController.h"
#import "FlickrFetcher.h"

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
    
    NSString *photoId =  [photo valueForKey:FLICKR_PHOTO_ID];
    
    NSIndexSet *indices = [photos indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSString *evaluatedPhotoId = [obj valueForKey:FLICKR_PHOTO_ID];
        if ([evaluatedPhotoId isEqualToString:photoId]) {
            *stop = YES;
            return YES;
        } else
            return NO;
    }];
    
    if ([indices count] > 0) {
        NSUInteger foundPhotoIndex = [indices firstIndex];
        [photos removeObjectAtIndex:foundPhotoIndex];
    } else if ([photos count] == 20)
        [photos removeLastObject];
  
    [photos insertObject:photo atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:photos forKey:RECENT_PHOTOS_KEY];
}

@end

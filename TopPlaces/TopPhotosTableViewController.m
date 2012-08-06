//
//  TopPhotosViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 31.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "TopPhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "RecentPhotosTableViewController.h"
#import "TopPhotosTableViewController.h"

@interface TopPhotosTableViewController ()

@end

@implementation TopPhotosTableViewController

@synthesize place = _place;

- (void) reloadPhotos {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("top photos queue", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *photos = [FlickrFetcher photosInPlace:self.place maxResults:50];
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
            self.photos = photos;});
    });
    
    dispatch_release(downloadQueue);
}

- (IBAction)refreshClicked:(id)sender {
    [self reloadPhotos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadPhotos];
}

@end
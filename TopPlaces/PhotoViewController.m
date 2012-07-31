//
//  PhotoViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation PhotoViewController
@synthesize photoImageView = _photoImageView;

@synthesize photo = _photo;
@synthesize scrollView = _scrollView;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // self.title =
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSURL *url = [FlickrFetcher urlForPhoto:self.photo format:FlickrPhotoFormatLarge];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
       
        dispatch_async(dispatch_get_main_queue(), ^ {
             
            self.photoImageView.image = image;
            self.photoImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            
            self.scrollView.zoomScale = 1;
            self.scrollView.contentSize = image.size;
            
            CGFloat heightScale = self.scrollView.bounds.size.height / self.scrollView.contentSize.height;
            CGFloat widthScale = self.scrollView.bounds.size.width / self.scrollView.contentSize.width;
            
            self.scrollView.zoomScale = MIN(heightScale, widthScale);
            
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        });
    });

    dispatch_release(downloadQueue);    
}

- (void)viewDidUnload
{
    [self setPhotoImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.photoImageView;
}

@end

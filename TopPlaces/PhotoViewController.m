//
//  PhotoViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"
#import "FlickrPhoto.h"
#import "FileCache.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic, readonly) FileCache *fileCache;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoDescription;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PhotoViewController
@synthesize toolbar = _toolbar;
@synthesize photoDescription = _photoDescription;
@synthesize activityIndicator = _activityIndicator;

@synthesize photoImageView = _photoImageView, photo = _photo, scrollView = _scrollView, fileCache = _fileCache;

- (void) reloadPhoto {
    FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithPhoto:self.photo];
    self.photoDescription.title = flickrPhoto.title;
    UIBarButtonItem *rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    
    if (self.splitViewController)
        [self.activityIndicator startAnimating];
    else {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    }
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSString *photoId = [self.photo objectForKey:FLICKR_PHOTO_ID];
        NSData *data = [self.fileCache dataForFilename:photoId];
        if (!data) {
            NSURL *url = [FlickrFetcher urlForPhoto:self.photo format:FlickrPhotoFormatLarge];
            data = [NSData dataWithContentsOfURL:url];
            [self.fileCache addData:data withFilename:photoId];
        }
        
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^ {
            
            self.photoImageView.image = image;
            self.photoImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            
            self.scrollView.zoomScale = 1;
            self.scrollView.contentSize = image.size;
            
            CGFloat heightScale = self.scrollView.bounds.size.height / self.scrollView.contentSize.height;
            CGFloat widthScale = self.scrollView.bounds.size.width / self.scrollView.contentSize.width;
            
            self.scrollView.zoomScale = MIN(heightScale, widthScale);
            
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
            
            if (self.splitViewController)
                [self.activityIndicator stopAnimating];
        });
    });
    
    dispatch_release(downloadQueue);
}

- (void) viewDidLoad {
    [super viewDidLoad];

    _fileCache = [[FileCache alloc] initWithName:@"FlickrPhotos" andMaxSize:1000000];
    self.splitViewController.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.splitViewController) 
        [self reloadPhoto];
}

- (void) setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
if (self.splitViewController) 
    [self reloadPhoto];
}

- (void)viewDidUnload
{
    [self setPhotoImageView:nil];
    [self setScrollView:nil];
    [self setToolbar:nil];
    [self setPhotoDescription:nil];
    [self setActivityIndicator:nil];
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

#pragma mark - Split view
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Places", @"Places");
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    [toolbarItems insertObject:barButtonItem atIndex:0];
    self.toolbar.items = toolbarItems;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    [toolbarItems removeObject:barButtonItem];
    self.toolbar.items = toolbarItems;
}

@end

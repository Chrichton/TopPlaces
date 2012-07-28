//
//  PhotoViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation PhotoViewController
@synthesize photoImageView = _photoImageView, photoTitle = _photoTitle;

@synthesize photo = _photo;
@synthesize scrollView = _scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.photoTitle;
    self.photoImageView.image = self.photo;
    self.photoImageView.frame = CGRectMake(0, 0, self.photo.size.width, self.photo.size.height);

    self.scrollView.contentSize = self.photo.size;
}

- (void) viewWillAppear:(BOOL)animated {
    CGFloat heightScale = self.scrollView.bounds.size.height / self.scrollView.contentSize.height;
    CGFloat widthScale = self.scrollView.bounds.size.width / self.scrollView.contentSize.width;
    
    self.scrollView.zoomScale = MIN(heightScale, widthScale);    
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

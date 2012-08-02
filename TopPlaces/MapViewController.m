//
//  PlacesMapViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 01.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "MapViewController.h"
#import <Mapkit/MapKit.h>

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController
@synthesize mapView = _mapView, annotations = _annotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapView.delegate = self;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.annotations];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end

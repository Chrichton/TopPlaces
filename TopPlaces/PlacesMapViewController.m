//
//  PlacesMapViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 01.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PlacesMapViewController.h"
#import <Mapkit/MapKit.h>
#import "PlaceAnnotation.h"

@interface PlacesMapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PlacesMapViewController
@synthesize mapView = _mapView, places = _places;

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
    for (NSArray *countryPlaces in self.places)
        for (NSDictionary *place in countryPlaces)
            [self.mapView addAnnotation:[PlaceAnnotation CreateWithPlace:place]];
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

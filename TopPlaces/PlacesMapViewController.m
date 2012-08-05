//
//  PlacesMapViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 01.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PlacesMapViewController.h"
#import "TopPhotosTableViewController.h"
#import "PlaceAnnotation.h"
#import "MapUtilities.h"

@interface PlacesMapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PlacesMapViewController

@synthesize mapView = _mapView, annotations = _annotations;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapView.delegate = self;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.annotations];
    
    [MapUtilities zoomMapViewToFitAnnotations:self.mapView animated:YES];
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

#pragma AnnotationView

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.rightCalloutAccessoryView = rightButton;
    }
    
    aView.annotation = annotation;
    return aView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"MapPlacesToPhotosSegue" sender:view];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MapPlacesToPhotosSegue"]) {
        TopPhotosTableViewController *photosController = segue.destinationViewController;
        MKAnnotationView *view = sender;
        photosController.place = ((PlaceAnnotation *)view.annotation).place;
    }
}
@end

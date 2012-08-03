//
//  PhotosMapViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotosMapViewController.h"
#import <MapKit/MapKit.h>
#import "PhotoViewController.h"
#import "PhotoAnnotation.h"

@interface PhotosMapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation PhotosMapViewController
@synthesize mapView = _mapView;

@synthesize annotations = _annotations;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.annotations];

	// Do any additional setup after loading the view.
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
    [self performSegueWithIdentifier:@"MapPhotosToPhotoSegue" sender:view];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MapPhotosToPhotoSegue"]) {
        PhotoViewController *photoController = segue.destinationViewController;
        MKAnnotationView *view = sender;
        photoController.photo = ((PhotoAnnotation *)view.annotation).photo;
    }
}

@end

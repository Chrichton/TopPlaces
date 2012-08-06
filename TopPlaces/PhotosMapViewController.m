//
//  PhotosMapViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotosMapViewController.h"
#import "PhotoViewController.h"
#import "PhotoAnnotation.h"
#import "MapUtilities.h"

@interface PhotosMapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation PhotosMapViewController
@synthesize mapView = _mapView, annotations = _annotations, delegate = _delegate;


- (IBAction)mapTypeChanged:(UISegmentedControl *)sender {
    self.mapView.mapType = sender.selectedSegmentIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.annotations];
    
    [MapUtilities zoomMapViewToFitAnnotations:self.mapView animated:YES];
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
        
        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    }

    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    aView.annotation = annotation;
    
    return aView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
{
    dispatch_queue_t queue = dispatch_queue_create("download_queue", NULL);
    dispatch_async(queue, ^{
        UIImage *image = [self.delegate mapViewController:self imageForAnnotation:aView.annotation];
        if ([self.annotations containsObject:aView.annotation]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [(UIImageView *)aView.leftCalloutAccessoryView setImage:image];
            });
        };
    });
    
    dispatch_release(queue);
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if (self.splitViewController) {
        PhotoViewController *photoViewController = [self.splitViewController.viewControllers lastObject];
        photoViewController.photo = ((PhotoAnnotation *)view.annotation).photo;
    } else
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

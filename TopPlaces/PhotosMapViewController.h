//
//  PhotosMapViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class PhotosMapViewController;

@protocol PhotosMapViewControllerDelegate <NSObject>

- (UIImage *)mapViewController:(PhotosMapViewController *)sender imageForAnnotation:(id <MKAnnotation>)annotation;

@end

@interface PhotosMapViewController : UIViewController

@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, weak) id <PhotosMapViewControllerDelegate> delegate;

@end

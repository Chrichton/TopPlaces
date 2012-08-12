//
//  PhotoViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoViewController.h"
#import "VacationHelper.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *visitButton;

@property (nonatomic) BOOL isPhotoInVacation;

@end

@implementation PhotoViewController

#define VACATION_NAME @"My Vacation"

@synthesize visitButton = _visitButton, isPhotoInVacation;

- (IBAction)visitButtonClicked:(id)sender {
    if (self.isPhotoInVacation)
        [VacationHelper unVisitPhoto:self.photo inVacationWithName:VACATION_NAME];
    else
        [VacationHelper visitPhoto:self.photo inVacationWithName:VACATION_NAME];
    
    self.isPhotoInVacation = !self.isPhotoInVacation;
    [self updateVisitButton];
}

- (void)updateVisitButton {
    self.visitButton.title =  self.isPhotoInVacation ? @"Unvisit" : @"Visit";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    [VacationHelper isPhotoWithId:self.photo.photoId inVacationWithName:VACATION_NAME usingBlock:^(BOOL isTrue) {
        self.isPhotoInVacation = isTrue;
        [self updateVisitButton];
    }];
}

- (void)viewDidUnload
{
    [self setVisitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end

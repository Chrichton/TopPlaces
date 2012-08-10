//
//  PhotoViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDefintion.h"

@interface PhotoViewController : UIViewController<UIScrollViewDelegate, UISplitViewControllerDelegate>

@property (nonatomic, strong) PhotoDefintion *photo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

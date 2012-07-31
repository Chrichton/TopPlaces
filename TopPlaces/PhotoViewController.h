//
//  PhotoViewController.h
//  TopPlaces
//
//  Created by Heiko Goes on 28.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSDictionary *photo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

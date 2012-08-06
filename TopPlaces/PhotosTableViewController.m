//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 27.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "PhotoViewController.h"
#import "FlickrFetcher.h"
#import "RecentPhotosTableViewController.h"
#import "FlickrPhoto.h"
#import "PhotoAnnotation.h"
#import <MapKit/MapKit.h>
#import "FileCache.h"

@interface PhotosTableViewController ()

@property (nonatomic, readonly) FileCache *fileCache;

@end

@implementation PhotosTableViewController

@synthesize photos = _photos, fileCache = _fileCache;

- (UIImage *)imageForPhoto:(NSDictionary *)photo {
    NSString *photoId = [photo valueForKey:FLICKR_PHOTO_ID];
    NSData * data = [self.fileCache dataForFilename:photoId];
    if (!data) {
        NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatSquare];
        data = [NSData dataWithContentsOfURL:url];
        [self.fileCache addData:data withFilename:photoId];
    }
    
    return [UIImage imageWithData:data];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fileCache = [[FileCache alloc] initWithName:@"photos thumbnails queue" andMaxSize:1000000];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_queue_t queue = dispatch_queue_create("downloadqueue", NULL);
    cell.imageView.image = [UIImage imageNamed:@"emptyThumbnail.png"];
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    
    dispatch_async(queue, ^{
        UIImage *image = [self imageForPhoto:[self.photos objectAtIndex:indexPath.row]];
        NSDictionary *actualPhoto = [self.photos objectAtIndex:indexPath.row];
        
        if (photo == actualPhoto) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = image;
            });
        }
    });
    
    dispatch_release(queue);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotosTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithPhoto:photo];
    
    cell.textLabel.text = flickrPhoto.title;
    cell.detailTextLabel.text = flickrPhoto.description;;

    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PhotoSegue"]) {
        PhotoViewController *photoController = segue.destinationViewController;
        
        UITableViewCell * cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
        photoController.photo = photo;
        [RecentPhotosTableViewController addPhoto:photo];
    } else if ([segue.identifier isEqualToString:@"PhotosToMapSegue"]) {
        PhotosMapViewController *mapViewContoller = segue.destinationViewController;
        NSMutableArray *annotations = [NSMutableArray array];
        for (NSDictionary *photo in self.photos)
            [annotations addObject:[PhotoAnnotation CreateWithPhoto:photo]];
        
        mapViewContoller.annotations = annotations;
        mapViewContoller.delegate = self;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.splitViewController) {
        PhotoViewController *photoController = self.splitViewController.viewControllers.lastObject;
        NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
        photoController.photo = photo;
        [RecentPhotosTableViewController addPhoto:photo];
    }
}

- (void) setPhotos:(NSArray *)photos {
    if (_photos != photos) {
        _photos = photos;
        [self.tableView reloadData];
    }
}

#pragma PhotosMapViewControllerDelegate
- (UIImage *)mapViewController:(PhotosMapViewController *)sender imageForAnnotation:(id<MKAnnotation>)annotation {
    NSDictionary *photo = ((PhotoAnnotation *)annotation).photo;
    return [self imageForPhoto:photo];
}

@end

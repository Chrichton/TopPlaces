//
//  FileCache.h
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCache : NSObject

- (id)initWithName:(NSString*) name andMaxSize: (NSUInteger) maxSize;

- (void)addData: (NSData *)data withFilename:(NSString *)filename;

- (NSData *)dataForFilename:(NSString *)filename;

@end

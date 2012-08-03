//
//  TopPlacesTests.m
//  TopPlacesTests
//
//  Created by Heiko Goes on 27.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "TopPlacesTests.h"
#import "FileCache.h"
@implementation TopPlacesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    NSURL *cacheUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtURL:[cacheUrl URLByAppendingPathComponent:@"test"] error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:[cacheUrl URLByAppendingPathComponent:@"test2"] error:&error];

    [super tearDown];
}

- (void)testSingleFile
{
    FileCache *filecache = [[FileCache alloc] initWithName:@"test" andMaxSize: 1];
    STAssertNil([filecache dataForFilename:@"image1"], @"");

    [filecache addData:[@"1" dataUsingEncoding:NSUnicodeStringEncoding] withFilename:@"data1"];
    STAssertNil([filecache dataForFilename:@"image1"], @"");

    NSData *readData = [filecache dataForFilename:@"data1"];
    STAssertNotNil(readData, @"");
    NSString *readString = [[NSString alloc] initWithData:readData encoding:NSUnicodeStringEncoding];
    STAssertEqualObjects(@"1", readString, @"");
}

- (void) testDifferentCacheInstances {
    FileCache *filecache = [[FileCache alloc] initWithName:@"test" andMaxSize: 1];
    [filecache addData:[@"1" dataUsingEncoding:NSUnicodeStringEncoding] withFilename:@"data1"];
    STAssertNotNil([filecache dataForFilename:@"data1"], @"");

    FileCache *filecache2 = [[FileCache alloc] initWithName:@"test" andMaxSize: 1];
    STAssertNotNil([filecache2 dataForFilename:@"data1"], @"");
}

- (void) testDifferentCacheNames {
    FileCache *filecache = [[FileCache alloc] initWithName:@"test" andMaxSize: 1];
    [filecache addData:[@"1" dataUsingEncoding:NSUnicodeStringEncoding] withFilename:@"data1"];
    STAssertNotNil([filecache dataForFilename:@"data1"], @"");
    
    FileCache *filecache2 = [[FileCache alloc] initWithName:@"test2" andMaxSize: 1];
    STAssertNil([filecache2 dataForFilename:@"data1"], @"");
}

- (void) testCacheFull {
    FileCache *filecache = [[FileCache alloc] initWithName:@"test" andMaxSize: 1];
    [filecache addData:[@"1" dataUsingEncoding:NSUnicodeStringEncoding] withFilename:@"data1"];
    [filecache addData:[@"2" dataUsingEncoding:NSUnicodeStringEncoding] withFilename:@"data2"];

    STAssertNil([filecache dataForFilename:@"data1"], @"");
    STAssertNotNil([filecache dataForFilename:@"data2"], @"");
}

@end

//
//  FileCache.m
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "FileCache.h"

@interface FileCache()

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSUInteger maxSize;
@property (nonatomic, readonly) NSURL *cacheDirectoryUrl;
@property (nonatomic, readonly) NSFileManager *fileManager;

@end

@implementation FileCache

@synthesize name = _name, maxSize = _maxSize, cacheDirectoryUrl = _cacheDirectoryUrl, fileManager = _fileManager;

- (id)initWithName:(NSString*) name andMaxSize: (NSUInteger) maxSize {
    self = [super init];
    
    if (self) {
        _name = name;
        _maxSize = maxSize;
        _fileManager = [[NSFileManager alloc] init];
        NSURL *cacheUrl = [[self.fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
        _cacheDirectoryUrl = [cacheUrl URLByAppendingPathComponent:name];
        
        BOOL isDirectory;
        if (![self.fileManager fileExistsAtPath:[self.cacheDirectoryUrl path] isDirectory:&isDirectory]) {
            NSError *error;
            [self.fileManager createDirectoryAtPath:[self.cacheDirectoryUrl path]
                        withIntermediateDirectories:YES attributes:nil error:&error];
        }
    }
    
    return self;
}

- (NSUInteger)folderSize:(NSString *)folderPath {
    NSArray *filesArray = [self.fileManager subpathsOfDirectoryAtPath:folderPath error:nil];
    NSUInteger fileSize = 0;
    
    for (NSString *filename in filesArray) {
        NSDictionary *fileDictionary = [self.fileManager
                                        attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:filename] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    
    return fileSize;
}

- (void)removeOldestFile {
    NSArray *filesArray = [self.fileManager subpathsOfDirectoryAtPath:[self.cacheDirectoryUrl path] error:nil];
    NSDate *oldestFileDate;
    NSString *oldestFilename;
    
    for (NSString *filename in filesArray) {
        NSDictionary *fileDictionary = [self.fileManager
                                        attributesOfItemAtPath:[[self.cacheDirectoryUrl path] stringByAppendingPathComponent:filename] error:nil];
        NSDate *fileDate = [fileDictionary objectForKey:NSFileModificationDate];
        if (!oldestFileDate || fileDate < oldestFileDate)
        {
            oldestFileDate = fileDate;
            oldestFilename = filename;
        }
    }
    
    NSError *error;
    [self.fileManager removeItemAtURL:[self.cacheDirectoryUrl URLByAppendingPathComponent:oldestFilename] error:&error];
}

- (void)addData: (NSData *)data withFilename:(NSString *)filename {
    NSUInteger folderSize = [self folderSize:[self.cacheDirectoryUrl path]];
    if (folderSize > self.maxSize)
        [self removeOldestFile];
    
    [data writeToURL:[self.cacheDirectoryUrl URLByAppendingPathComponent:filename] atomically:YES];
}

- (NSData *)dataForFilename:(NSString *)filename {
    return [NSData dataWithContentsOfURL:[self.cacheDirectoryUrl URLByAppendingPathComponent:filename]];
}

@end

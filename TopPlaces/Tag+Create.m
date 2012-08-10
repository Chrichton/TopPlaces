//
//  Tag+Create.m
//  TopPlaces
//
//  Created by cp on 10.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "Tag+Create.h"

@implementation Tag (Create)

+ (Tag *)tagWithContent:(NSString *)content inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Tag *tag = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    request.predicate = [NSPredicate predicateWithFormat:@"content = %@", content];
    request.sortDescriptors = [NSArray array];
    
    NSError *error = nil;
    NSArray *tags = [context executeFetchRequest:request error:&error];
    
    if (!tags || ([tags count] > 1)) {
        // handle error
    } else if (![tags count]) {
        tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
                                              inManagedObjectContext:context];
        tag.content = content;
    } else {
        tag = [tags lastObject];
    }
    
    return tag;
    
}

@end

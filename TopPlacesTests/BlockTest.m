//
//  BlockTest.m
//  TopPlaces
//
//  Created by cp on 14.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "BlockTest.h"

@implementation BlockTest

typedef NSNumber *(^OperationBlock)(NSNumber *lhs, NSNumber *rhs);

typedef int (^IntFunc)(int x);

- (int) facContinuation: (int)n withContinuation: (IntFunc) function {
    if (n == 0)
        return function(1);
    
    return [self facContinuation:n -1 withContinuation:^int(int x) {
        return function(n * x);
    }];
}

- (int)facRecursive: (int)n {
    IntFunc identity = ^int(int x) {return x;};
    return [self facContinuation:n withContinuation:identity];
}

- (int)facTailRecursive: (int)n accu: (int)m {
    if (n <= 1)
        return m;
    
    return [self facTailRecursive: n - 1 accu: m * n];
}

- (void)displayBlock: (OperationBlock) block {
    NSNumber *result = block(@1, @2);
    NSLog(@"result: %@", result);
}

- (void)testAdd {
    OperationBlock block = ^NSNumber *(NSNumber *lhs, NSNumber *rhs) {
        return [NSNumber numberWithInt: [lhs intValue] + [rhs intValue]];
    };
    
    [self displayBlock:block];

}

- (void)testMult {
    NSString *operation = @"*";
    
    [self displayBlock:^NSNumber *(NSNumber *lhs, NSNumber *rhs) {
        if ([operation isEqualToString:@"*"])
            return [NSNumber numberWithInt: [lhs intValue] * [rhs intValue]];
        else if ([operation isEqualToString:@"+"])
            return [NSNumber numberWithInt: [lhs intValue] + [rhs intValue]];
        
        return @0;
    }];
}

-(void)testFac {
    STAssertEquals(1, [self facRecursive:0], @"");
    STAssertEquals(1, [self facRecursive:1], @"");
    STAssertEquals(6, [self facRecursive:3], @"");
    STAssertEquals(720, [self facRecursive:6], @"");
}

@end

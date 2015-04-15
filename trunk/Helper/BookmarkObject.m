//
//  BookmarkObject.m
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import "BookmarkObject.h"


@implementation BookmarkObject
@synthesize name;
@synthesize pageNumber;
- (id) initWithName:(NSString *)aName andNumber:(NSString *)aNumber {
    if (self = [super init]) {
        self.name = aName;
        self.pageNumber = aNumber;
    }
    return self;
}

- (id) initWithCoder: (NSCoder *)coder {
      self = [self init];
    if (self != nil)
    {
        self.name = [coder decodeObjectForKey: @"name"];
        self.pageNumber = [coder decodeObjectForKey: @"pageNumber"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:pageNumber forKey:@"pageNumber"];
}

- (void) dealloc {
    self.name = nil;
    self.pageNumber = nil;
    [super dealloc];
}

@end

//
//  BookmarkObject.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BookmarkObject : NSObject <NSCoding> {
    NSString *name;
    NSString *pageNumber;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *pageNumber;
- (id) initWithName:(NSString *)aName andNumber:(NSString *)aNumber;

@end

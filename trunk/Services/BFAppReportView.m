//
//  BFAppReportView.m
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFAppReportView.h"

@implementation BFAppReportView
@synthesize PostUsers;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        PostUsers = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 540, 576)];
        [self addSubview:self.PostUsers];
    }
    return self;
}

@end

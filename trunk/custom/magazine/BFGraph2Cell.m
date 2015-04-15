//
//  BFCellForGraph2Cell.m
//  BizFocus-periodical
//
//  Created by Yann on 13-1-25.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFGraph2Cell.h"

@implementation BFGraph2Cell
@synthesize nameLabel;
@synthesize valueLabel;
@synthesize image;
@synthesize ratioLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    self=[super init];
    if (self) {
        [self configure];
    }
    return self;
}
-(void)configure
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

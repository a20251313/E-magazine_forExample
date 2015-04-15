//
//  BFGraph4Cell.m
//  E-magazine
//
//  Created by Yann on 13-1-29.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFTable4Cell.h"

@implementation BFTable4Cell

@synthesize salesLabel;
@synthesize salesTargetLabel;
@synthesize profitTargetLabel;
@synthesize phLabel;
@synthesize profitLabel;
@synthesize ptLabel;
@synthesize shLabel;
@synthesize stLabel;

-(void)tapAction:(UITapGestureRecognizer*)recognizer
{
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

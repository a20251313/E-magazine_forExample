//
//  BFSearchCustomCell.m
//  E-magazine
//
//  Created by mike.sun on 3/14/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFSearchCustomCell.h"

@implementation BFSearchCustomCell
@synthesize titleLabel;
@synthesize numberLabel;

@synthesize title;
@synthesize number;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTitle:(NSString *)titlePar{
    if (![titlePar isEqualToString:title]) {
        title = [titlePar copy];
        titleLabel.text = title;
    }
}
-(void)setNumber:(NSString *)numberPar{
    if (![numberPar isEqualToString:number]) {
        number = [numberPar copy];
        numberLabel.text = number;
    }
}
@end

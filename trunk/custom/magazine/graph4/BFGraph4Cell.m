//
//  BFGraph4Cell.m
//  E-magazine
//
//  Created by Yann on 13-1-29.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFGraph4Cell.h"
@interface BFGraph4Cell ()
{
    BOOL showValue;
}
@end

@implementation BFGraph4Cell

@synthesize arrowImageView;
@synthesize barView;
@synthesize barView2;
@synthesize botton;
@synthesize botton2;
@synthesize flagView;
@synthesize flagView2;
@synthesize hostView;
@synthesize phLabel;
@synthesize profitLabel;
@synthesize ptLabel;
@synthesize shLabel;
@synthesize stLabel;
@synthesize salesLabel;
@synthesize salesTargetLabel;

- (IBAction)clickAction1:(UIButton *)sender {
    if (showValue) {
        showValue=NO;
        [UIView animateWithDuration:0.5 animations:^(void)
        {
//            [salesLabel setHidden:YES];
//            [salesTargetLabel setHidden:YES];
//            [barView setHidden:NO];
//            [flagView setHidden:NO];
            [salesLabel setAlpha:0];
            [salesTargetLabel setAlpha:0];
            [barView setAlpha:1];
            [flagView setAlpha:1];
        }];
        
        
    }else
    {
        showValue=YES;
        [UIView animateWithDuration:0.5 animations:^(void)
         {
//            [salesLabel setHidden:NO];
//            [salesTargetLabel setHidden:NO];
//            [barView setHidden:YES];
//            [flagView setHidden:YES];
             [salesLabel setAlpha:1];
             [salesTargetLabel setAlpha:1];
             [barView setAlpha:0];
             [flagView setAlpha:0];
         }];
        
    }
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

        [botton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

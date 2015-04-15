//
//  BFMiniSearchView.m
//  E-magazine
//
//  Created by mike.sun on 3/22/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFMiniSearchView.h"
#import "Page0.h"

@implementation BFMiniSearchView
@synthesize cancelButton;
@synthesize prevButton;
@synthesize nextButton;
@synthesize fullButton;
@synthesize delegate;
@synthesize arrPages;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (IBAction)cancelAct:(UIBarButtonItem *)sender {
    for (int i=0; i<arrPages.count; i++) {
        Page0 *page = (Page0 *)[arrPages objectAtIndex:i];
        [page setText];
    }
    [delegate searchCancelAct];
}
- (IBAction)prevAct:(UIBarButtonItem *)sender {
    [delegate miniSearchPrevSwitchAct];
}
- (IBAction)nextAct:(UIBarButtonItem *)sender {
    [delegate miniSearchNextSwitchAct];
}
- (IBAction)fullAct:(UIBarButtonItem *)sender {
    [delegate miniSearchFullAct];
}

- (void)setBtnDisable:(BOOL)bCanPre canNext:(BOOL)bCanNext{
    prevButton.enabled = YES;
    nextButton.enabled = YES;
    if (!bCanPre) {
        prevButton.enabled = NO;
    }
    if (!bCanNext){
        nextButton.enabled = NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  UIGridViewRow.m
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIGridViewRow.h"
#import "BookCover.h"


@implementation UIGridViewRow
@synthesize imageViewShell;
@synthesize arrBooks;
@synthesize delegate;
@synthesize iRow;

- (void)setArrBooks:(NSMutableArray *)_arrBooks{
    if (arrBooks != _arrBooks) {
        [arrBooks release];
        arrBooks = [_arrBooks retain];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[GridView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i=0; i<arrBooks.count; i++) {
        BookCover *bookCover = (BookCover *)[arrBooks objectAtIndex:i];
        GridView *gridView = (GridView *)[[[NSBundle mainBundle] loadNibNamed:@"GridView" owner:nil options:nil] lastObject];
        gridView.bookCover = bookCover;
        gridView.delegate = self;
        Position *position = [[Position alloc] init];
        position.iRow = self.iRow;
        position.iCol = i;
        gridView.pos = position;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            gridView.frame = CGRectMake(50+i*167, 0, 120, 200);
        }else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            gridView.frame = CGRectMake(64+i*224, 0, 120, 200);
        }
        [self addSubview:gridView];
    }
}

#pragma mark - GribViewDelegate
- (void)didPressedBtn:(Position *)position{
    if ([self.delegate respondsToSelector:@selector(didPressedGrid:)]) {
        [self.delegate didPressedGrid:position];
    }
}

- (void)dealloc {
    self.imageViewShell = nil;
    self.arrBooks = nil;
    [super dealloc];
}


@end

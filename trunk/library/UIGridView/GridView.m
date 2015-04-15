//
//  GridView.m
//  E-magazine
//
//  Created by summer.zhu on 5/24/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "GridView.h"

@implementation Position

@synthesize iRow;
@synthesize iCol;

@end

@implementation GridView

@synthesize bookCover;
@synthesize pos;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBookCover:(BookCover *)_bookCover{
    if (bookCover != _bookCover) {
        [bookCover release];
        bookCover = [_bookCover retain];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    lblBookName.text = bookCover.strBookName;
    imageViewBook.image = [UIImage imageNamed:bookCover.strBookImageName];
}


- (IBAction)didPressedBtn:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didPressedBtn:)]) {
        [self.delegate didPressedBtn:self.pos];
    }
}

- (void)dealloc{
    [lblBookName release];
    [imageViewBook release];
    self.bookCover = nil;
    self.pos = nil;
    [super dealloc];
}

@end

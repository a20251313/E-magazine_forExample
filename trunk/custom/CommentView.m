//
//  CommentView.m
//  Magazine
//
//  Created by mac  on 13-1-24.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import "CommentView.h"

@implementation CommentView
@synthesize  delegate,comment;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        UIImageView *bg=[[UIImageView alloc]initWithFrame:self.frame];
        [bg setImage:[UIImage imageNamed:@"sn5.png" ]];
        [self addSubview:bg];
        
        
        UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(15,213, 78, 34)];
        [close setBackgroundImage:[UIImage imageNamed:@"sn6.png"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close];

        
        UIButton *enter=[[UIButton alloc]initWithFrame:CGRectMake(410,213, 78, 39)];
        [enter setBackgroundImage:[UIImage imageNamed:@"sn7.png"] forState:UIControlStateNormal];
        [enter addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:enter];

        comment=[[UITextField alloc]initWithFrame:CGRectMake(15, 75, 475,130)];
        [comment setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:comment];
    }
    return self;
}

-(void)closed{
    [delegate dismissComment];
}
-(void)enter{
    [delegate PostComment:comment.text];
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

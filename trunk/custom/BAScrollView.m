//
//  BAScrollView.m
//  BizFocus-periodical
//
//  Created by Yann on 13-1-21.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BAScrollView.h"
#import "FTCoreTextView.h"
@implementation BAScrollView
{
    NSInteger totalPage;
    
    //NSInteger currentPage;
}
@synthesize myDelegate;
@synthesize dataSource;
@synthesize currentPage;

//-(void)scrollToPage:(NSInteger)page
//{
//    currentPage=page;
//    CGRect frame = CGRectMake(self.frame.size.width*page, 0, self.frame.size.width, self.frame.size.height);
//    [self scrollRectToVisible:frame animated:YES];
//}
-(void)scrollToPage:(NSNotification*)ns
{
    NSNumber *pageNumber=[[ns userInfo]objectForKey:@"page"];
    NSInteger page=[pageNumber integerValue];
    currentPage=page;
    CGRect frame = CGRectMake(self.frame.size.width*page, 0, self.frame.size.width, self.frame.size.height);
    [self scrollRectToVisible:frame animated:YES];
    //self.contentOffset=CGPointMake(currentPage*self.frame.size.width, self.frame.size.height);
    [self didScrollToPage:page];
    [self renderContent];
}
-(void)didScrollToPage:(NSInteger)page
{
    if ([myDelegate respondsToSelector:@selector(didScrollToPage:page:)]) {
        [myDelegate didScrollToPage:self page:page];
    }
}
-(void)renderContent
{
//    for (int i=0; i<3;i++) {
//        if ([self viewWithTag:10+i]) {
//            [[self viewWithTag:10+i] removeFromSuperview];
//        }
//        int t=currentPage-(1-i);
//        FTCoreTextView *textView=[[FTCoreTextView alloc]initWithFrame:CGRectMake(100+t*self.frame.size.width, 60, self.frame.size.width-200, self.frame.size.height-120)];
//        [textView setTag:10+i];
//        textView.backgroundColor=[UIColor grayColor];
//        //textView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//        textView.autoresizingMask=UIViewAutoresizingNone;
//        [self addSubview:textView];
//    }
    FTCoreTextView *textView=[[FTCoreTextView alloc]initWithFrame:CGRectMake(100+currentPage*self.frame.size.width, 60, self.frame.size.width-200, self.frame.size.height-120)];
    textView.delegate=self;
    [textView addStyles:[self coreTextStyle]];
    [textView setTag:10];
    textView.backgroundColor=[UIColor whiteColor];
    textView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    textView.text=@"<title>Giraffe</title><firstLetter>T</firstLetter>he giraffe (Giraffa camelopardalis) is an 的减肥底价  mammal,<_link>http://en.wikipedia.org/wiki/Giraffe|dddddddddddddddd</_link> the tallest of all extant land-living animal species, and the largest ruminant. Its scientific name,<_link>http://en.wikipedia.org/wiki/Giraffe|漏2011 - Wikipedia</_link> which is similar to its archaic English name of camelopard, refers to its irregular patches of color on a light background.<_image>icon05.png</_image><subtitle>Subspecies</subtitle>Different authorities recognize different numbers of subspecies,<_link>http://en.wikipedia.org/wiki/Giraffe|漏2011 - Wikipedia</_link> differentiated by <bold>size</bold>, <colored>color</colored> and <italic>pattern</italic> variations and range. Some of these subspecies may prove to be separate species as they appear to be reproductively isolated despite their mobility. The subspecies recognized by most recent authorities are:<_bullet>G. c. camelopardalis</_bullet><_bullet>G. c. reticulata</_bullet><_bullet>G. c. reticulata</_bullet><_bullet>G. c. angolensis</_bullet><_bullet>G. c. antiquorum</_bullet><_bullet>G. c. tippelskirchi</_bullet><_bullet>G. c. rothschildi</_bullet><_bullet>G. c. giraffa</_bullet><_bullet>G. c. thornicrofti</_bullet><subtitle>Swimming</subtitle>Although no definitive study has been publicly conducted,<_link>http://en.wikipedia.org/wiki/Giraffe|漏2011 - Wikipedia</_link> giraffes are assumed to be unable to swim. It has been estimated that the giraffe's proportionally larger limbs have very high rotational inertias and this would make rapid swimming motions strenuous.<_link>http://en.wikipedia.org/wiki/Giraffe|漏2011 - Wikipedia</_link>";
    [self addSubview:textView];
}
-(void)adjust
{
    NSLog(@"++++++++++++++%@",self);
//    UIDevice *device=[UIDevice currentDevice];
//    if (UIDeviceOrientationIsLandscape(device.orientation)) {
//        self.frame=CGRectMake(0, 0, 1004, 748);
//    }else
//    {
//        self.frame=CGRectMake(0, 0, 748, 1004);
//    }
    self.contentSize=CGSizeMake(self.frame.size.width*totalPage, self.frame.size.height);
    //self.contentOffset=CGPointMake(currentPage*self.frame.size.width, self.frame.size.height);
//    NSLog(@"++++++++++++++%@",self);
}
-(void)configure
{
    
    if ([dataSource respondsToSelector:@selector(numberOfPage)]) {
        totalPage=[dataSource numberOfPage];
        [self adjust];
    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(scrollToPage:)
               name:@"scrollToPageNotification"
             object:nil];
}

#pragma mark -
#pragma mark FTCoreText method implementation
- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
	FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
	defaultStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:20.f];
	defaultStyle.textAlignment = FTCoreTextAlignementJustified;
	[result addObject:defaultStyle];
	
	
	FTCoreTextStyle *titleStyle = [FTCoreTextStyle styleWithName:@"title"]; // using fast method
	titleStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:40.f];
	titleStyle.paragraphInset = UIEdgeInsetsMake(0, 0, 25, 0);
	titleStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:titleStyle];
	
	FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
	imageStyle.paragraphInset = UIEdgeInsetsMake(0,0,0,0);
	imageStyle.name = FTCoreTextTagImage;
	imageStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:imageStyle];

	
	FTCoreTextStyle *firstLetterStyle = [FTCoreTextStyle new];
	firstLetterStyle.name = @"firstLetter";
	firstLetterStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:30.f];
	[result addObject:firstLetterStyle];

	
	FTCoreTextStyle *linkStyle = [defaultStyle copy];
	linkStyle.name = FTCoreTextTagLink;
	linkStyle.color = [UIColor orangeColor];
	[result addObject:linkStyle];

	
	FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
	subtitleStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25.f];
	subtitleStyle.color = [UIColor brownColor];
	subtitleStyle.paragraphInset = UIEdgeInsetsMake(10, 0, 10, 0);
	[result addObject:subtitleStyle];
	
	FTCoreTextStyle *bulletStyle = [defaultStyle copy];
	bulletStyle.name = FTCoreTextTagBullet;
	bulletStyle.bulletFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:16.f];
	bulletStyle.bulletColor = [UIColor orangeColor];
	bulletStyle.bulletCharacter = @"❧";
	[result addObject:bulletStyle];

    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
	italicStyle.name = @"italic";
	italicStyle.underlined = YES;
    italicStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16.f];
	[result addObject:italicStyle];

    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
	boldStyle.name = @"bold";
    boldStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:16.f];
	[result addObject:boldStyle];

    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    [coloredStyle setColor:[UIColor redColor]];
	[result addObject:coloredStyle];

    
    return  result;
}

- (void)coreTextView:(FTCoreTextView *)acoreTextView receivedTouchOnData:(NSDictionary *)data {
    
    CGRect frame = CGRectFromString([data objectForKey:FTCoreTextDataFrame]);
    
    if (CGRectEqualToRect(CGRectZero, frame)) return;
    
    frame.origin.x -= 3;
    frame.origin.y -= 1;
    frame.size.width += 6;
    frame.size.height += 6;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view.layer setCornerRadius:3];
    [view setBackgroundColor:[UIColor orangeColor]];
    [view setAlpha:0];
    [acoreTextView.superview addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        [view setAlpha:0.4];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [view setAlpha:0];
        }];
    }];
    
    return;
    
    NSURL *url = [data objectForKey:FTCoreTextDataURL];
    if (!url) return;
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark -
#pragma mark system method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        currentPage=0;
    }
    return self;
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

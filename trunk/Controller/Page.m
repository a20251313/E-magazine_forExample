//
//  Page.m
//  E-magazine
//
//  Created by summer.zhu on 4/18/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "Page.h"
#import "CoreText/CoreText.h"

@implementation Page

@synthesize totalLengthInContentPagePor;
@synthesize totalLengthInContentPage;
@synthesize iRows;
@synthesize iViewControllerIndex;
@synthesize vcAndPage;
@synthesize baText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeFrames:)
                                                     name:InterfaceOrientation
                                                   object:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
}

//初始化纯文本页文字的长度 该长度不仅和矩形有关还和文字有关
- (void)initTotalLength:(NSAttributedString *)strAttributeContent{
    [self initTestAttributeString:strAttributeContent];
    NSInteger iToalLength = 0;
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithAttributedString:testAttributeString];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<baTextTest.arrRectsPor.count; i++) {
            CGRect rect = CGRectFromString([baTextTest.arrRectsPor objectAtIndex:i]);
            int length = [self getLengthInRect:tempStr rect:rect];
            NSRange rang = NSMakeRange(0, length);
            [tempStr replaceCharactersInRange:rang withString:@""];
            iToalLength = iToalLength + length;
        }
        totalLengthInContentPagePor = iToalLength;
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<baTextTest.arrRects.count; i++) {
            CGRect rect = CGRectFromString([baTextTest.arrRects objectAtIndex:i]);
            int length = [self getLengthInRect:tempStr rect:rect];
            NSRange rang = NSMakeRange(0, length);
            [tempStr replaceCharactersInRange:rang withString:@""];
            iToalLength = iToalLength + length;
        }
        totalLengthInContentPage = iToalLength;
    }
    [tempStr release];
}

-(void)changeFrames:(NSNotification *)notification{
    NSInteger iToalLength = 0;
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithAttributedString:testAttributeString];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<baTextTest.arrRectsPor.count; i++) {
            CGRect rect = CGRectFromString([baTextTest.arrRectsPor objectAtIndex:i]);
            int length = [self getLengthInRect:tempStr rect:rect];
            NSRange rang = NSMakeRange(0, length);
            [tempStr replaceCharactersInRange:rang withString:@""];
            iToalLength = iToalLength + length;
        }
        totalLengthInContentPagePor = iToalLength;
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<baTextTest.arrRects.count; i++) {
            CGRect rect = CGRectFromString([baTextTest.arrRects objectAtIndex:i]);
            int length = [self getLengthInRect:tempStr rect:rect];
            NSRange rang = NSMakeRange(0, length);
            [tempStr replaceCharactersInRange:rang withString:@""];
            iToalLength = iToalLength + length;
        }
        totalLengthInContentPage = iToalLength;
    }
    [tempStr release];
}

- (void)initTestAttributeString:(NSAttributedString *)strAttributeContent{
    baTextTest = [[BAText alloc] init];
    baTextTest.text = strAttributeContent.string;
    baTextTest.iTitleFontSize = 35;
    baTextTest.iTitleLength = 0;
    baTextTest.strTitlFontName = @"Helvetica";
    baTextTest.iContentFontSize = 14;
    baTextTest.strContentFontName = @"Helvetica";
    CGRect rect1 = CGRectMake(46, 64, 278, 623);
    CGRect rect2 = CGRectMake(46*2+278, 64, 278, 623);
    CGRect rect3 = CGRectMake(46*3+278*2, 64, 278, 623);
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:NSStringFromCGRect(rect1), NSStringFromCGRect(rect2), NSStringFromCGRect(rect3), nil];
    baTextTest.arrRects = arr;
    [arr release];
    
    CGRect rect4 = CGRectMake(64, 64, 308, 879);
    CGRect rect5 = CGRectMake(64+308+24, 64, 308, 879);
    NSMutableArray *arrPor = [[NSMutableArray alloc] initWithObjects:NSStringFromCGRect(rect4), NSStringFromCGRect(rect5), nil];
    baTextTest.arrRectsPor = arrPor;
    [arrPor release];
    
    
    testAttributeString = [[NSMutableAttributedString alloc] initWithAttributedString:strAttributeContent];
}

- (int)getLengthInRect:(NSAttributedString *)string rect:(CGRect)rect{
    int currentIndex = 0;
    int lineall = 0;
    bool start = true;
    
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)string);
    while (start) {
        int lineLength = CTTypesetterSuggestLineBreak(typeSetter, currentIndex, rect.size.width);
        
        if (lineLength >= string.length) {
            CFRelease(typeSetter);
            return string.length;
        }
        
        lineall ++;
        if (currentIndex+lineLength >= string.length) {
            CFRelease(typeSetter);
            return string.length;
        }
        currentIndex = currentIndex+lineLength;
        
        if ((lineall + 1)*20 > rect.size.height) {
            CFRelease(typeSetter);
            return currentIndex;
        }
        
    }
    CFRelease(typeSetter);
    return 0;
}
- (int)getAttributedStringHeightWithString:(NSMutableAttributedString *)string WidthValue:(int)width{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *)CTFrameGetLines(textFrame);
    iRows = linesArray.count+1;
    CGPoint origins[linesArray.count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int)origins[[linesArray count]-1].y;
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (CTLineRef)[linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int)descent + 1;
    
    CFRelease(textFrame);
    
    return total_height;
}

-(Page *)getTargetAndIndex{
    return self;
}

-(void)setKeyWordFontWithData:(NSDictionary *)dataDic{
    
}

-(void)setText{
    
}

-(void)setText:(NSString *)strSearchWordPara{
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [testAttributeString release];
    [baTextTest release];
    self.baText = nil;
    self.vcAndPage = nil;
    [super dealloc];
}

@end

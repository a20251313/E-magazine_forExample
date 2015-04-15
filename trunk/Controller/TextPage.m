//
//  TextPage.m
//  E-magazine
//
//  Created by summer.zhu on 5/2/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "TextPage.h"
#import "CoreText/CoreText.h"

@implementation TextPage
@synthesize Label1;
@synthesize attributeString;
@synthesize attributeStringOriginal;
@synthesize strSearchWord;
@synthesize keyWordsDic;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        Label1 = [[CustomUILabel alloc] init];
        
        BAText *baSubText = [[BAText alloc] init];
        baSubText.text = attributeString.string;
        baSubText.iTitleFontSize = 35;
        baSubText.iTitleLength = 0;
        baSubText.strTitlFontName = @"Helvetica";
        baSubText.iContentFontSize = 14;
        baSubText.strContentFontName = @"Helvetica";
        CGRect rect1 = CGRectMake(46, 64, 278, 623);
        CGRect rect2 = CGRectMake(46*2+278, 64, 278, 623);
        CGRect rect3 = CGRectMake(46*3+278*2, 64, 278, 623);
        baSubText.arrRects = [[NSMutableArray alloc] initWithObjects:NSStringFromCGRect(rect1), NSStringFromCGRect(rect2), NSStringFromCGRect(rect3), nil];
        
        CGRect rect4 = CGRectMake(64, 64, 308, 879);
        CGRect rect5 = CGRectMake(64+308+24, 64, 308, 879);
        baSubText.arrRectsPor = [[NSMutableArray alloc] initWithObjects:NSStringFromCGRect(rect4), NSStringFromCGRect(rect5), nil];
        self.baText = baSubText;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeFrames:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        Label1.frame = CGRectMake(0, 0, 768, 1004);
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        Label1.frame = CGRectMake(0, 0, 1024, 748);
    }
    [self addSubview:Label1];
    [self setText];
    Label1.backgroundColor = [UIColor whiteColor];
}

-(NSDictionary*)searchWordInPage:(NSString *) keyword searchContent:(NSString *)searchContent{
    NSString *searchData = searchContent;
    NSString *string1 = searchData;
    NSString *string2 = keyword;
    int indexMark;
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSRange range = [string1 rangeOfString:string2];
    int location = range.location;
    int leight = range.length;
    indexMark = location;
    
    for (int i=indexMark;i<searchData.length;i=indexMark) {
        if((location<string1.length)&&(leight>0)) {
            NSString *tempStr = [NSString stringWithFormat:@"%d",i];
            NSString *tempStr2 = [NSString stringWithFormat:@"%d",leight];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:tempStr2,tempStr,nil];
            
            string1 = [string1 substringFromIndex:(location+leight)];
            range = [string1 rangeOfString:string2];
            location = range.location;
            leight = range.length;
            indexMark = location+indexMark+range.length;
            [tempArr addObject:dic];
        }
    }
    if (tempArr.count > 0) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        [result setValue:tempArr forKey:[searchData substringToIndex:25]];
        return  result;
    }
    return  nil;
}

-(void)setText{
    [self initAttributeString];
    self.attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStringOriginal];
    strSearchWord = nil;
    keyWordsDic = nil;
    Label1.text = self.attributeString.string;
    
    
    Label1.attributedText = attributeString;
    Label1.linespec=20;//行间距
    Label1.textColor = [UIColor colorWithRed:69.0f/255.0f green:69.0f/255.0f blue:70.0f/255.0f alpha:1];
    for (int i=0; i<self.baText.arrKeywords.count; i++) {
        KeyWord *keyWord = (KeyWord *)[self.baText.arrKeywords objectAtIndex:i];
        [Label1 addKeyWord:keyWord];
    }
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        [Label1.ImageRects removeAllObjects];
        for (int i=0; i<self.baText.arrRectsPor.count; i++) {
            NSString *strRect = [self.baText.arrRectsPor objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            [Label1 addRect:rect];
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        [Label1.ImageRects removeAllObjects];
        for (int i=0; i<self.baText.arrRects.count; i++) {
            NSString *strRect = [self.baText.arrRects objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            [Label1 addRect:rect];
        }
    }
    
    [Label1 setNeedsDisplay];
}

-(void)setText:(NSString *)strSearchWordPara{
    self.keyWordsDic = nil;
    self.strSearchWord = strSearchWordPara;
    self.keyWordsDic = [self searchWordInPage:strSearchWord searchContent:self.attributeString.string];
    if (self.keyWordsDic.count > 0) {
        self.attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStringOriginal];
        [self setKeyWordFontWithData:self.keyWordsDic];
    }else{
        [self setText];
    }
    
}

-(void)setKeyWordFontWithData:(NSDictionary *)dataDic{
    keyWordsDic = nil;
    keyWordsDic = dataDic;
    Label1.text = self.attributeString.string;
    //搜索字着色
    NSString *strSearchResult = [[dataDic allKeys] objectAtIndex:0];
    NSMutableArray *arrValues = [dataDic objectForKey:strSearchResult];
    
    for (id aDic in arrValues) {
        NSString *position = [[aDic allKeys] objectAtIndex:0];//只有一个key和value
        NSString *length = [aDic objectForKey:position];
        NSRange range = NSMakeRange([position integerValue],
                                    [length integerValue]);
        
        [attributeString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor greenColor]CGColor] range:range];
    }
    
    Label1.attributedText = attributeString;
    Label1.linespec=20;//行间距
    
    for (int i=0; i<self.baText.arrKeywords.count; i++) {
        KeyWord *keyWord = (KeyWord *)[self.baText.arrKeywords objectAtIndex:i];
        [Label1 addKeyWord:keyWord];
    }
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        [Label1.ImageRects removeAllObjects];
        for (int i=0; i<self.baText.arrRectsPor.count; i++) {
            NSString *strRect = [self.baText.arrRectsPor objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            [Label1 addRect:rect];
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        [Label1.ImageRects removeAllObjects];
        for (int i=0; i<self.baText.arrRects.count; i++) {
            NSString *strRect = [self.baText.arrRects objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            [Label1 addRect:rect];
        }
    }
    
    [Label1 setNeedsDisplay];
}

-(void)initAttributeString{
    if (self.attributeString.length <= 0) {
        self.attributeString = [[NSMutableAttributedString alloc] initWithString:self.baText.text];
        UIColor *color = [UIColor colorWithRed:69.0f/255.0f green:69.0f/255.0f blue:70.0f/255.0f alpha:1];
        [attributeString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[color CGColor] range:NSMakeRange(0,self.baText.text.length)];
        
        for (int i=0; i<self.baText.arrAttributeColors.count; i++) {
            UIColor *color = [self.baText.arrAttributeColors objectAtIndex:i];
            NSString *str = [self.baText.arrAttributeRanges objectAtIndex:i];
            NSRange range = NSRangeFromString(str);
            
            [attributeString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[color CGColor] range:range];
        }
        
        CTFontRef  font_world1 = CTFontCreateWithName((__bridge CFStringRef)self.baText.strTitlFontName,self.baText.iTitleFontSize,NULL);
        [attributeString addAttribute: (NSString*)(kCTFontAttributeName) value:(__bridge id)font_world1 range:NSMakeRange(0,self.baText.iTitleLength)];
        
        CTFontRef  font_world2 = CTFontCreateWithName((__bridge CFStringRef)self.baText.strContentFontName,self.baText.iContentFontSize,NULL);
        [attributeString addAttribute: (NSString*)(kCTFontAttributeName) value:(__bridge id)font_world2 range:NSMakeRange(self.baText.iTitleLength,[self.baText.text length]-self.baText.iTitleLength)];
    }
}

-(void)changeFrames:(NSNotification *)notification {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        Label1.frame=CGRectMake(0, 0, 768, 1004);
        //重新绘制文字
        if(self.strSearchWord.length <= 0){
            [self setText];
        }else{
            [self setText:self.strSearchWord];
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        Label1.frame = CGRectMake(0,0, 1024, 748);
        if(self.strSearchWord.length <= 0){
            [self setText];
        }else{
            self.keyWordsDic = [self searchWordInPage:self.strSearchWord searchContent:self.attributeString.string];
            [self setKeyWordFontWithData:self.keyWordsDic];
        }
    }
}

@end

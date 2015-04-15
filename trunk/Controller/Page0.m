//
//  Page0.m
//  E-magazine
//
//  Created by mac  on 13-2-3.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "Page0.h"
#import "CustomUILabel.h"
#import "CoreText/CoreText.h"
#import "KeyWord.h"
#import "Widget1.h"
#import "BFGraphViewController1.h"
#import "TextPage.h"
#import "ImagePath.h"
#import "BFPieViewController.h"

@interface Page0 ()
{
    Widget1 *wgt;
}
@end
@implementation Page0
@synthesize pieMini;
@synthesize keyWordsDic;
@synthesize attributeString;
@synthesize Label1;
@synthesize delegate;
@synthesize buttonTag;
@synthesize arrViews;
@synthesize movie;
@synthesize arrViewsAttributeString;
@synthesize frameDelegate;
@synthesize graphicsDelegate;
@synthesize strSearchWord;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        keyWordsDic = [[NSDictionary alloc] init];
        BGPics = [[NSMutableArray alloc] init];
        allPics = [[NSMutableArray alloc] init];
        arrViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    Label1 = [[CustomUILabel alloc] init];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        if ([self.baText.arrBGRectPor count] != 0) {
            for (int i=0; i<[self.baText.arrBGRectPor count]; i++) {
                NSString *strBGRectPor = [self.baText.arrBGRectPor objectAtIndex:i];
                CGRect rect = CGRectFromString(strBGRectPor);
                NSString *strBGNamePor = [self.baText.arrBGNamesPor objectAtIndex:i];
                
                UIImageView *BGPor = [[UIImageView alloc] initWithFrame:rect];
                BGPor.image = [UIImage imageWithContentsOfFile:[ImagePath getImagePath:strBGNamePor]];
                [BGPics addObject:BGPor];
                [self addSubview:BGPor];
                [BGPor release];
            }
        }
        
        Label1.frame = CGRectMake(0, 0, 768, 1004);
        [self addSubview:Label1];
        [self setText];
        
        for (int i=0; i<[self.baText.arrPicRectPor count]; i++) {
            NSString *strRectPor = [self.baText.arrPicRectPor objectAtIndex:i];
            CGRect rectPor = CGRectFromString(strRectPor);
            NSString *strNamePor = [self.baText.arrPicNamesPor objectAtIndex:i];
            
            PicButton *pic = [[PicButton alloc] initWithFrame:rectPor];
            pic.selectorName = [self.baText.arrPushClassNames objectAtIndex:i];
            [pic setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strNamePor]] forState:UIControlStateNormal];
            if (pic.selectorName.length > 0) {
                [pic addTarget:self action:@selector(pushController:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                [pic setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strNamePor]] forState:UIControlStateHighlighted];
            }
            [allPics addObject:pic];
            [self addSubview:pic];
            [pic release];
        }
        if ((int)buttonTag == 100) {
            wgt=[[Widget1 alloc]initWithFrame:CGRectMake(512, 92 , 222, 645)];
            [Label1 addSubview:wgt];
        }
        
#warning PIE
        if ([self.baText.arrBGRectPor count] >0 ) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"BFMiniPieView" owner:self options:nil];
            self.pieMini = [nibs objectAtIndex:0];
            pieMini.frame = CGRectMake(386, 373, 292, 398);
            pieMini.delegate = self;
            [self addSubview:pieMini];
        }
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        if ([self.baText.arrBGRect count] != 0) {
            for (int i=0; i<[self.baText.arrBGRect count]; i++) {
                NSString *strBGRect = [self.baText.arrBGRect objectAtIndex:i];
                CGRect rect = CGRectFromString(strBGRect);
                NSString *strBGName = [self.baText.arrBGNames objectAtIndex:i];
                UIImageView *BG = [[UIImageView alloc] initWithFrame:rect];
                BG.image = [UIImage imageWithContentsOfFile:[ImagePath getImagePath:strBGName]];
                [BGPics addObject:BG];
                [self addSubview:BG];
                [BG release];
            }
        }
        
        Label1.frame = CGRectMake(0, 0, 1024, 748);
        [self addSubview:Label1];
        [self setText];
        for (int i=0; i<[self.baText.arrPicRect count]; i++) {
            NSString *strRect = [self.baText.arrPicRect objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            NSString *strName = [self.baText.arrPicNames objectAtIndex:i];
            
            PicButton *pic = [[PicButton alloc] initWithFrame:rect];
            pic.selectorName = [self.baText.arrPushClassNames objectAtIndex:i];
            [pic setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]] forState:UIControlStateNormal];
            if (pic.selectorName.length > 0) {
                [pic addTarget:self action:@selector(pushController:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                [pic setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]] forState:UIControlStateHighlighted];
            }
            
            [allPics addObject:pic];
            [self addSubview:pic];
            [pic release];
        }
        if ((int)buttonTag == 100) {
            wgt=[[Widget1 alloc]initWithFrame:CGRectMake(654, 64 , 303, 645)];
            [Label1 addSubview:wgt];
        }
        
#warning PIE
        if ([self.baText.arrBGRect count] >0 ) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"BFMiniPieView" owner:self options:nil];
            self.pieMini = [nibs objectAtIndex:0];
            pieMini.frame = CGRectMake(533, 324, 292, 398);
            pieMini.delegate = self;
            [self addSubview:pieMini];
        }
        
    }
    
    if ([allPics count]>0) {
        Label1.backgroundColor = [UIColor clearColor];
    }
    else{
        Label1.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - BFMiniPieDelegate
- (void)showAllScreen{
    if([self.graphicsDelegate respondsToSelector:@selector(showGraphicsAllScreen)]){
        [self.graphicsDelegate showGraphicsAllScreen];
    }
}

-(void)changeFramesWhenRotate {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        if (movie) {
            [self stopMovie];
        }
        Label1.frame=CGRectMake(0, 0, 768, 1004);
        //其余各个页面的数据源
        [self refreshViewsDataSource];
        //重新绘制文字
        if (self.strSearchWord.length > 0) {
            [self setText:self.strSearchWord];
        }else {
            [self setText];
        }
        //重新布局BGbutton的位置
        for (int i= 0; i<[self.baText.arrBGRectPor count]; i++) {
            NSString *strRect = [self.baText.arrBGRectPor objectAtIndex:i];
            NSString *strName = [self.baText.arrBGNamesPor objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            if ([BGPics count]) {
                UIImageView *imageBG = (UIImageView *)[BGPics objectAtIndex:i];
                [imageBG setFrame:rect];
                imageBG.image = [UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]];
            }
        }
        //重新布局button的位置
        for (int i= 0; i<[self.baText.arrPicRectPor count]; i++) {
            NSString *strRect = [self.baText.arrPicRectPor objectAtIndex:i];
            NSString *strName = [self.baText.arrPicNamesPor objectAtIndex:i];
            NSString *selectorName = [self.baText.arrPushClassNames objectAtIndex:i];
            
            CGRect rect = CGRectFromString(strRect);
            if ([allPics count] != 0) {
                UIButton *btn = (UIButton *)[allPics objectAtIndex:i];
                [btn setFrame:rect];
                [btn setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]] forState:UIControlStateNormal];
                if (selectorName.length==0) {
                    [btn setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]] forState:UIControlStateHighlighted];
                }
            }
        }
        if ([self.baText.arrBGRectPor count] >0 ) {
            pieMini.frame = CGRectMake(386, 373, 292, 398);
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        if (movie) {
            [self stopMovie];
        }
        Label1.frame = CGRectMake(0,0, 1024, 748);
        //其余各个页面的数据源
        [self refreshViewsDataSource];
        //重新绘制文字
        if (self.strSearchWord.length > 0) {
            self.keyWordsDic = [self searchWordInPage:self.strSearchWord searchContent:self.attributeString.string];
            [self setKeyWordFontWithData:keyWordsDic];
        }else {
            [self setText];
        }
        //重新布局BGbutton的位置
        for (int i= 0; i<[self.baText.arrBGRect count]; i++) {
            NSString *strRect = [self.baText.arrBGRect objectAtIndex:i];
            NSString *strName = [self.baText.arrBGNames objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            if ([BGPics count]) {
                UIImageView *imageBG = (UIImageView *)[BGPics objectAtIndex:i];
                [imageBG setFrame:rect];
                imageBG.image = [UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]];
            }
        }
        
        //重新布局button的位置
        for (int i= 0; i<[self.baText.arrPicRect count]; i++) {
            NSString *strRect = [self.baText.arrPicRect objectAtIndex:i];
            NSString *strName = [self.baText.arrPicNames objectAtIndex:i];
            NSString *selectorName = [self.baText.arrPushClassNames objectAtIndex:i];
            CGRect rect = CGRectFromString(strRect);
            if ([allPics count] != 0) {
                UIButton *btn = (UIButton *)[allPics objectAtIndex:i];
                [btn setFrame:rect];
                [btn setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]] forState:UIControlStateNormal];
                if (selectorName.length==0) {
                    [btn setImage:[UIImage imageWithContentsOfFile:[ImagePath getImagePath:strName]] forState:UIControlStateHighlighted];
                }
            }
        }
        
        if ([self.baText.arrBGRect count] >0 ) {
            pieMini.frame = CGRectMake(533, 324, 292, 398);
        }
    }
}

-(void)pushController:(PicButton *)btn{
    if ([self.delegate respondsToSelector:@selector(pushControllerAtPic:)]) {
        NSString *pushClassName = btn.selectorName;
        if (pushClassName.length>0) {
            if ([pushClassName isEqualToString:@"playmovie"]) {
                [self playmovie];
            }
            else{
                [self.delegate pushControllerAtPic:pushClassName];
            }
        }
        else{
            return;
        }
    }
}

-(void)initAttributeString{
    attributeString = [[NSMutableAttributedString alloc] initWithString:self.baText.text];
    UIColor *color = [UIColor colorWithRed:69.0f/255.0f green:69.0f/255.0f blue:70.0f/255.0f alpha:1];
    [attributeString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[color CGColor] range:NSMakeRange(0,self.baText.text.length)];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<self.baText.arrAttributeColorsPor.count; i++) {
            UIColor *color = [self.baText.arrAttributeColorsPor objectAtIndex:i];
            NSString *str = [self.baText.arrAttributeRangesPor objectAtIndex:i];
            NSRange range = NSRangeFromString(str);
            
            [attributeString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[color CGColor] range:range];
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<self.baText.arrAttributeColors.count; i++) {
            UIColor *color = [self.baText.arrAttributeColors objectAtIndex:i];
            NSString *str = [self.baText.arrAttributeRanges objectAtIndex:i];
            NSRange range = NSRangeFromString(str);
            
            [attributeString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[color CGColor] range:range];
        }
    }
    
    CTFontRef  font_world1 = CTFontCreateWithName((CFStringRef)self.baText.strTitlFontName,self.baText.iTitleFontSize,NULL);
    [attributeString addAttribute: (NSString*)(kCTFontAttributeName) value:(id)font_world1 range:NSMakeRange(0,self.baText.iTitleLength)];
    CFRelease(font_world1);
    
    CTFontRef  font_world2 = CTFontCreateWithName((CFStringRef)self.baText.strContentFontName,self.baText.iContentFontSize,NULL);
    [attributeString addAttribute: (NSString*)(kCTFontAttributeName) value:(id)font_world2 range:NSMakeRange(self.baText.iTitleLength,[self.baText.text length]-self.baText.iTitleLength)];
    CFRelease(font_world2);
}

-(void)needPages{
    [self initAttributeString];
    NSInteger iTotalLength = [self getContentLengthInPage];
    if (iTotalLength < attributeString.length) {
        self.arrViewsAttributeString = [[NSMutableArray alloc] init];
        //删除掉本页显示的文字
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
        [attriStr replaceCharactersInRange:NSMakeRange(0, iTotalLength) withString:@""];
        
        [self initTotalLength:attriStr];
        [self createPagesDataSource:attriStr];
        for (int i=0; i<self.arrViewsAttributeString.count; i++) {
            TextPage *page = [[TextPage alloc] init];
            NSAttributedString *attriStr = [self.arrViewsAttributeString objectAtIndex:i];
            page.attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attriStr];
            page.attributeStringOriginal = [[NSMutableAttributedString alloc] initWithAttributedString:attriStr];
            [arrViews addObject:page];
            [page release];
        }
        [attriStr release];
    }
}

//获取本页显示的文字长度
-(NSInteger)getContentLengthInPage{
    NSInteger iToalLength = 0;
    NSMutableAttributedString *tempString =  [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<self.baText.arrRectsPor.count; i++) {
            CGRect rect = CGRectFromString([self.baText.arrRectsPor objectAtIndex:i]);
            int length = [self getLengthInRect:tempString rect:rect];
            NSRange rang = NSMakeRange(0, length);
            [tempString replaceCharactersInRange:rang withString:@""];
            iToalLength = iToalLength + length;
        }
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        for (int i=0; i<self.baText.arrRects.count; i++) {
            CGRect rect = CGRectFromString([self.baText.arrRects objectAtIndex:i]);
            int length = [self getLengthInRect:tempString rect:rect];
            NSRange rang = NSMakeRange(0, length);
            [tempString replaceCharactersInRange:rang withString:@""];
            iToalLength = iToalLength + length;
        }
    }
    [tempString release];
    return iToalLength;
}

//当文字超出本页时，创建额外的页面数据源
-(void)createPagesDataSource:(NSMutableAttributedString *)strAttributeContent{
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithAttributedString:strAttributeContent];
    
    int length = 0;
    NSAttributedString *attStrLeft = attStr;
    while (length < attStr.length) {
        [self initTotalLength:attStrLeft];
        int totalLength = 0;
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
            totalLength = self.totalLengthInContentPagePor;
        }
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            totalLength = self.totalLengthInContentPage;
        }
        
        NSAttributedString *attStrTemp;
        attStrTemp = [attStr attributedSubstringFromRange:NSMakeRange(length, totalLength)];
        attStrLeft = [attStr attributedSubstringFromRange:NSMakeRange(length+totalLength, attStr.length-(length+totalLength))];
        length += totalLength;
        
        [arrViewsAttributeString addObject:attStrTemp];
    }
    [attStr release];
}

-(void)setText{
    if (self.baText != nil) {
        self.strSearchWord = @"";
        if (self.keyWordsDic.count > 0) {
            self.keyWordsDic = nil;
        }
        tmptext = self.baText.text;
        Label1.text = tmptext;
        
        self.attributeString = nil;
        [self initAttributeString];
        
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
        
        for (int i=0; i<arrViews.count; i++) {
            TextPage *page = (TextPage *)[arrViews objectAtIndex:i];
            [page setText];
        }
        [Label1 setNeedsDisplay];
    }
}

-(void)setText:(NSString *)strSearchWordPara{
    [self initAttributeString];
    self.keyWordsDic = nil;
    self.strSearchWord = strSearchWordPara;
    self.keyWordsDic = [self searchWordInPage:strSearchWord searchContent:self.attributeString.string];
    [self setKeyWordFontWithData:self.keyWordsDic];
    for (int i=0; i<arrViews.count; i++) {
        TextPage *page = (TextPage *)[arrViews objectAtIndex:i];
        [page setText:strSearchWordPara];
    }
}

//刷新各个views的数据源
-(void)refreshViewsDataSource{
    NSInteger iTotalLength = [self getContentLengthInPage];
    if (iTotalLength < attributeString.length) {
        self.arrViewsAttributeString = [[NSMutableArray alloc] init];
        //删除掉本页显示的文字
        
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
        [attriStr replaceCharactersInRange:NSMakeRange(0, iTotalLength) withString:@""];
        
        [self createPagesDataSource:attriStr];
        [attriStr release];
    }
    for (int i=0; i<self.arrViewsAttributeString.count; i++) {
        TextPage *page = (TextPage *)[arrViews objectAtIndex:i];
        NSAttributedString *attriStr = [self.arrViewsAttributeString objectAtIndex:i];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithAttributedString:attriStr];
        page.attributeString = attribute;
        [attribute release];
    }
}

-(void)setKeyWordFontWithData:(NSDictionary *)dataDic{
    if (self.baText != nil) {
        self.keyWordsDic = nil;
        keyWordsDic = dataDic;
        tmptext = self.baText.text;
        Label1.text = tmptext;
        
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

#pragma mark - BFSearchWordDelegate

- (void)needRedraw:(NSDictionary *)dic{
    [self setKeyWordFontWithData:dic];
}

#pragma mark - 视频播放
-(void)playmovie{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    UIButton *btn = (UIButton *)[allPics objectAtIndex:0];
    [movie.view setFrame:btn.frame];
    movie.initialPlaybackTime = -1;
    [self addSubview:movie.view];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:movie];
    [movie play];
}
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:movie];
    [movie.view removeFromSuperview];
    [movie stop];
    movie=nil;
}
-(void)stopMovie{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:movie];
    [movie.view removeFromSuperview];
    [movie stop];
    movie=nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [wgt release];
    [BGPics release];
    [allPics release];
    self.pieMini = nil;
    self.keyWordsDic = nil;
    self.arrViews = nil;
    self.arrViewsAttributeString = nil;
    self.attributeString = nil;
    self.Label1 = nil;
    self.movie = nil;
    [super dealloc];
}

@end

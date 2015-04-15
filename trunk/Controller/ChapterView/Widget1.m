//
//  Widget1.m
//  Test
//
//  Created by mac  on 13-1-30.
//  Copyright (c) 2013年 mac . All rights reserved.
//
#define SECNUM 7

#import "Widget1.h"
#import "CoreText/CoreText.h"

@implementation Widget1
{
    UIButton *lastBt;
    UIImageView *bg;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        [bg setImage:[UIImage imageNamed:@"widget1_bgPor.png"]];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        [bg setImage:[UIImage imageNamed:@"widget1_bg.png"]];
    }
    
    [self addSubview:bg];
    
    buttons=[[NSMutableArray alloc]init];
    images=[[NSMutableArray alloc]init];
    
    for(int i=0;i<SECNUM;i++){
        UIButton *uiButton=[[UIButton alloc]init];
        [uiButton addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
        [uiButton setTag:i];
        [buttons addObject:uiButton];
        [self addSubview:uiButton];
        
        UIImageView *uiImageView=[[UIImageView alloc]init];
        [images addObject:uiImageView];
        [self addSubview:uiImageView];
    }
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        descLabel=[[CustomUILabel alloc]initWithFrame:CGRectMake(14, 402, 195,167)];
        [descLabel addRect:CGRectMake(0, 0, 195,167)];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        descLabel=[[CustomUILabel alloc]initWithFrame:CGRectMake(30, 420, 240,200)];
        [descLabel addRect:CGRectMake(0, 0, 240,200)];
    }
    
    descLabel.backgroundColor=[UIColor clearColor];
    lastBt=[buttons objectAtIndex:0];
    [lastBt setSelected:YES];
    [self addSubview:descLabel];
    
    [self setInfo:0];
    [self adjust];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeFrames:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}
-(void)changeFrames:(NSNotification *)notification {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.frame = CGRectMake(512, 92 , 222, 645);
        bg.frame = CGRectMake(0, 0 , 222, 645);
        [bg setImage:[UIImage imageNamed:@"widget1_bgPor.png"]];
        descLabel.frame =  CGRectMake(14, 402, 195,167);
        [descLabel addRect:CGRectMake(0, 0, 195,167)];
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        self.frame = CGRectMake(654, 64 , 303, 645);
        bg.frame = CGRectMake(0, 0 , 303, 645);
        [bg setImage:[UIImage imageNamed:@"widget1_bg.png"]];
        descLabel.frame =  CGRectMake(30, 420, 240,200);
        [descLabel addRect:CGRectMake(0, 0, 240,200)];
    }
}

-(void)didSelect:(UIButton *)sender{
    [self setInfo:sender.tag];
    [sender setSelected:YES];
    [lastBt setSelected:NO];
    lastBt=sender;
    
}
-(void)setInfo:(int)Index{
    NSMutableArray *Desc=[[NSMutableArray alloc]initWithObjects:@"公司名称：宝钢集团有限公司\n宝钢集团有限公司简称宝钢（Baosteel），是中国最大的钢铁公司，也是国有企业，它的总部位于上海。子公司宝山钢铁股份有限公司(上交所：600019)，简称宝钢股份，是宝钢集团在上海证券交易所的上市公司。",@"公司名称：华为技术有限公司\n为技术有限公司是一家总部位于中国广东省深圳市的生产销售电信设备的员工持股的民营科技公司，于1987年由任正非创建于中国深圳，是全球最大的电信网络解决方案提供商，全球第二大电信基站设备供应商。华为的主要营业范围是交换，传输，无线，数据通信类电信产品，在电信领域为世界各地的客户提供网络设备、服务、解决方案。在2011年11月8日公布的2011年中国民营500强企业榜单中，华为技术有限公司名列第一。",@"公司名称：华能国际电力股份有限公司\n华能国际电力股份有限公司（ “本公司”或“公司” ）及其附属公司在中国全国范围内开发、建设和经营管理大型发电厂，截至2007年6月30日拥有权益发电装机容量31747兆瓦，可控装机容量为36024兆瓦，是中国最大的上市发电公司之一。",@"公司名称：中粮集团有限公司\n中粮集团有限公司（COFCO）是世界500强企业，是中国领先的农产品、食品领域多元化产品和服务供应商，致力于打造从田间到餐桌的全产业链粮油食品企业，建设全服务链的城市综合体。利用不断再生的自然资源为人类提供营养健康的食品、高品质的生活空间及生活服务，贡献于民众生活的富足和社会的繁荣稳定。",@"公司名称：万科\n万科企业股份有限公司，简称万科或万科集团，证券简称：万科A、证券代码：000002，证券曾用简称：深万科A、G万科A。公司总股本1099521.02万股（2008年2季度），总部位于中国深圳市福田区梅林路63号万科建筑研究中心，现任董事长为王石，总经理为郁亮。2012年01月17日，已加入万科十年的重庆公司总经理邢鹏正式离职，成为继徐洪舸、肖楠、刘爱明、袁伯银之后又一位出走的“老将”。",@"公司名称：联想\n联想控股有限公司（Legend Holdings Ltd.，简称“联想控股”）成立于1984年，由中国的中科院计算所投资20万元人民币，柳传志等11名科研人员创立。联想控股的投资业务包括为核心运营资产投资、资产管理、孵化器投资三大板块，未来将通过“购建”核心运营资产板块中所涉及的领先企业以实现跨越式成长。2012年10月11日，全球市场调研公司Gartner称，2012年联想的PC超出惠普0.2个百分点，成为了行业第一.",@"公司名称：华润（集团）有限公司\n华润（集团）有限公司总部位于中国香港湾仔港湾道26号华润大厦49楼，是一家在香港注册和运营的多元化控股企业集团，从事的行业都与大众生活息息相关，主营业务包括日用消费品制造与分销、地产及相关行业、基础设施及公用事业三块领域，旗下共有20家一级利润中心，在香港拥有5家上市公司：华润创业（HK291）、华润电力（HK836）、华润置地（HK1109）、华润微电子（HK597）和华润燃气（HK1193）.", nil];
    [descLabel setText:[Desc objectAtIndex:Index]];
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc]initWithString:[Desc objectAtIndex:Index]];
    int lens[]={8,8,12,8,2,2,10};
    
    
    [attributedString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor blackColor]CGColor] range:NSMakeRange(0,5)];
    [attributedString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor colorWithRed:0.388 green:0.212 blue:0.13 alpha:1]
                                                                                           CGColor] range:NSMakeRange(5,lens[Index])];
    [attributedString addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1]CGColor] range:NSMakeRange(5+lens[Index],[attributedString length]-5-lens[Index])];
    
    CTFontRef  font_world = CTFontCreateWithName((CFStringRef)@"Helvetica",13,NULL);
    [attributedString addAttribute: (NSString*)(kCTFontAttributeName) value:(__bridge id)font_world range:NSMakeRange(5,lens[Index])];
    CFRelease(font_world);
    
    
    CTFontRef  font_world2 = CTFontCreateWithName((CFStringRef)@"HelveticaNeue-Bold",15,NULL);
    [attributedString addAttribute: (NSString*)(kCTFontAttributeName) value:(__bridge id)font_world2 range:NSMakeRange(0,5)];
    CFRelease(font_world2);
    
    descLabel.attributedText = attributedString;
    
    descLabel.linespec=18;//行间距
}

-(void)adjust{
    
    NSMutableArray *imageName=[[NSMutableArray alloc]initWithObjects:@"logo-01.png",@"logo-02.png",@"logo-03.png",@"logo-04.png",@"logo-05.png",@"logo-06.png",@"logo-07.png", nil];
    
    for(int i=0;i<SECNUM;i++){
        UIButton *uiButton=[buttons objectAtIndex:i];
        [uiButton setFrame:CGRectMake(30, 35+i*45, 27,26)];
        [uiButton setImage:[UIImage imageNamed:@"widget1_unclicked.png"] forState:UIControlStateNormal];
        [uiButton setImage:[UIImage imageNamed:@"widget1_clicked.png"] forState:UIControlStateSelected];
        
        UIImageView *uiImageView=[images objectAtIndex:i];
        [uiImageView setFrame:CGRectMake(70,30+i*45,86,30)];
        [uiImageView setImage:[UIImage imageNamed:[imageName objectAtIndex:i]]];
        
        UIButton *BGButton=[[UIButton alloc]init];
        [BGButton addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
        [BGButton setTag:i];
        [BGButton setFrame:CGRectMake(30, 35+i*45, 126,30)];
        BGButton.backgroundColor = [UIColor clearColor];
        [self addSubview:BGButton];
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [super dealloc];
}

@end

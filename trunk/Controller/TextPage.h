//
//  TextPage.h
//  E-magazine
//
//  Created by summer.zhu on 5/2/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "Page.h"
#import "CustomUILabel.h"

@interface TextPage : Page{
    
}
@property (nonatomic,strong) CustomUILabel *Label1;
@property (nonatomic,strong) NSMutableAttributedString *attributeString;
@property (nonatomic,strong) NSMutableAttributedString *attributeStringOriginal;
@property (nonatomic,strong) NSString *strSearchWord;
@property (nonatomic,strong) NSDictionary *keyWordsDic;

//设置数据源NSAttributedString
-(void)setText;
//设置数据源NSAttributedString根据searchword
-(void)setText:(NSString *)strSearchWordPara;
-(void)setKeyWordFontWithData:(NSDictionary *)dataDic;
-(void)initAttributeString;
-(NSDictionary*)searchWordInPage:(NSString *) keyword searchContent:(NSString *)searchContent;

@end

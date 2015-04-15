//
//  DataFactory.m
//  E-magazine
//
//  Created by summer.zhu on 4/13/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "DataFactory.h"
#import "KeyWord.h"
#import "BAData.h"
#import "ViewControllerAndPage.h"
#import "MoreTextNoAbstract.h"
#import "LessTextNoAbstract.h"
#import "LeastTextNoAbstract.h"
#import "MoreTextWithAbstract.h"
#import "BannerText.h"
#import "LessTextNoAbstractPor.h"
#import "MoreTextNoAbstractPor.h"
#import "BannerTextPor.h"
#import "MoreTextWithAbstractPor.h"
#import "LeastTextNoAbstractPor.h"

@implementation DataFactory
static DataFactory *dataFactory = nil;

+ (id)shareInstance{
    @synchronized(self){
        if (dataFactory == nil) {
            dataFactory = [[self alloc] init];
        }
    }
    return dataFactory;
}

+ (BABookData *)createBookData:(int)bookIndex{
    BABookData *bookData = [[BABookData alloc] init];
    bookData.bookContent = [DataFactory createDataSource:bookIndex];
    bookData.dicSearchData = [DataFactory searchDataSource:bookIndex];
    bookData.arrSearchKey = [DataFactory searchKey:bookIndex];
    NSString *strBookMark;
    NSString *strMsgKey;
    NSMutableArray *arrVCType;
    NSMutableArray *arrVCIndex;
    NSMutableArray *arrTitles;
    
    switch (bookIndex) {
        case 0:
        {
            strBookMark = @"booksMarks0";
            strMsgKey = @"msgKey0";
            arrVCType = [[NSMutableArray alloc] initWithObjects:@"0", @"2", @"4", @"4", @"4", @"3", @"3", @"3", @"6", @"7", nil];
            arrVCIndex = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"5", @"8", @"11", @"13", @"16", @"19", @"20", nil];
            arrTitles = [[NSMutableArray alloc] initWithObjects:@"2012年年度报告",@"2012年年度报告目录",@"年度要点", @"分析报告", @"经营风险分析", @"环境与展望", @"业务前景", @"三年规划", @"图表索引",@"结论索引", nil];
        }
            break;
        case 1:
        {
            strBookMark = @"booksMarks1";
            strMsgKey = @"msgKey1";
            arrVCType = [[NSMutableArray alloc] initWithObjects:@"0", @"2", @"4", @"3", @"4", @"3", @"3", @"6", @"7", nil];
            arrVCIndex = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"6", @"8", @"12", @"14", @"16", @"17", nil];
            arrTitles = [[NSMutableArray alloc] initWithObjects:@"中国消费信贷市场解析",@"中国消费信贷市场解析目录", @"我行个人信贷业务要点", @"要点分析",@"新生市场:即将迎来爆炸式增长",@"信贷方的下一步行动", @"业务规划", @"图表索引",@"结论索引", nil];
        }
            break;
        case 2:
        {
            strBookMark = @"booksMarks2";
            strMsgKey = @"msgKey2";
            arrVCType = [[NSMutableArray alloc] initWithObjects:@"0", @"2", @"3", @"8", @"3", @"3", @"6", @"7", nil];
            arrVCIndex = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"5", @"10", @"12", @"15", @"16", nil];
            arrTitles = [[NSMutableArray alloc] initWithObjects:@"银行业投资分析周报", @"投资分析周报目录", @"市场表现", @"行业动态", @"公司追踪", @"本期个股推荐", @"图表索引", @"结论索引", nil];
        }
            break;
        case 3:
        {
            strBookMark = @"booksMarks3";
            strMsgKey = @"msgKey3";
            arrVCType = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"8", @"5", @"6", @"7", nil];
            arrVCIndex = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"5", @"9", @"12", @"13", nil];
            arrTitles = [[NSMutableArray alloc] initWithObjects:@"能化周刊",@"触控说明",@"能化周刊目录",@"本周行情综述",@"基本面分析",@"后市展望",@"图表索引",@"结论索引", nil];
        }
            break;
            
        default:
            break;
    }
    bookData.strBookMarks = strBookMark;
    bookData.strMsgkey = strMsgKey;
    bookData.arrViewControllersType = arrVCType;
    bookData.arrViewControllersAtIndex = arrVCIndex;
    bookData.arrTitle = arrTitles;
    
    //    NSDictionary *dataDic = [[NSDictionary alloc] init];
    //
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DataTest.plist"];
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    //    {
    //        //此处可以自己写显示plist文件内容
    //        NSLog(@"文件已存在");
    //    }
    //    else
    //    {
    //        //如果没有plist文件就自动创建
    //        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    //    }
    //    dataDic = [OCReflection getDictionaryFromClass2:bookData];
    //    [dataDic writeToFile:path atomically:YES];
    return bookData;
}

+ (BADataSource *)createDataSource:(int) bookIndex{
    BADataSource *baDataSource = [[BADataSource alloc] init];
    if (bookIndex == 0) {
        BAImagaNameData *data1_1 = [DataFactory create1_1Data];
        baDataSource.data1 = data1_1;
        BAThreeData *data2_1 = [DataFactory create2_1Data];
        baDataSource.data2 = data2_1;
        BAFiveData *data3_1 = [DataFactory create3_1Data];
        baDataSource.data3 = data3_1;
        BAFiveData *data4_1 = [DataFactory create4_1Data];
        baDataSource.data4 = data4_1;
        BAFiveData *data5_1 = [DataFactory create5_1Data];
        baDataSource.data5 = data5_1;
        BAFourData *data6_1 = [DataFactory create6_1Data];
        baDataSource.data6 = data6_1;
        BAFourData *data7_1 = [DataFactory create7_1Data];
        baDataSource.data7 = data7_1;
        BAFourData *data8_1 = [DataFactory create8_1Data];
        baDataSource.data8 = data8_1;
        BAImagaNameData *data9_1 = [DataFactory create9_1Data];
        baDataSource.data9 = data9_1;
        BAImagaNameData *data10_1 = [DataFactory create10_1Data];
        baDataSource.data10 = data10_1;
        
    }
    else if(bookIndex == 1){
        BAImagaNameData *data1_2 = [DataFactory create1_2Data];
        baDataSource.data1 = data1_2;
        BAThreeData *data3_2 = [DataFactory create3_2Data];
        baDataSource.data2 = data3_2;
        BAFiveData *data4_2 = [DataFactory create4_2Data];
        baDataSource.data3 = data4_2;
        BAFourData *data5_2 = [DataFactory create5_2Data];
        baDataSource.data4 = data5_2;
        BAFiveData *data6_2 = [DataFactory create6_2Data];
        baDataSource.data5 = data6_2;
        BAFourData *data7_2 = [DataFactory create7_2Data];
        baDataSource.data6 = data7_2;
        BAFourData *data8_2 = [DataFactory create8_2Data];
        baDataSource.data7 = data8_2;
        BAImagaNameData *data9_2 = [DataFactory create9_2Data];
        baDataSource.data8 = data9_2;
        BAThreeData *data10_2 = [DataFactory create10_2Data];
        baDataSource.data9 = data10_2;
    }
    else if(bookIndex == 2){
        BAImagaNameData *data1_3 = [DataFactory create1_3Data];
        baDataSource.data1 = data1_3;
        BAThreeData *data2_3 = [DataFactory create2_3Data];
        baDataSource.data2 = data2_3;
        BAFourData *data3_3 = [DataFactory create3_3Data];
        baDataSource.data3 = data3_3;
        BAFiveDataExtend *data4_3  = [DataFactory create4_3Data];
        baDataSource.data4 = data4_3;
        BAFourData *data5_3 = [DataFactory create5_3Data];
        baDataSource.data5 = data5_3;
        BAFourData *data6_3 = [DataFactory create6_3Data];
        baDataSource.data6 = data6_3;
        BAImagaNameData *data7_2 = [DataFactory create8_3Data];
        baDataSource.data7 = data7_2;
        BAThreeData *data8_2 = [DataFactory create9_3Data];
        baDataSource.data8 = data8_2;
    }
    else{
        BAImagaNameData *data1 = [DataFactory create1Data];
        baDataSource.data1 = data1;
        BAImagaNameData *data2 = [DataFactory create2Data];
        baDataSource.data2 = data2;
        BAThreeData *data3 = [DataFactory create3Data];
        baDataSource.data3 = data3;
        BAFourData *data4 = [DataFactory create4Data];
        baDataSource.data4 = data4;
        
        BAFiveDataExtend *data5 = [DataFactory create5Data];
        baDataSource.data5 = data5;
        
        BAFourData *data6 = [DataFactory create6Data];
        baDataSource.data6 = data6;
        BAImagaNameData *data7 = [DataFactory create7Data];
        baDataSource.data7 = data7;
        BAImagaNameData *data8 = [DataFactory create8Data];
        baDataSource.data8 = data8;
    }
    return baDataSource;
}

+ (NSMutableDictionary *)searchDataSource:(NSInteger)bookIndex{
    NSMutableDictionary *dicDataSource = [[NSMutableDictionary alloc] init];
    if (bookIndex ==0) {
        //第一章 搜索内容
        BAFiveData *data3 = [DataFactory create3_1Data];
        NSString *strSearchContent = data3.baText.text;
        ViewControllerAndPage *vcPage1 = [[ViewControllerAndPage alloc] init];
        vcPage1.pageIndex = @"1";
        vcPage1.contentIndex = @"1";
        vcPage1.viewControllerIndex = @"2";
        [dicDataSource setObject:vcPage1 forKey:strSearchContent];
        
        NSString *strSearchContent1 = data3.baText1.text;
        ViewControllerAndPage *vcPage2 = [[ViewControllerAndPage alloc] init];
        vcPage2.pageIndex = @"2";
        //        vcPage2.contentIndex = @"2";
        vcPage2.viewControllerIndex = @"2";
        [dicDataSource setObject:vcPage2 forKey:strSearchContent1];
        
        //第二章 搜索内容
        BAFiveData *data4 = [DataFactory create4_1Data];
        NSString *strSearchContent2 = data4.baText.text;
        ViewControllerAndPage *vcPage3 = [[ViewControllerAndPage alloc] init];
        vcPage3.pageIndex = @"1";
        //        vcPage3.contentIndex = @"1";
        vcPage3.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage3 forKey:strSearchContent2];
        
        NSString *strSearchContent3 = data4.baText1.text;
        ViewControllerAndPage *vcPage4 = [[ViewControllerAndPage alloc] init];
        vcPage4.pageIndex = @"2";
        //        vcPage4.contentIndex = @"2";
        vcPage4.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage4 forKey:strSearchContent3];
        
        //第三章 搜索内容
        BAFiveData *data5 = [DataFactory create5_1Data];
        NSString *strSearchContent4 = data5.baText.text;
        ViewControllerAndPage *vcPage5 = [[ViewControllerAndPage alloc] init];
        vcPage5.pageIndex = @"1";
        //        vcPage5.contentIndex = @"1";
        vcPage5.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage5 forKey:strSearchContent4];
        
        NSString *strSearchContent5 = data5.baText1.text;
        ViewControllerAndPage *vcPage6 = [[ViewControllerAndPage alloc] init];
        vcPage6.pageIndex = @"2";
        //        vcPage5.contentIndex = @"1";
        vcPage6.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage6 forKey:strSearchContent5];
        
        //第4章 搜索内容
        BAFourData *data6 = [DataFactory create6_1Data];
        NSString *strSearchContent6 = data6.baText.text;
        ViewControllerAndPage *vcPage7 = [[ViewControllerAndPage alloc] init];
        vcPage7.pageIndex = @"1";
        //        vcPage5.contentIndex = @"1";
        vcPage7.viewControllerIndex = @"5";
        [dicDataSource setObject:vcPage7 forKey:strSearchContent6];
        
        //第5章 搜索内容
        BAFourData *data7 = [DataFactory create7_1Data];
        NSString *strSearchContent7 = data7.baText.text;
        ViewControllerAndPage *vcPage8 = [[ViewControllerAndPage alloc] init];
        vcPage8.pageIndex = @"1";
        //        vcPage5.contentIndex = @"1";
        vcPage8.viewControllerIndex = @"6";
        [dicDataSource setObject:vcPage8 forKey:strSearchContent7];
        
        //第6章 搜索内容
        BAFourData *data8 = [DataFactory create8_1Data];
        NSString *strSearchContent8 = data8.baText.text;
        ViewControllerAndPage *vcPage9 = [[ViewControllerAndPage alloc] init];
        vcPage9.pageIndex = @"1";
        //        vcPage5.contentIndex = @"1";
        vcPage9.viewControllerIndex = @"7";
        [dicDataSource setObject:vcPage9 forKey:strSearchContent8];
        
        
    }
    else if(bookIndex == 1){
        //第1章 搜索内容
        BAFiveData *data1 = [DataFactory create4_2Data];
        NSString *strSearchContent0 = data1.baText.text;
        ViewControllerAndPage *vcPage0 = [[ViewControllerAndPage alloc] init];
        vcPage0.pageIndex = @"1";
        vcPage0.viewControllerIndex = @"2";
        [dicDataSource setObject:vcPage0 forKey:strSearchContent0];
        
        NSString *strSearchContent0_1 = data1.baText1.text;
        ViewControllerAndPage *vcPage0_1 = [[ViewControllerAndPage alloc] init];
        vcPage0_1.pageIndex = @"3";
        vcPage0_1.viewControllerIndex = @"2";
        [dicDataSource setObject:vcPage0_1 forKey:strSearchContent0_1];
        
        //第2章 搜索内容
        BAFourData *data2 = [DataFactory create5_2Data];
        NSString *strSearchContent = data2.baText.text;
        ViewControllerAndPage *vcPage1 = [[ViewControllerAndPage alloc] init];
        vcPage1.pageIndex = @"1";
        //        vcPage1.contentIndex = @"1";
        vcPage1.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage1 forKey:strSearchContent];
        
        //第3章 搜索内容
        BAFiveData *data3 = [DataFactory create6_2Data];
        NSString *strSearchContent1 = data3.baText.text;
        ViewControllerAndPage *vcPage2 = [[ViewControllerAndPage alloc] init];
        vcPage2.pageIndex = @"1";
        //        vcPage2.contentIndex = @"1";
        vcPage2.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage2 forKey:strSearchContent1];
        
        NSString *strSearchContent2 = data3.baText1.text;
        ViewControllerAndPage *vcPage3 = [[ViewControllerAndPage alloc] init];
        vcPage3.pageIndex = @"3";
        //        vcPage3.contentIndex = @"2";
        vcPage3.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage3 forKey:strSearchContent2];
        
        //第4章 搜索内容
        BAFourData *data4 = [DataFactory create7_2Data];
        NSString *strSearchContent3 = data4.baText.text;
        ViewControllerAndPage *vcPage4 = [[ViewControllerAndPage alloc] init];
        vcPage4.pageIndex = @"1";
        //        vcPage4.contentIndex = @"1";
        vcPage4.viewControllerIndex = @"5";
        [dicDataSource setObject:vcPage4 forKey:strSearchContent3];
        
        //第5章 搜索内容
        BAFourData *data5 = [DataFactory create8_2Data];
        NSString *strSearchContent4 = data5.baText.text;
        ViewControllerAndPage *vcPage5 = [[ViewControllerAndPage alloc] init];
        vcPage5.pageIndex = @"1";
        //        vcPage4.contentIndex = @"1";
        vcPage5.viewControllerIndex = @"6";
        [dicDataSource setObject:vcPage5 forKey:strSearchContent4];
    }
    else if(bookIndex == 2){
        //第1章 搜索内容
        BAFourData *data1 = [DataFactory create3_3Data];
        NSString *strSearchContent0 = data1.baText.text;
        ViewControllerAndPage *vcPage0 = [[ViewControllerAndPage alloc] init];
        vcPage0.pageIndex = @"1";
        vcPage0.viewControllerIndex = @"2";
        [dicDataSource setObject:vcPage0 forKey:strSearchContent0];
        
        //第2章 搜索内容
        BAFiveDataExtend *data2 = [DataFactory create4_3Data];
        NSString *strSearchConten1 = data2.baText.text;
        ViewControllerAndPage *vcPage1 = [[ViewControllerAndPage alloc] init];
        vcPage1.pageIndex = @"1";
        vcPage1.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage1 forKey:strSearchConten1];
        
        NSString *strSearchContent2 = data2.baText1.text;
        ViewControllerAndPage *vcPage2 = [[ViewControllerAndPage alloc] init];
        vcPage2.pageIndex = @"3";
        vcPage2.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage2 forKey:strSearchContent2];
        
        NSString *strSearchContent3 = data2.baText2.text;
        ViewControllerAndPage *vcPage3 = [[ViewControllerAndPage alloc] init];
        vcPage3.pageIndex = @"4";
        vcPage3.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage3 forKey:strSearchContent3];
        
        //第4章 搜索内容
        BAFourData *data3 = [DataFactory create5_3Data];
        NSString *strSearchContent4 = data3.baText.text;
        ViewControllerAndPage *vcPage4 = [[ViewControllerAndPage alloc] init];
        vcPage4.pageIndex = @"1";
        vcPage4.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage4 forKey:strSearchContent4];
        
        //第5章 搜索内容
        BAFourData *data4 = [DataFactory create6_3Data];
        NSString *strSearchContent5 = data4.baText.text;
        ViewControllerAndPage *vcPage5 = [[ViewControllerAndPage alloc] init];
        vcPage5.pageIndex = @"1";
        vcPage5.viewControllerIndex = @"5";
        [dicDataSource setObject:vcPage5 forKey:strSearchContent5];
    }
    else{
        //@"0", @"1", @"2", @"3", @"5", @"8", @"10", @"11", nil
        //第一章 搜索内容
        BAFourData *data4 = [DataFactory create4Data];
        NSString *strSearchContent = data4.baText.text;
        ViewControllerAndPage *vcPage1 = [[ViewControllerAndPage alloc] init];
        vcPage1.pageIndex = @"1";
        //        vcPage1.contentIndex = @"1";
        vcPage1.viewControllerIndex = @"3";
        [dicDataSource setObject:vcPage1 forKey:strSearchContent];
        
        //第二章 搜索内容
        BAFiveDataExtend *data5 = [DataFactory create5Data];
        NSString *strSearchContent1 = data5.baText.text;
        ViewControllerAndPage *vcPage2 = [[ViewControllerAndPage alloc] init];
        vcPage2.pageIndex = @"1";
        //        vcPage2.contentIndex = @"1";
        vcPage2.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage2 forKey:strSearchContent1];
        
        NSString *strSearchContent2 = data5.baText1.text;
        ViewControllerAndPage *vcPage3 = [[ViewControllerAndPage alloc] init];
        vcPage3.pageIndex = @"2";
        //        vcPage3.contentIndex = @"2";
        vcPage3.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage3 forKey:strSearchContent2];
        
        NSString *strSearchContent3 = data5.baText2.text;
        ViewControllerAndPage *vcPage4 = [[ViewControllerAndPage alloc] init];
        vcPage4.pageIndex = @"3";
        //        vcPage4.contentIndex = @"2";
        vcPage4.viewControllerIndex = @"4";
        [dicDataSource setObject:vcPage4 forKey:strSearchContent3];
        
        //第三章 搜索内容
        BAFourData *data6 = [DataFactory create6Data];
        NSString *strSearchContent4 = data6.baText.text;
        ViewControllerAndPage *vcPage5 = [[ViewControllerAndPage alloc] init];
        vcPage5.pageIndex = @"1";
        //        vcPage5.contentIndex = @"1";
        vcPage5.viewControllerIndex = @"5";
        [dicDataSource setObject:vcPage5 forKey:strSearchContent4];
    }
    return dicDataSource;
}

//解决allkey无序问题
+ (NSMutableArray *)searchKey:(NSInteger)bookIndex{
    NSMutableArray *arrSearchKey = [[NSMutableArray alloc] init];
    if (bookIndex ==0) {
        //page0 搜索内容
        BAFiveData *data3 = [DataFactory create3_1Data];
        NSString *strSearchContent = data3.baText.text;
        [arrSearchKey addObject:strSearchContent];
        
        NSString *strSearchContent1 = data3.baText1.text;
        [arrSearchKey addObject:strSearchContent1];
        
        //page1 搜索内容
        BAFiveData *data4 = [DataFactory create4_1Data];
        NSString *strSearchContent2 = data4.baText.text;
        [arrSearchKey addObject:strSearchContent2];
        
        NSString *strSearchContent3 = data4.baText1.text;
        [arrSearchKey addObject:strSearchContent3];
        
        //page2 搜索内容
        BAFiveData *data5 = [DataFactory create5_1Data];
        NSString *strSearchContent4= data5.baText.text;
        [arrSearchKey addObject:strSearchContent4];
        
        NSString *strSearchContent5 = data5.baText1.text;
        [arrSearchKey addObject:strSearchContent5];
        
        //page3 搜索内容
        BAFourData *data6 = [DataFactory create6_1Data];
        NSString *strSearchContent6 = data6.baText.text;
        [arrSearchKey addObject:strSearchContent6];
        
        //page4 搜索内容
        BAFourData *data7 = [DataFactory create7_1Data];
        NSString *strSearchContent7 = data7.baText.text;
        [arrSearchKey addObject:strSearchContent7];
        
        //page5 搜索内容
        BAFourData *data8 = [DataFactory create8_1Data];
        NSString *strSearchContent8 = data8.baText.text;
        [arrSearchKey addObject:strSearchContent8];
    }
    else if(bookIndex == 1){
        //page1 搜索内容
        BAFiveData *data2 = [DataFactory create4_2Data];
        NSString *strSearchContent0 = data2.baText.text;
        [arrSearchKey addObject:strSearchContent0];
        
        NSString *strSearchContent0_1 = data2.baText1.text;
        [arrSearchKey addObject:strSearchContent0_1];
        
        //page2 搜索内容
        BAFourData *data3 = [DataFactory create5_2Data];
        NSString *strSearchContent = data3.baText.text;
        [arrSearchKey addObject:strSearchContent];
        
        //page3 搜索内容
        BAFiveData *data4 = [DataFactory create6_2Data];
        NSString *strSearchContent1 = data4.baText.text;
        [arrSearchKey addObject:strSearchContent1];
        
        NSString *strSearchContent2 = data4.baText1.text;
        [arrSearchKey addObject:strSearchContent2];
        
        //page4 搜索内容
        BAFourData *data5 = [DataFactory create7_2Data];
        NSString *strSearchContent3 = data5.baText.text;
        [arrSearchKey addObject:strSearchContent3];
        
        //page5 搜索内容
        BAFourData *data6 = [DataFactory create8_2Data];
        NSString *strSearchContent4 = data6.baText.text;
        [arrSearchKey addObject:strSearchContent4];
    }
    else if(bookIndex == 2){
        //第1章 搜索内容
        BAFourData *data1 = [DataFactory create3_3Data];
        NSString *strSearchContent0 = data1.baText.text;
        [arrSearchKey addObject:strSearchContent0];
        
        //第2章 搜索内容
        BAFiveDataExtend *data2 = [DataFactory create4_3Data];
        NSString *strSearchConten1 = data2.baText.text;
        [arrSearchKey addObject:strSearchConten1];
        
        NSString *strSearchContent2 = data2.baText1.text;
        [arrSearchKey addObject:strSearchContent2];
        
        NSString *strSearchContent3 = data2.baText2.text;
        [arrSearchKey addObject:strSearchContent3];
        
        //第4章 搜索内容
        BAFourData *data3 = [DataFactory create5_3Data];
        NSString *strSearchContent4 = data3.baText.text;
        [arrSearchKey addObject:strSearchContent4];
        
        //第5章 搜索内容
        BAFourData *data4 = [DataFactory create6_3Data];
        NSString *strSearchContent5 = data4.baText.text;
        [arrSearchKey addObject:strSearchContent5];
    }
    else{
        //page0 搜索内容
        BAFourData *data4 = [DataFactory create4Data];
        NSString *strSearchContent = data4.baText.text;
        
        [arrSearchKey addObject:strSearchContent];
        
        //page1 搜索内容
        BAFiveDataExtend *data5 = [DataFactory create5Data];
        NSString *strSearchContent1 = data5.baText.text;
        [arrSearchKey addObject:strSearchContent1];
        
        NSString *strSearchContent2 = data5.baText1.text;
        [arrSearchKey addObject:strSearchContent2];
        
        NSString *strSearchContent3 = data5.baText2.text;
        [arrSearchKey addObject:strSearchContent3];
        
        //page2 搜索内容
        BAFourData *data6 = [DataFactory create6Data];
        NSString *strSearchContent4 = data6.baText.text;
        [arrSearchKey addObject:strSearchContent4];
    }
    return arrSearchKey;
}

#pragma mark - row1
+ (BAImagaNameData *)create1Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter1Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter1.jpg";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 0;
    
    //将章节的数据源添加到数组中
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    
    return baImagaNameData;
}
+ (BAImagaNameData *)create2Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter2Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter2.jpg";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 1;
    
    //将章节的数据源添加到数组中
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    return baImagaNameData;
}
+ (BAThreeData *)create3Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"Chapter3Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"Chapter3.jpg";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 2;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(61, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(388, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(716, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(61, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(388, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect5];
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(96, 140, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(424, 140, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(96, 491, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(424, 491, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(424, 761, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 40]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 60]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 90]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 110]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 120]];
    
    //将章节的数据源添加到数组中
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}
+ (BAFourData *)create4Data{
    
    BAFourData *baFourData = [[BAFourData alloc] init];
    baFourData.imagedata.strPortraitImageName = @"Chapter4Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter4.jpg";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 3;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"本周行情综述\n本周市场关注点集中在沙特阿拉伯原油减产，美国债务上限的讨论以及美国原油库存下降，中国消费者指数上升将抑制经济刺激措施，等。然而，中国强劲的贸易顺差和原油进口量以及美国库欣地区到美国海湾地区石油运输管道扩容将纽约轻质原油期货推高到5个月来最高价位，布伦特原油对WTI溢价缩窄。截止2013年1月17日的一周，纽约商品交易所轻质低硫原油首月期货净涨1.93美元，涨幅2.06%；每桶结算均价94.14美元，比前一周高0.872美元，结算价最高每桶95.49美元，最低每桶93.28美元。伦敦洲际交易所布伦特原油首月期货净涨0.46美元，涨幅0.42%；每桶结算均价110.91美元，比前一周低0.75美元，结算价最高每桶111.88美元，最低每桶110.3美元。本周行情综述,本周市场关注点集中在沙特阿拉伯原油减产，美国债务上限的讨论以及美国原油库存下降，中国消费者指数上升将抑制经济刺激措施，等。然而，中国强劲的贸易顺差和原油进口量以及美国库欣地区到美国海湾地区石油运输管道扩容将纽约轻质原油期货推高到5个月来最高价位，布伦特原油对WTI溢价缩窄。截止2013年1月17日的一周，纽约商品交易所轻质低硫原油首月期货净涨1.93美元，涨幅2.06%；每桶结算均价94.14美元，比前一周高0.872美元，结算价最高每桶95.49美元，最低每桶93.28美元。伦敦洲际交易所布伦特原油首月期货净涨0.46美元，涨幅0.42%；每桶结算均价110.91美元，比前一周低0.75美元，结算价最高每桶111.88美元，最低每桶110.3美元。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 7;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), NSStringFromRange(NSMakeRange(136,3)), NSStringFromRange(NSMakeRange(255,5)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    //指定字体颜色和区域
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    //关键字语言
    KeyWord *key=[[KeyWord alloc]init];
    key.tag=1;
    key.Range=NSMakeRange(136, 3);
    
    KeyWord *key2=[[KeyWord alloc]init];
    key2.tag=2;
    key2.Range=NSMakeRange(255, 5);
    
    NSArray *arrKeywords = [[NSArray alloc] initWithObjects:key, key2, nil];
    baText.arrKeywords = arrKeywords;
    
    //横屏
    baText.arrRects = [LessTextNoAbstract setTextRect];
    baText.arrPicRect = [LessTextNoAbstract setImageRect];
    NSString *strPicName = @"B1C1A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [LessTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [LessTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B1C1A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"本周行情综述";
    baFourData.baText.iPageIndex = 4;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFiveDataExtend *)create5Data{
    BAFiveDataExtend *baFiveData = [[BAFiveDataExtend alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"Chapter5Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"Chapter5.jpg";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 5;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"第二部分 基本面分析\n1、	影响原有价格的重要消息\n美国总统奥巴马14日敦促国会尽快提高政府债务上限，以免给经济和金融市场造成负面影响。2012年12月份市场担心美国财政悬崖，在2013年年初财政悬崖问题告一段落，市场关注点放在了美国政府债务上限。奥巴马当天在白宫记者会上说，如果国家不能及时提高政府的举债上限，将给美国经济带来“自我伤害”。他强调，美国的国家信用不是谈判的筹码，在时间所剩不多的情况下，国会最好尽快采取行动。奥巴马说，如果决策得当，2013年美国经济将迎来好年头，而实现经济增涨的步骤之一就是以平衡和负责的方式缩减财政赤字。美国不能仅通过削减政府开支来降低赤字规模，在中长期努力稳定财政状况的同时，要在短期内采取措施刺激经济增长。沙特阿拉伯12月份原油日产量减少了近5%，以适应全球石油需求减缓，这是沙特阿拉伯三年来最大幅度的减产。沙特阿拉伯石油部长顾问在记者招待会上说，沙特阿拉伯降低原油日产量是因为原油需求季节性下降。影响原有价格的重要消息\n美国总统奥巴马14日敦促国会尽快提高政府债务上限，以免给经济和金融市场造成负面影响。2012年12月份市场担心美国财政悬崖，在2013年年初财政悬崖问题告一段落，市场关注点放在了美国政府债务上限。奥巴马当天在白宫记者会上说，如果国家不能及时提高政府的举债上限，将给美国经济带来“自我伤害”。他强调，美国的国家信用不是谈判的筹码，在时间所剩不多的情况下，国会最好尽快采取行动。奥巴马说，如果决策得当，2013年美国经济将迎来好年头，而实现经济增涨的步骤之一就是以平衡和负责的方式缩减财政赤字。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 10;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor whiteColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)),NSStringFromRange(NSMakeRange(11,133)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor whiteColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)),NSStringFromRange(NSMakeRange(11,150)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    KeyWord *key=[[KeyWord alloc]init];
    key.tag=1;
    key.Range=NSMakeRange(103, 4);
    NSArray *arrKeywords = [[NSArray alloc] initWithObjects:key, nil];
    baText.arrKeywords = arrKeywords;
    
    //landscape
    baText.arrRects = [MoreTextWithAbstract setTextRect];
    baText.arrPicRect = [MoreTextWithAbstract setImageRect];
    
    //Portrait
    baText.arrRectsPor = [MoreTextWithAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextWithAbstractPor setImageRect];
    
    //文字背景图片位置
    NSString *strBGRect = NSStringFromCGRect(CGRectMake(0, 161, 907, 170));
    NSArray *arrBGRects = [[NSArray alloc] initWithObjects:strBGRect, nil];
    baText.arrBGRect = arrBGRects;
    NSString *strBGRectPor = NSStringFromCGRect(CGRectMake(0, 177, 704, 170));
    NSArray *arrBGRectsPor = [[NSArray alloc] initWithObjects:strBGRectPor, nil];
    baText.arrBGRectPor = arrBGRectsPor;
    //文字背景图片名称
    NSString *strBGName = @"pic3.png";
    NSArray *arrBGNames = [[NSArray alloc] initWithObjects:strBGName,nil];
    baText.arrBGNames = arrBGNames;
    
    NSString *strBGNamePor = @"pic3Por.png";
    NSArray *arrBGNamesPor = [[NSArray alloc] initWithObjects:strBGNamePor,nil];
    baText.arrBGNamesPor = arrBGNamesPor;
    
    
    //图片名称
    NSString *strPicName = @"";//@"pic45.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"";//@"pic45.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"影响原有价格的重要消息";
    baFiveData.baText.iPageIndex = 6;
    
    BAText *baText1 = [[BAText alloc] init];
    
    baText1.text = @"第二部分 基本面分析\n3、	需求和库存方面的情况：\n美国能源信息署数据显示，截止2013年1月11日的四周，美国成品油需求总量平均每天1836.5万桶，比去年同期高1.7%；汽油需求四周日均量836.4万桶，比去年同期低0.6%；馏份油需求四周日均数337.5万桶，比去年同期低5.2%；煤油型航空燃料需求四周日均数比去年同期高1.1%。尽管美国原油库存下降，但是仍然远高于历史同期平均水平，且比去年同期高8.8%。美国原油产量迅速增长，今年开始突破每日700万桶，截止1月11日，美国原油日产量704.1万桶，比前周增长3.9万桶，比去年同期增长131.5万桶，增幅23%。然而这些增产的原油集中在美国中西部地区，且为页岩油，导致备受关注的西德克萨斯轻质原油期货交货地库欣地区原油库存继续创历史最高纪录，且十分接近最高有效库存容量。据美国能源信息署统计，由于成品油库存增长，过去的一周，美国石油库存总量增加了344万桶万桶，其中汽油库存增加191万桶万桶，馏分油库存增加169万桶。第二部分 基本面分析\n3、	需求和库存方面的情况：\n美国能源信息署数据显示，截止2013年1月11日的四周，美国成品油需求总量平均每天1836.5万桶，比去年同期高1.7%；汽油需求四周日均量836.4万桶，比去年同期低0.6%；馏份油需求四周日均数337.5万桶，比去年同期低5.2%；煤油型航空燃料需求四周日均数比去年同期高1.1%。尽管美国原油库存下降，但是仍然远高于历史同期平均水平，且比去年同期高8.8%。美国原油产量迅速增长，今年开始突破每日700万桶，截止1月11日，美国原油日产量704.1万桶，比前周增长3.9万桶，比去年同期增长131.5万桶，增幅23%。然而这些增产的原油集中在美国中西部地区，且为页岩油，导致备受关注的西德克萨斯轻质原油期货交货地库欣地区原油库存继续创历史最高纪录，且十分接近最高有效库存容量。据美国能源信息署统计，由于成品油库存增长，过去的一周，美国石油库存总量增加了344万桶万桶，其中汽油库存增加191万桶万桶，馏分油库存增加169万桶。";
    
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 10;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //横屏
    baText1.arrRects = [MoreTextNoAbstract setTextRect];
    baText1.arrPicRect = [MoreTextNoAbstract setImageRect];
    
    //portrait
    baText1.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    
    //图片名称
    NSString *strPicName_1 = @"B1C2A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    NSString *strPicNamePor_1 = @"B1C2A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"BFGraphViewController1";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"机构资金方面";
    baFiveData.baText1.iPageIndex = 7;
    
    BAText *baText2 = [[BAText alloc] init];
    baText2.text = @"第二部分 基本面分析\n3、	需求和库存方面的情况：\n美国能源信息署数据显示，截止2013年1月11日的四周，美国成品油需求总量平均每天1836.5万桶，比去年同期高1.7%；汽油需求四周日均量836.4万桶，比去年同期低0.6%；馏份油需求四周日均数337.5万桶，比去年同期低5.2%；煤油型航空燃料需求四周日均数比去年同期高1.1%。尽管美国原油库存下降，但是仍然远高于历史同期平均水平，且比去年同期高8.8%。美国原油产量迅速增长，今年开始突破每日700万桶，截止1月11日，美国原油日产量704.1万桶，比前周增长3.9万桶，比去年同期增长131.5万桶，增幅23%。然而这些增产的原油集中在美国中西部地区，且为页岩油，导致备受关注的西德克萨斯轻质原油期货交货地库欣地区原油库存继续创历史最高纪录，且十分接近最高有效库存容量。据美国能源信息署统计，由于成品油库存增长，过去的一周，美国石油库存总量增加了344万桶万桶，其中汽油库存增加191万桶万桶，馏分油库存增加169万桶。";
    baText2.iTitleFontSize = 38;
    baText2.iTitleLength = 10;
    baText2.strTitlFontName = @"Helvetica";
    baText2.iContentFontSize = 14;
    baText2.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors2 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText2.arrAttributeColors = arrAttributeColors2;
    NSArray *arrAttributeRanges2 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)), nil];
    baText2.arrAttributeRanges = arrAttributeRanges2;
    
    NSArray *arrAttributeColors2Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText2.arrAttributeColorsPor = arrAttributeColors2Por;
    NSArray *arrAttributeRanges2Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)), nil];
    baText2.arrAttributeRangesPor = arrAttributeRanges2Por;
    
    //landscape
    baText2.arrRects = [LeastTextNoAbstract setTextRect];
    baText2.arrPicRect = [LeastTextNoAbstract setImageRect];
    
    baText2.arrRectsPor = [LeastTextNoAbstractPor setTextRect];
    baText2.arrPicRectPor = [LeastTextNoAbstractPor setImageRect];
    //图片名称
    NSString *strPicName_2 = @"B1C2A3Por.png";
    NSArray *arrPicNames_2 = [[NSArray alloc] initWithObjects:strPicName_2,nil];
    baText2.arrPicNames = arrPicNames_2;
    
    NSString *strPicNamePor_2 = @"B1C2A3Por.png";
    NSArray *arrPicNamesPor_2 = [[NSArray alloc] initWithObjects:strPicNamePor_2,nil];
    baText2.arrPicNamesPor = arrPicNamesPor_2;
    
    //push Class
    NSString *pushClassName_2 = @"BFGraphViewController1";
    NSArray *arrPSNamesPor_2 = [[NSArray alloc] initWithObjects:pushClassName_2,nil];
    baText2.arrPushClassNames = arrPSNamesPor_2;
    
    baFiveData.baText2 = baText2;
    baFiveData.baText2.strTitle = @"需求和库存方面的情况";
    baFiveData.baText2.iPageIndex = 8;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, baFiveData.baText2, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFourData *)create6Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter6Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter6.jpg";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 9;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"第三部分 后市展望\n根据统计计算，2012年国际平均油价为112美元，为历史最高年度平均水平。近期，国际机构对国际油价走势作出了预测。2012年10月IMF《世界经济展望》秋季报告预计，2013年世界油价（WTI、Brent、Dubai三个市场油价简单平均）为每桶105.1美元，下降1%。2012年10月底，路透社调查显示，2013年WTI和Brent原油期货均价分别为98.5和108.8美元/桶。美国能源情报署2012年11月份《短期能源展望》预计，2013年WTI和Brent原油期货均价分别为每桶88.3和103.4美元，分别下降6.6%和7.4%。 有关机构预测今年石油需求增长完全在印度、中国和中东地区，如果油价持续走高将继续给全球经济带来风险。目前国际油价在110平台整理延续，上涨势头并不十分明显。综合判断，2013年石油供求关系将比较宽松，但地缘政治风险和投机炒作对国际油价的影响将会加大，国际油价运行区间将会向上移动，但基本面抑制国际油价过快上涨。初步预测，2013年纽约市场WTI原油期货平均价格约为每桶98美元左右，较上年略有回升，WTI原油期货价格将在80-115美元之间波动。如果欧债危机继续蔓延扩散、美国“财政悬崖”没能得到有效解决，部分新兴经济体出现硬着陆，世界经济增长明显低于预期，石油需求减弱，那么，国际油价运行区间将会向下调整。而如果欧美等发达国家的债务问题得到有效解决，新兴经济体重新恢复强劲增长，世界经济增长明显好于预期，石油需求较预期更为旺盛，那么国际油价运行区间将会进一步向上调整。\n分析师承诺\n本人（或研究团队）以勤勉的职业态度，独立、客观地出具本报告。本报告清晰准确地反映了本人（或研究团队）的研究观点。本人（或研究团队）不曾因，不因，也将不会因本报告中的具体推荐意见或观点而直接或间接接受到任何形式的报酬。\n免责声明\n客户不应视本报告为作出投资决策的惟一因素。本报告中所指的投资及服务可能不适合个别客户，不构成客户私人咨询建议。本公司未确保本报告充分考虑到个别客户特殊的投资目标、财务状况或需要。本公司建议客户应考虑本报告的任何意见或建议是否符合其特定状况，以及（若有必要）咨询独立投资顾问。在任何情况下，本报告中的信息或所表述的意见并不构成对任何人的投资建议。在任何情况下，本公司不对任何人因使用本报告中的任何内容所引致的任何损失负任何责任。若本报告的接受人非本公司的客户，应在基于本报告做出任何投资决定或就本报告要求任何解释前咨询独立投资顾问。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 9;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //landscape
    baText.arrRects = [BannerText setTextRect];
    baText.arrPicRect = [BannerText setImageRect];
    
    //
    baText.arrRectsPor = [BannerTextPor setTextRect];
    baText.arrPicRectPor = [BannerTextPor setImageRect];
    
    //图片名称
    NSString *strPicName = @"movpic.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"movpic.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"playmovie";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"后市展望";
    baFourData.baText.iPageIndex = 10;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAImagaNameData *)create7Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter7Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter7.jpg";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 12;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    
    return baImagaNameData;
}
+ (BAThreeData *)create8Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"Chapter8Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"Chapter8.jpg";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 13;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(49, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(378, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(707, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(49, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(378, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect5];
    NSString *strRect6 = NSStringFromCGRect(CGRectMake(707, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect6];
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(86, 261, 270, 191));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(414, 261, 270, 191));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(87, 493, 270, 191));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(413, 493, 270, 191));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(85, 725, 270, 191));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    NSString *strRect6Por = NSStringFromCGRect(CGRectMake(413, 725, 270, 191));
    [baThreeData.arrButtonFramePor addObject:strRect6Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 40]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 60]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 70]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 90]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}


#pragma mark - row 2
+ (BAImagaNameData *)create1_1Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter1_1Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter1_1.png";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 0;
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    
    return baImagaNameData;
}
+ (BAThreeData *)create2_1Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"Chapter3_1Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"Chapter3_1.png";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 1;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(61, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(388, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(716, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(61, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(388, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect5];
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(96, 140, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(424, 140, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(96, 491, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(424, 491, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(424, 761, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 30]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 60]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 90]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 110]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 120]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}
+ (BAFiveData *)create3_1Data{
    BAFiveData *baFiveData = [[BAFiveData alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"Chapter4_1Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"Chapter4_1.png";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 2;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"行业情况综述\n近年来，我国银行业资产规模保持了高速增长。截至2012年四季度末，我国银行业金融机构境内本外币资产总额为78.77万亿元，比上年同期增长26.25%，增幅比2011年上升了7.6个百分点；银行业金融机构境内本外币负债总额为74.33万亿元，比上年同期增长26.85%，增幅比2011年上升8.6个百分点。\n2012年,世界经济增长进一步放缓至3.2%,比2011年下降0.7个百分点。主要发达国家主权债 务压力高企,纷纷采取超宽松货币政策,加之气候、地缘政治等外部因素的作用,国际金融 市场持续动荡,跨境资本波动加剧。 国内方面,全年国内生产总值比上年增长7.8%,其中四季度比三季度加快0.5个百分点,主要 经济指标企稳回暖。同时我国就业温和扩大,居民收入持续较快增长,物价水平也总体处于 低位,企业经营和财务状况有所改善。但经济金融运行仍面临着结构调整和通货膨胀压力。就整体而言，国内各商业银行资产规模继续增长。截至2012年末，总资产余额达104.6万亿元（本外币合计，下同）， 比上年末增加16.2万亿元，同比增长18.3%，资产负债规模继续增长。经营利润继续增长，但增速放缓，合计实现净利润1.24万亿元，比2011年增加1972亿元，同比增长18.9%，同比下降0.55个百分点。资产质量方面,总体保持稳定,商业 银行不良贷款余额为4929亿元,比上季度末增加140亿元,比上年末增加647亿元;不良贷款 率为0.95%,与上季度末持平,比上年末下降0.01个百分点。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)),  nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //landscape
    baText.arrRects = [LessTextNoAbstract setTextRect];
    baText.arrPicRect = [LessTextNoAbstract setImageRect];
    
    //portrait
    baText.arrRectsPor = [LessTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [LessTextNoAbstractPor setImageRect];
    
    //图片位置
    //图片名称
    NSString *strPicName = @"B2C1A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"B2C1A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"行业情况综述";
    baFiveData.baText.iPageIndex = 3;
    
    BAText *baText1 = [[BAText alloc] init];
    baText1.text = @"本行年度状况\n2012年,本行实现净利润1,451.31亿元,较上年增加231.75亿元,增 长19.0%,主要是由于利息净收入和手续费及佣金净收入增加,同时资 产减值损失有所下降。截至 2012 年12 月31 日,本行总资产为132,443.42 亿元,较上年 末增加15,667.65 亿元,增长13.4%。其中,发放贷款和垫款净额增 加7,433.25 亿元,增长13.7%;投资净额增加2,233.96 亿元,增长8.5%; 现金及存放中央银行款项增加1,260.29 亿元,增长5.1%,主要是由于本 行吸收存款增加;存放同业和拆出资金增加1,410.56 亿元,增长40.9%, 主要是由于本行为提高资金使用效益,加大了资金运用力度;买入返售 金融资产增加2,851.80亿元,增长53.9%,主要是买入返售债券增加。 负债。截至2012 年12 月31 日,本行负债总额为124,929.88 亿元,较上 年末增加14,651.99亿元,增长13.3%。其中吸收存款增加12,409.09 亿 元,增长12.9%;同业存放和拆入资金增加2,098.37 亿元,增长29.0%; 卖出回购金融资产款减少844.48 亿元,减少91.7%,主要是由于受流动 性环境影响,本行融入资金减少。发行债券增加509.63 亿元,增 长51.0%,主要是由于报告期内本行发行了面值500 亿元的次级债券。其 他负债增加479.38 亿元,增长9.8%。截至 2012 年12 月31 日,本行股东权益合计7,513.54 亿 元,其中股本3,247.94 亿元,资本公积978.72 亿元,盈余公积439.96 亿 元,一般风险准备753.49 亿元,未分配利润2,084.88 亿元。每股净资产 为2.31 元。";
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 6;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //横屏
    baText1.arrRects = [MoreTextNoAbstract setTextRect];
    baText1.arrPicRect = [MoreTextNoAbstract setImageRect];
    
    //portrait
    baText1.arrRectsPor = [LessTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [LessTextNoAbstractPor setImageRect];
    //图片名称
    NSString *strPicName_1 = @"B2C1A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    NSString *strPicNamePor_1 = @"B2C1A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"BFGraphViewController1";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"本行年度状况";
    baFiveData.baText1.iPageIndex = 4;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFiveData *)create4_1Data{
    BAFiveData *baFiveData = [[BAFiveData alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"Chapter5_1Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"Chapter5_1.png";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 5;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"资产负债分析\n本行2012 年资产同比增长13.4%,年末资产总额达到13.24 万亿。资 产中贷款余额6.15 万亿,同比增长13.7%。同业规模在2012 年一季度 已经奠定了全年高增长的基础,一季末环比2011 年末增长48%,经历 上半年的高速扩张后在下半年略有回落,但仍然达到1.3 万亿,同比 增长49%,占资产比重从上年末的7.5%经历年内11.4%的高点回落 到9.8%。全年存款增长12.9%,净增长12,409亿元,其中县域贡献了 增量的5,433 亿元,占新增量的44%,由于通常本行时点余额低于日 均余额,实际存款增长情况比报表数字更好。\n      在贷款发放的分布上,在保持长三角、珠三角和环渤海地区信贷投放 力度的同时,信贷资源配置适当向信贷需求相对旺盛的中部、西部和 东北等地区倾斜,加大国家重点区域和主体功能区的信贷投放力 度。2012 年,中部、西部和东北部地区发放贷款和垫款总额合 计24,302.99 亿元,占发放贷款和垫款总额37.8%,较上年末增加了0.3 个百分点。同时,本行加强境内外贷款业务的联动营销,境外贷款占 比有所提升。\n截至2012 年12 月31 日,本行负债总额为124,929.88 亿元,较上年末 增加14,651.99亿元,增长13.3%。其中吸收存款增加12,409.09 亿元,增长12.9%; 同业存放和拆入资金增加2,098.37 亿元,增长29.0%;卖出回购金融资产款减少844.48 亿 元,减少91.7%,主 要是由于受流动性环境影响,本行融入资金减少。发行债券增 加509.63 亿元,增长51.0%, 主要是由于报告期内本行发行了面值500 亿元的次级债券。其他负债 增加479.38 亿元,增长9.8%。\n";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B2C2A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //竖屏
    baText.arrRectsPor = [LessTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [LessTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B2C2A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController2";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"资产负债分析";
    baFiveData.baText.iPageIndex = 6;
    
    BAText *baText1 = [[BAText alloc] init];
    baText1.text = @"收益分析\n面对经济下行、利率市场化加速及要素约束增强等诸多因素的挑 战,本行把提高发展质量和效益放在首要位置,着力加强资本回报 率、净利息收益率、成本收入比、资本充足率等核心经营指标的管 理,完善绩效考评机制,努力实现协调、可持续和有质量的增长。\n        截至 2012 年12 月31 日,本行股东权益合计7,513.54 亿元,其中股 本3,247.94 亿元,资本公积978.72 亿元,盈余公积439.96 亿元,一般 风险准备753.49 亿元,未分配利润2,084.88 亿元。每股净资产为2.31 元。\n        2012年,本行净利润1,451.31亿元,较上年增加231.75亿元,增 长19.0%,主要是由于利息净收入和手续费及佣金净收入增加,同时 资产减值损失有所下降。全年来看,2012年本行净利息收益 率2.81%,净利差2.67%,分别较上年下降4个基点和6个基点。 利息净收入是本行营业收入的最大组成部分。2012 年,本行实现利息 净收入3,418.79亿元,较上年增加346.80 亿元,占本行营业收入 的81.0%。其中实现利息收入5,660.63亿元,同比增加931.42亿元。主 要是由于生息资产平均收益率从2011年的4.39%上升到2012年 的4.66%,生息资产平均余额增加13,745.90亿元。利息支出 2,241.84 亿元,较上年增加584.62 亿元,主要是由于付息负债平均付息率 从2011 年的1.66%上升至2012 年的1.99%,付息负债平均余额增 加12,525.42 亿元。\n";
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 4;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,5)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0, 5)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //横屏
    baText1.arrRects = [LessTextNoAbstract setTextRect];
    baText1.arrPicRect = [LessTextNoAbstract setImageRect];
    
    //竖屏
    baText1.arrRectsPor = [LessTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [LessTextNoAbstractPor setImageRect];
    
    //图片名称
    NSString *strPicName_1 = @"B2C2A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    NSString *strPicNamePor_1 = @"B2C2A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"收益分析";
    baFiveData.baText1.iPageIndex = 7;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFiveData *)create5_1Data{
    BAFiveData *baFiveData = [[BAFiveData alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"Chapter5_1Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"Chapter5_1.png";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 8;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"一、信用风险\n        2012 年,本行积极应对宏观经济金融形势变化,坚持“稳基础,调结构,控风 险”的经营原则,认真贯彻落实国家宏观调控政策,继续完善信用风险管理的 制度和系统建设。加强重点领域的风险管控,密切监控企业的资金流向,加大 潜在风险客户退出力度。完善行业限额管理体系,深化客户名单制管理,加强 不良贷款清收处置,逐步优化信贷结构,全力控制和化解信用风险。\n        2012 年末,银行不良贷款余额858.48 亿元,不良率1.33%,拨备覆盖率326%, 拨贷比4.35%。 五级分类角度来看,关注类贷款年末比重为4.59%,比中报的5.07%有所下降。 全年核销40 亿元,加回核销后同口径计算不良余额净增2.5%,比建行9%、中 行7%的情况要好。逾期贷款年末879.05亿元,比中报的850.08 亿元略有增长, 逾期情况存在隐忧。\n        我们计算的年度信用成本为0.9%,较2011 年的1.21%有明显的回落,对于2012 年业绩有一定程度上的贡献。拨备覆盖率水平为326%,拨贷比4.35%,没有达标压力。我们认为在可见的未来会保持0.9%甚至更加优化的信用成本,拨 备“反哺”利润的余地将更大。\n        在宏观经济减速,银行业资产质量面临压力的情况下,贷款质量仍然保持稳 定,主要是由于银行:(1)按照全面风险管理原则,建立了完整、有效的贷 款风险防控体系,覆盖信贷准入、调查、授信、用信、贷后管理、不良贷款清 收等环节;(2)根据宏观经济形势和监管要求变化,及时调整信贷政策,推 行限额管理、客户名单制管理及停复牌管理,创新和应用风险管理的的新技术和新工具,风险识别和管控能力进一步增强;(3)加强贷后管理和不良贷款清 收处置,及时发现并化解风险。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B2C3A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //竖屏
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B2C3A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController3";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"信用风险";
    baFiveData.baText.iPageIndex = 9;
    
    BAText *baText1 = [[BAText alloc] init];
    baText1.text = @"二、市场风险\n        市场风险是指因市场价格的不利变动而使银行表内和表外业务发生损失的风险。本行面临的主要市场风险包括利率风险和汇率风险。\n        2012 年,本行不断完善市场风险管理制度体系,制定了年度资金交易投资业务 和市场风险管理政策、资金交易和投资业务估值管理办法、金融资产减值测试 管理办法等多项制度办法,修订了限额管理、账户划分、市场风险监测报告、 理财业务风险分类等制度。上线市场风险标准法系统。推进市场风险内部模型 法体系建设,建立内部模型法方法论体系,引进先进风险计量引擎,并逐步将 内部模型法计量结果应用到日常管理中,有效提高市场风险管理能力和水平。\n        截至 2012 年末,本行一年以内利率敏感性累计负缺口为1,175.97 亿元,缺口绝 对值较上年末减少1,422.29 亿元。利率敏感性分析表明在各个利率情形下,利息 净收入及其他综合收益的变动情况。以所有年期的利率均以相同幅度变动为前 提,且未考虑管理层为降低利率风险而可能采取的风险管理活动的情况下,基 于本行2012 年12 月31 日的资产及负债,若利率即时上升(下降)100个基点, 本行的利息净收入将减少(增加)103.62 亿元。若利率即时上升100 个基点,本 行的其他综合收益将减少133.05 亿元;如利率即时下降100 个基点,本行的其他 综合收益将增加139.66 亿元。通过定期运用缺口分析、敏感性分析、情景模拟 及压力测试对利率风险进行计量和分析,本行基本将利率风险敞口控制在可承 受的范围内。\n        2012 年,宏观经济环境复杂多变,人民银行继续实施稳健货币政策,并加大预 调微调力度。人民银行全年两次下调存款准备金率、两次降息,银行间市场流 动性总体上比去年相对宽松,货币市场短期利率波动较大。年末,货币市场各 档利率均同比有所下降。 本行通过流动性缺口分析来评估流动性风险状况。2012 年末,即期偿还负缺 口继续扩大,主要是活期负债增长较快;为保持短期流动性充足,本行适度加 大了买入返售资产和短期贷款等资产的配置力度,1 至3 个月负缺口绝对值较上 年末减少711.88 亿元,1 个月以";//内正缺口较上年末扩大3,176.15 亿元。
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 6;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0, 7)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //横屏
    baText1.arrRects = [MoreTextNoAbstract setTextRect];
    baText1.arrPicRect = [MoreTextNoAbstract setImageRect];
    
    //竖屏
    baText1.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    
    //图片名称
    NSString *strPicName_1 = @"B2C3A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    NSString *strPicNamePor_1 = @"B2C3A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"BFGraphViewController4";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"市场风险";
    baFiveData.baText1.iPageIndex = 10;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFourData *)create6_1Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter6_1Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter6_1.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 11;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"环境与展望\n        2012 年,全球货币政策进一步趋于宽松,主要发达经济体基准利率继续维持 低位,并分别推出不同形式的量化宽松政策。美联储9 月份推出第三轮宽松政 策,同时在年底扭曲操作到期后,继续扩大现有资产购买计划。主要新兴经济 体国家也采取了连续降息或下调存款准备金率的宽松货币政策。\n        2012 年,中国政府继续实施积极的财政政策和稳健的货币政策,把稳增长放 在更加重要的位置,进一步加大了经济结构调整的力度。中国人民银行两次下 调存贷款基准利率和存款准备金率。利率、汇率市场化进程进一步加快,金融 机构存贷款利率浮动区间扩大,银行间即期外汇市场人民币兑美元交易价日波 动幅度扩大至1%。,中国货币信贷和金融市场运行总体平稳。年末广义货币 供应量(M2)同比增长13.8%,增速比上年末提高0.2 个百分点。全年社会融 资规模15.76 万亿元,同比增长22.8%。\n        展望2013 年,预计全球经济仍将维持温和复苏和低速增长,货币政策继续保 持宽松,财政整顿仍然任重道远,系统性风险趋于下降。中国政府进一步明确 了新型工业化、信息化、城镇化和农业现代化的发展路径,将对经济增长态势 产生长期而深远的影响。2013年,预计中国将继续实施积极的财政政策和稳健 的货币政策。在周期性和政策性因素影响下,预计中国基础设施投资增速将会 加快,消费增速将平稳回升,外贸实现企稳,经济增速有望稳定回升。城镇化 有望实现突破性进展,农业基础地位将得到巩固,强农惠农富农 政策力度将会加大,县域经济和“三农”发展迎来新一轮战略机遇期。预计中国 银行业面临的货币和监管环境将保持稳定。新资本管理办法开始实施,金融脱 媒和利率市场化步伐加快,互联网金融业态蓬勃发展,将促进银行业进一步加 快经营转型的步伐。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 5;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,6)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,6)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B2C4A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B2C4A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFPieViewController";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"环境与展望";
    baFourData.baText.iPageIndex = 12;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFourData *)create7_1Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter6_1Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter6_1.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 13;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"往前看，县域——曾经的负累，如今的金矿\n1、县域业务有望伴随着城镇化率的提高而再次腾飞\n自改革开放以来，中国城镇化水平稳步提升，城镇化的步伐进一步加快。1978 年中国的城镇化率仅为17.9%，目前已经达到52.6%。城镇化的进程伴随着产业的转移和区域经济重点的迁徙，带来了庞大的投资需求，产生了良好的经济结果，城市居民收入水平上升明显。自新的决策层上台后，新型城镇化被赋予了激发中国经济再次腾飞的重任，希望通过城镇化率的提高，尤其是中西部地区城镇化率的提高来实现国民收入整体提高。这一点也被一直关注产权与经济效率研究的科斯和他的学生王宁在其新著《变革中国》中提及，“中国的关键优势来自于她拥有的13 亿进取、努力、不屈不挠的人民”。中国的城镇化进程将激发现有农村人口渴望进程的动力和干劲，从而实现经济的再次腾飞”。\n在中西部地区城镇化推进以及东部地区城镇化进程深入的过程中，我们认为对于金融行业特别是银行业会有以下的促进：\n1） 信贷需求带来生息资产规模进一步扩大：投资规模提高需要银行业的投融资支持，不论是来自于信贷的投放，还是来自财务咨询和信贷安排业务的专业化建议，银行业都有相对更为明显的优势。相比东部沿海地区等已经较为发达地区，中西部地区和包括东部地区在内的县域经济并不具备通过直接融资满足所有资金需求的能力，信贷还是最为简单、直接的方式，这恰恰是银行的长处。\n2） 息差有提升的空间，农行在中西部地区和行政区划上的县乡级行政区的网点分布是最广的，对于当地客户的了解程度也相对最好，在这些区域发展过程中有望对于当地企业保持较好的议价水平，同时继续扩大县域存款的市场份额，整体降低负债成本，提高息差水平。\n3） 中间业务增长有舞台：伴随着城镇化过程的推进，广大县域居民的财富效应会激发出相对广泛的理财需求，这类型零售业务的初期培育阶段往往反映在银行理财产品销售额的增长，同时也会进一步刺激如银行卡的发行，托管业务收费的增长，手续费及佣金收入多元化提高。\n\n2、把握城镇化市场机遇\n本行相信，城镇化的深入发展将为本行及县域金融业务带来巨大的市场机会。作为一家在城市和县域金融市场均占据主流地位的大型商业银行，本行亦具备通过覆盖中国城乡的渠道和产品体系，向城镇化市场主体提供优质金融产品和服务，从而把握城镇化市场机遇的独特条件。本行将深入把握城镇化发展带来的重大市场机遇，依托县域金融业务的领先地位和专业化经营优势，致力于为城镇化建设提供全方位一揽子金融服务，构建具有专业化特色的城镇化金融服务新模式。\n——明确城镇化建设的重点金融服务领域。把握城镇化进程中居住社区化、产业园区化、农民市民化的新趋势，重点支持城镇化产业支撑项目，城镇化基础设施建设项目，新型社区建设项目，土地整理与土地开发项目，公共服务和民生工程项目，进城居民生产经营和消费升级项目等六个重点领域。\n——优化整合支持城镇化建设的金融渠道体系。适当扩大对新兴城镇的网点覆盖率，推动县域网点布局重心向中心城区、工业园区、经济强镇转移。强化电子渠道在县域金融业务领域的应用，探索县域地区手机支付等移动金融服务新模式，推进县域全渠道体系的融合。\n——创新城镇化信贷管理政策。加快研究推出契合县域城镇化建设特点的信贷政策，创新城镇化建设客户授信方式，合理设定信贷审批权限，探索优化城镇化贷款业务流程，拓宽抵押担保方式。\n——建立适应市场需求的城镇化系列产品和服务。打造服务城镇化建设的产品体系和金融品牌，创新区域性城镇化贷款产品，探索制订有针对性的特色金融服务方案，加强地方政府债券承销、城镇居民理财产品、城镇电子银行业务等非融资产品的创新。\n——构建全方位的城镇化业务风险防控体系。强化全过程管理，规范业务运作，提高风险定价水平，加强重点行业风险的研判，建立一套包括风险政策、内部机制、管理工具、科技支撑在内的县域城镇化业务风险防控体系。\n——强化城镇化业务的支持保障。在信贷计划、固定资产投入、工资费用分配、客户经理配备等方面，加大资源配置力度，建立激励约束机制，强化城镇化金融业务团队专业素能，为城镇化信贷业务健康发展提供保障。\n";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 19;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,19)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,19)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B2C5A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B2C5A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController1";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"往前看，县域——曾经的负累，如今的金矿";
    baFourData.baText.iPageIndex = 14;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFourData *)create8_1Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter6_1Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter6_1.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 16;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"三年规划\n未来三年，围绕股东价值最大化的目标，本行将在大力拓展城市业务的同时，力图在巩固县域“三农”业务差异化发展优势上取得新进展；在增强公司银行业务支柱地位的同时，力图在巩固零售银行业务战略基点地位和形成独具特色的金融市场业务优势上取得新进展；在支持东部地区分行巩固市场、率先发展的同时，力图在持续推进各区域分行协调发展方面取得新进展；在扎根本土做好境内业务和发展商业银行主体业务的同时，力图在融入国际和多元化服务方面取得新进展。\n        ——加快推进业务经营转型步伐。县域“三农”业务转型的重点是找准市场定位，把城乡一体化进程中的强农、惠农金融服务作为战略重点，大力支持县域地区“四化”同步建设，并从整体上构建一套有效的“三农”服务模式，塑造差异化的竞争优势。公司业务转型的重点是优化客户结构，降低资本消耗，强化交叉销售，提高定价能力，重视优质中小客户的拓展，提高收益水平和市场竞争力。零售业务转型的重点是发挥网点网络优势，以分层服务改进客户体验，持续保持稳定低成本的资金来源，打造一流零售银行品牌。金融市场业务转型的重点是发挥资金来源充足、贷存比低的优势，完善金融市场业务的组织和管理体系，改进金融市场业务流程，将金融市场业务打造成为市场竞争力突出的特色业务。\n        ——提升城乡业务联动和区域协调发展水平。完善产品创新推广体系，健全城乡联动的营销机制，加大对城乡结合部地区的金融服务支持。在保障东部地区率先发展的同时，提升资源配置与经济增长的契合度，加快中西部和东北地区分行发展，促进区域间的协调发展。继续加快推进重点城市行发展，并以此带动城乡业务联动和区域协调发展。\n        ——强化国际业务与多元化服务能力。完善跨境贸易金融服务体系，强化对国际合作的金融支持，有序发展海外机构，稳步提升跨境金融服务能力。坚持以商业银行为主体，积极稳妥地实施综合化经营策略，充分利用本行的品牌、客户、网络和资源优势，强化联动机制，完善跨市场、跨业务的多元化服务能力。\n        未来三年，本行将适应业务发展需要，在产品研发管理、风险管理和内部控制、资产负债与资本管理、绩效考核与财务会计管理、运营体系建设、信息技术建设、组织架构与17人力资源管理、企业文化与品牌建设等八个方面，持之以恒地推进改革和管理创新，构建充满活力、富有效率的体制机制和管理方式，降低资本消耗，稳定成本收入比，体现风险约束要求，持续释放改革“红利”，提升本行的经营管理水平和价值创造能力。本行将积极探索建立既符合现代公司治理要求，又能体现农行特色的公司治理机制，为加快经营转型和管理变革提供支撑和保障。本行将切实推动规划的实施和评估，构建起从战略到规划，从规划再到计划、到项目的科学的战略实施和管理流程。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 4;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,5)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,5)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B2C6A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B2C6A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController2";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"三年规划";
    baFourData.baText.iPageIndex = 17;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAImagaNameData *)create9_1Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter7_1Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter7_1.png";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 19;
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    return baImagaNameData;
}
+ (BAThreeData *)create10_1Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"Chapter8_1Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"Chapter8_1.png";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 20;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(49, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(378, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(707, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(49, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(378, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect5];
    NSString *strRect6 = NSStringFromCGRect(CGRectMake(707, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect6];
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(87, 252, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(415, 252, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(87, 484, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(415, 484, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(87, 716, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    NSString *strRect6Por = NSStringFromCGRect(CGRectMake(415, 716, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect6Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 30]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 40]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 60]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 70]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 80]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}

#pragma mark - row 3
+ (BAImagaNameData *)create1_2Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter1_2Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter1_2.png";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 0;
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    return baImagaNameData;
}
+ (BAThreeData *)create3_2Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"Chapter3_2Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"Chapter3_2.png";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 1;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(61, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(388, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(716, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(61, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(388, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect5];
    
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(96, 198, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(425, 138, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(96, 548, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(425, 487, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(425, 760, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 30]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 80]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 110]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 120]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}
+ (BAFiveData *)create4_2Data{
    BAFiveData *baFiveData = [[BAFiveData alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"Chapter5_2Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"Chapter5_2.png";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 2;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"我行个人信贷业务详情\n2012 年本行贯彻落实国家房地产宏观调控政策,不断完善差别化住房信贷政策,切 实满足居民家庭首次购买普通自住商品住房的贷款需求。契合城镇化梯度发展趋势,适度 加大中西部地区个人住房贷款业务的投放力度,促进区域协调发展。根据新型城镇化的特 点,大力支持新市民落户安居。着力完善风险定价机制,实施个人贷款差异化定价。紧紧 围绕国家鼓励消费扩大内需的政策,优化产品设计,提升客户体验,积极开展房抵贷、随 薪贷等产品专题营销。响应扶持小微企业发展的国家政策导向,加大小微信贷支持力度。 扎实开展批发营销、联动营销和重点营销,提升服务实体经济能力。\n        截至2012 年12 月31 日,个人住房贷款10,509.99 亿元,较上年末增加1,594.97 亿元,增 长1 7 .9 %。本行积极配合落实房地产市场宏观调控政策,以支持居民购买首套普通自住房 为重点,依托优质开发企业和二手房中介机构,稳步发展个人住房贷款业务。 个人消费类贷款1,703.65 亿元,较上年末增加262.34 亿元,增长18.2%,主要是由于本行 围绕国家鼓励消费、扩大内需的政策导向,加强产品创新和营销管理,有效满足个人客户 消费信贷需求。\n        个人经营贷款2,003.97 亿元,较上年末增加429.73 亿元,增长27.3%,主要是由于本行积 极开展个人助业贷款业务,着力提升对小型微型企业业主和个体工商户的信贷支持。 个人卡透支1,491.38 亿元,较上年末增加487.88 亿元,增长48.6%,主要是由于本行大 力发展信用卡分期付款业务,信用卡透支余额增长较快。 农户贷款1,344.84亿元,较上年末减少 0.51亿元,主要是由于本行加强农户贷款集约化经 营,调整优化客户结构、产品结构和担保结构。\n        本年回顾\n        2012 年,本行全面实施了“百强千优”专业市场信贷服务工程,为全国数百家大型专业市场 (商圈)经营商户提供个人助业贷款、旺铺贷、卡捷贷、自助循环贷等服务。\n        2012 年,本行个贷集中经营向纵深推进,专业化水平进一步巩固提升。品牌价值进一步提 升,“金钥匙•好时贷”正式更名升级为“好时贷”,成为本行个人信贷业务专属品牌。\n        本行第三次蝉联“2012卓越竞争力个人贷款银行”。保捷贷产品在中国社科院与《银行 家》杂志联合主办的“2012中国金融服务创新奖”中荣获“十佳金融产品创新奖”。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 10;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,11)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //landscape
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    
    NSString *strPicName = @"B3C1A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"B3C1A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController1";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"我行个人信贷业务详情";
    baFiveData.baText.iPageIndex = 3;
    
    BAText *baText1 = [[BAText alloc] init];
    baText1.text = @"个人信贷风险报告\n        2012 年,本行积极应对宏观经济金融形势变化,坚持“稳基础,调结构,控风险” 的经营原则,认真贯彻落实国家宏观调控政策,继续完善信用风险管理的制度和系统建 设。 加强重点领域的风险管控,密切监控企业的资金流向,加大潜在风险客户退出力度。完善 行业限额管理体系,深化客户名单制管理,加强不良贷款清收处置,逐步优化信贷结构, 全力控制和化解信用风险。\n        管理报告\n        个人业务风险管理 完成零售内部评级体系在全行范围内的上线投产,加强评级结果在信贷准入、贷后管理、 贷款定价等方面的应用。进一步完善基本制度、管理办法和单项产品细则三个层次的个人 信贷制度体系。深化个人信贷业务集中经营改革,个贷集中经营中心覆盖率达99%,促进 中后台运作专业化、标准化、流程化和集约化。推广应用个人信贷业务风险监测系统,实 现个贷风险的智能化监测和预警,提升风险识别和管控能力。继续严格实施个人信贷产品 停复牌管理,推进个贷产品结构不断优化。规划建立总行客服中心集中外呼、个贷中心集 约管理和经营行属地催收相结合的催收管理模式,正式上线运行个贷集中电话催收系统, 不断提升催收成效。\n        信用卡业务风险管理 完善信用卡业务风险管理制度体系,制定信用卡业务风险管理办法、外包风险管理、贷后 风险管理等多项制度,完善欺诈交易监控、集中催收等标准化操作手册。建设集中化调查 审批中心,上收审批权限,加强客户准入管理。建立全行反欺诈调查中心,加强同业风险 信息交流,有效防范欺诈申请和伪卡交易。加强收单商户的准入和日常管理,定期开展商 户培训和巡检,不定期开展商户风险排查,优化收单商户风险监控系统,实现风险交易的 实时阻断,强化收单风险防控。\n        风险数据\n        截至2012 年末,本行不良贷款余额858.48 亿元,较上年末减少15.10 亿元;不良贷 款率1.33%,下降0.22 个百分点。关注类贷款余额2,954.51 亿元,较上年末下降192.06 亿元;关注类贷款占比4.59%,下降0.99 个百分点。";
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 8;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //landscape
    baText1.arrRects = [MoreTextNoAbstract setTextRect];
    baText1.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName_1 = @"B3C1A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    //portrait
    baText1.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor_1 = @"B3C1A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"BFGraphViewController2";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"个人信贷风险报告";
    baFiveData.baText1.iPageIndex = 5;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFourData *)create5_2Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter4_2Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter4_2.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 6;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"中国消费信贷市场发生了什么？\n经济增长和政府政策市推动信贷增长的重要因素 \n中国经济强市发展推动了收入、财富和消费的增长。过去多年中国政府一直鼓励出口和投资，现在也积极鼓励消费。\n中国的消费贷款初始渗透率非常低，发展历史短（如信用卡在中国发展才十余年），但从2005年至2010年中国消费贷款余额以平均每年29%的速度增长，我们预计未来五年其年均增长在24%。\n住房抵押贷款将在规模上占主导地位，但一般性消费金融（即除房贷、车贷和信用卡以外的、对耐用消费品或教育和医疗等服务或房屋装修等个人消费的短期贷款）和信用卡在增速上要更胜一筹。\n\n各个财富阶层和年龄段的市场机遇才能在显著差异 \n我们将消费者分为九大类，并发现富裕消费群体（特别是年轻的富裕群体）无论是现在还是未来对各类产品的需求最为强劲。基于他们对调查问题的回答，他们的未来渗透潜力也最高。\n几大城市居民目前和未来对借贷产品都有较高需求。\n然而，其他细分群体也同样蕴含机遇。例如，中年中产阶层就对产品创新和捆绑非常感兴趣。\n建立成功信贷业务的关键在于深入了解消费者如何挑选借贷方、如何获取产品信息以及他们的痛点在何处 \n品牌、简单的申请流程、便捷的还款以及合理的利率是消费者选择借贷方时最看重的因素。\n为了获取信息，中国消费者更多依靠银行咨询和熟人口碑推荐。网络渠道最合适年轻消费者，特别是在了解信用卡方面。\n消费者对某些方面也存在不满：繁琐冗长的申请流程、低质服务（比如缺乏有用的产品信息）、利息和手续高以及住房抵押贷款偿还条款严格。\n能够提升IT系统、改善业务流程并将以客户为中心的文化灌输给员工的借贷方能够实现差异化，并吸引到许多新客户。\n";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 14;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,14)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,14)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    
    NSString *strPicName = @"B3C2A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"B3C2A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController3";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"中国消费信贷市场发生了什么";
    baFourData.baText.iPageIndex = 7;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFiveData *)create6_2Data{
    BAFiveData *baFiveData = [[BAFiveData alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"Chapter5_2Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"Chapter5_2.png";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 8;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"消费信贷为何在增长\n消费信贷发展的基础在于经济增长和个人收入增加，而中国在这两方面都已非常出色。中国式从金融危机中快速恢复的国家之一，并在2010年第二季度超过日本成为全球第二大经济体。2010年的GDP以10.3%的惊人速度增长。\n随着经济的强势增长，社会各阶层收入和消费水平不断提升。这些因素都推动2010年零售销售额增长超过18%。在过去五年内，中国财富以平均每年20%的速度增长。研究表明，富裕家庭（可投资金融资产自50万元人民币以上的家庭）和中产阶层家庭（可投资金融资产在20万到50万元人民币的家庭）的财富在过去五年以15%左右的速度快速扩大。这些家庭通常有很强的消费欲望，且对消费信贷产品有很强的需求，因此为银行提供了巨大的机遇。\n除了广泛的经济优势外，几方面具体因素也促进了消费信贷的激增：\n初期渗透率低。十到二十年前，中国的消费信贷几乎为零。21世纪初信用卡才被广泛引入国内，住房抵押贷款也是近几年才流行起来。消费贷款占GDP的比例在2009年仅为18%（2004年为11%）。这一比例远远低于其他发达市场的水平，以及香港和台湾地区（其可比渗透率达到40-50%）。随着市场日渐成熟，我们预计到2015年中国的这一比率将接近30%。\n政府支持。在政府积极支持政策的推动下，中国国内消费水平在近几年快速提高。例如，十二五规划的一项关键议题是将以出口和投资为驱动的经济转向以消费、出口和投资为驱动的经济。计划目标是到2015年个人消费占GDP的比例从目前的36%增值42-45%。政府也出台了相关举措以刺激汽车、家电和家装消费。例如，中国银行业监督管理委员会和中国人民银行现在鼓励当地银行发展一般性消费金融业务。未来政府的政策将继续鼓励消费和融资。\n极具吸引力的经济效益。与公司贷款相比，消费信贷产品提供了出色的风险调整后回报。例如，2009年中国住房抵押贷款的不良率仅为0.6%，相比之下大量公司贷款的不良率在1.6%。虽然住房抵押贷款的定价经常在基准利率的基础上进行下调（最多在30%），但其仍为银行在扣除预期损失后提供了极具吸引力的利润率。\n对于信用卡和一般性消费金融类贷款而言，不良贷款率会更高些（2009年分别是2.8%和2.5%）。但是，潜在利率高达两位数，有效地提高了风险调整后的收益。然而，汽车贷款因其地域基准利率较多以及较高的不良贷款率（2009年是2.8%）而导致利润水平较低。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 9;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor whiteColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)),NSStringFromRange(NSMakeRange(10,166)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor whiteColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)),NSStringFromRange(NSMakeRange(10,152)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //landscape
    baText.arrRects = [MoreTextWithAbstract setTextRect];
    baText.arrPicRect = [MoreTextWithAbstract setImageRect];
    
    //portrait
    baText.arrRectsPor = [MoreTextWithAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextWithAbstractPor setImageRect];
    
    //文字背景图片位置
    NSString *strBGRect = NSStringFromCGRect(CGRectMake(0, 161, 907, 170));
    NSArray *arrBGRects = [[NSArray alloc] initWithObjects:strBGRect, nil];
    baText.arrBGRect = arrBGRects;
    NSString *strBGRectPor = NSStringFromCGRect(CGRectMake(0, 177, 704, 170));
    NSArray *arrBGRectsPor = [[NSArray alloc] initWithObjects:strBGRectPor, nil];
    baText.arrBGRectPor = arrBGRectsPor;
    //文字背景图片名称
    NSString *strBGName = @"pic3.png";
    NSArray *arrBGNames = [[NSArray alloc] initWithObjects:strBGName,nil];
    baText.arrBGNames = arrBGNames;
    
    NSString *strBGNamePor = @"pic3Por.png";
    NSArray *arrBGNamesPor = [[NSArray alloc] initWithObjects:strBGNamePor,nil];
    baText.arrBGNamesPor = arrBGNamesPor;
    
    
    //图片名称
    NSString *strPicName = @"";//@"pic45.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"";//@"pic45.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    
    //push Class
    NSString *pushClassName = @"";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"消费信贷为何在增长";
    baFiveData.baText.iPageIndex = 9;
    
    BAText *baText1 = [[BAText alloc] init];
    baText1.text = @"消费者需求情况：调研数据结果\nBCG近期对中国15个城市的1600多名消费者展开了实地调研，覆盖了各个年龄段、资产、地区和城市规模。从总体来看，调研中仅有2%的受访者曾经使用过一般消费性金融产品，而是用信用卡产品的受访者占64%。然而，8%的尚未是用的受访者计划在下一年是用一般性消费金融产品，约五分之一希望是用住房抵押贷款或汽车贷款，十分之一计划是用信用卡。\n一般性消费金融史政府刺激整体国内消费计划的关键部分。2009年银监会正式启动试点项目，在四大城市批准了四家消费金融公司，并可能继续支持这一领域。此外，许多当地银行已经选择一般性消费金融作为增长平台。我们预计一般性消费金融将借助国内消费水平不断提高的东风，在未来五年以45%的速度增长，成为所有消费信贷产品中增速最快的市场。";
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 15;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,15)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,15)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //landscape
    baText1.arrRects = [LeastTextNoAbstract setTextRect];
    baText1.arrPicRect = [LeastTextNoAbstract setImageRect];
    NSString *strPicName_1 = @"B3C3A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    //portrait
    baText1.arrRectsPor = [LeastTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [LeastTextNoAbstractPor setImageRect];
    NSString *strPicNamePor_1 = @"B3C3A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"消费者需求情况：调研数据结果";
    baFiveData.baText1.iPageIndex = 11;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFourData *)create7_2Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter6_2Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter6_2.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 12;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"关键市场特点\n尽管中国的消费信贷出现飞速增长,但并不是每家金融机构都适 合在各条产品线或低于市场进行竞争。借贷方只有充分了解各项 借贷业务的市场特点,才能在所选市场简历可持续发展的业务模式。\n        消费信贷是规模业务。品牌是挑选大多数贷款产品的最重要标准,品牌需要 时间和资源来打造。打造业务也需要对信息技术系统进行大量的投资,包括客 户关系管理系统、信贷管理系统和业务流程管理。此外,全面的产品和服务可 以帮助借贷方交叉销售产品并增加钱包份额。因此,更大规模的金融机构能够 从广泛的品牌认知度、规模经济效益和产品组合系列中收获颇丰。\n        所有参与者都能够找到极具吸引力的增长机遇。尽管品牌对于挑选一家借贷 方而言非常重要,但比起成储蓄账户,消费者更愿意在借贷产品上开始一段新 的关系。中国一般性消费金融目前的低渗透率和未来的高需求为新进入者和小 型机构提供了极具吸引力的增长空间。\n        信用卡渗透至一般消费金融领域简历了坚实的平台。信用卡对大众群体的吸 引力及其简洁快速的流程使其成为消费者安排一般性消费金融产品的合理渠 道。拥有出色信用卡业务的借贷方可以利用这一平台提供分期贷款等产品。成熟银行比起那些必须从头开始的银行更具优势。\n             简便的流程和优质服务是关键差异点。各个细分业务的消费者抱怨最多的是 流程繁琐和服务较差。解决这些问题的借贷方能够赢得客户,因为口碑推荐在 选择借贷上发挥着重要作用。\n        三类城市消费群体组成了大部分市场。增长较慢的细分群体来自较小城市, 他们对未来融资的需求相对较低。高增长细分群体来自几大城市和沿海省份的 一级城市,通常由拥有成熟网络的大型当地银行和外资银行以及追求快速增长 机遇的一些细分机构来提供服务。特定细分群体来自本土城市,由努力挖掘某 些高增长客户群(如年轻的富裕群体)的小型机构来服务。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,6)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,6)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //landscape
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B3C4A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B3C4A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController4";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"关键市场特点";
    baFourData.baText.iPageIndex = 13;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFourData *)create8_2Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"Chapter6_2Por.png";
    baFourData.imagedata.strLandscapeImageName = @"Chapter6_2.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 14;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"未来业务规划要点\n        增强风险管理的前瞻性和主动性\n       严密关注各类风险因素的变化,持续强化全面风险管理,加大主动防控力度,实现了业务发展与风险管控的有效平衡 。突出 信用风险防控,细化行业信贷政策、行业限额和名单制管理,加强风险的深度排查和监测预警.\n        发挥比较优势,提升城乡两大市场竞争力\n        针对城乡两个市场的不同特点,加大 资源整合和改革创新力度,实施差异化、特色化经营。继续推进重点城市行率先发展,成 功实现三年发展目标,重点城市行市场份额稳步提升,价值贡献不断增强。县域市场方面, 按照有利于防范风险、有利于降低成本、有利于商业可持续的原则,大力拓展强农惠农富 农金融服务。\n        客户和业务结构持续优化,不断增强可持续发展能力 深化客户分析,细分用户,识别增长机遇。同时加强新兴互联网金融企业实时、互动的社交型客户关系管理以及基于海量客 户数据分析的个性化金融服务,使传统的客户关系管理模式和标准化的产品开发模式面临转型。加强互联网金融的挑战将推 动商业银行在经营理念、组织架构、管理流程、运营模式、IT 架构等领域进行全面调整和深度整合,以互联网企业的思维方 式和理念,融入新技术、新生活和新商业模式。\n        基础管理扎实推进,进一步提升管理效能 继续开展“基础管理提升年”活动,在信贷、财会、运营、科技和员工行为五大领域推行精细化管理,较好地提高了经营管理 效能。深化运营 “三大集中”改革,实现 “三大集中”联网网点的全覆盖,初步构建了新型作业模式和风险集中管控模式。在基 层网点开展“三化三铁”创建,持续提升业务运作的规范化、制度化水平。加速新一代核心银行系统(BoEing)的上线,增 强科技支撑作用。与此同时,加大企业文化建设和品牌推广力度,深入开展“服务品质提升年”活动,着力改善客户服务体 验,提升社会美誉度。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 8;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,9)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //landscape
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B3C5A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B3C5A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFPieViewController";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"未来业务规划要点";
    baFourData.baText.iPageIndex = 15;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAImagaNameData *)create9_2Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"Chapter7_2Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"Chapter7_2.png";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 16;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    return baImagaNameData;
}
+ (BAThreeData *)create10_2Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"Chapter8_2Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"Chapter8_2.png";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 17;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(49, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(378, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(707, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(49, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(378, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect5];
    NSString *strRect6 = NSStringFromCGRect(CGRectMake(707, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect6];
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(87, 252, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(415, 252, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(87, 484, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(415, 484, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(87, 716, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    NSString *strRect6Por = NSStringFromCGRect(CGRectMake(415, 716, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect6Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 60]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 70]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 80]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 90]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 100]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}

#pragma mark - row4
+ (BAImagaNameData *)create1_3Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"InvationChapter1Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"InvationChapter1Lan.png";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 0;
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    return baImagaNameData;
}
+ (BAThreeData *)create2_3Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"InvationChapter2Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"InvationChapter2Lan.png";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 1;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(61, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(388, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(716, 143, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(61, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(388, 489, 248, 177));
    [baThreeData.arrButtonFrame addObject:strRect5];
    
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(96, 198, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(425, 138, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(96, 548, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(425, 487, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(425, 760, 248, 177));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 30]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 80]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 110]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 120]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}
+ (BAFourData *)create3_3Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"InvationChapter3Por.png";
    baFourData.imagedata.strLandscapeImageName = @"InvationChapter3Lan.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 2;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"本周行业焦点\n资金利率跌至年内低位，流动性充裕局面仍将延续\n因公开市场持续净投放、节后现金回流银行体系以及信贷规模管控，银行间市场资金面十分充裕。短期回购利率已跌至年内最低位，1 天/7 天回购利率分别回落至1.90%/2.21%。本月巨大的公开市场到期和差准到期资金以及持续增长的外汇占款将使资金面更为宽松。预计公开市场回笼力度会加大（目前3 个月央票一二级市场利率已接轨）；即便准备金上调一次亦不会对资金面产生明显冲击，本月流动性宽裕局面仍将延续。\n据悉2 月信贷将再低于预期，紧缩政策或已阶段性见顶\n据报道 2 月新增信贷6000 亿元以下，同比环比均下滑，远低于此前市场预期。我们的看法：（1）新增信贷连续两个月低于预期。银行信贷资源稀缺，与此同时民间金融活跃，民间借贷利率随加息和银行信贷紧缩而一路上扬。这大幅增加了企业财务成本，加之普遍的劳动力成本上升，无疑对企业利润形成明显压缩，这将引起决策层关注。（2）前期偏紧货币政策已得到有力贯彻，这必将在CPI 走势上有所反应，目前市场对短期CPI 走势的预期已有所降低。（3）加之海外局势出现动荡，“保持经济平稳较快发展”再次被提升到至关重要的位置。鉴于此，我们判断目前紧缩政策已阶段性见顶；3 月的政策环境较好，这有利于市场和低估值大盘股行情的延续。\n低估值和业绩超预期是上涨的基石：行业1 季报业绩预增30%\n银行1 季度息差回升超预期。年初以来信贷呈现明显供不应求，信贷资源紧张导致银行贷款议价能力显著提高。此外，3 次加息的累积正面影响及票据利率和货币市场利率的提升都是1 季度息差快速回升的贡献因素。根据我们的预测，行业1 季度业绩同比增长30%，部分中小银行业绩增速将达到40~50%。建议关注招行、浦发、华夏、南京和宁波银行。\n利率市场化、资产质量隐忧等长期因素不妨碍中短期行情的演绎\n十二五期间监管层频提利率市场化，由于利率市场化的推进是渐进的，由此带来的对银行传统盈利模式可持续性的质疑是长期因素，并不妨碍银行股中短期行情的演绎。此外，前期对行业资本和拨备监管标准过严的担忧目前有所缓和，已不构成利空。\n银行股行情仍可持续，关注中小银行\n本周银行股表现突出，尤其是中小银行大幅跑赢大盘。我们上周推出的本月组合（招行、浦发、华夏、南京）表现居前。在紧缩政策阶段性见顶预期下，本轮银行股的行情仍具备可持续性，理由在于：（1）作为本轮行情的催化因素的资金和政策环境向好且在本月可持续。（2）银行股低估值和超预期业绩是上涨的基石。（3）前期对资本和拨备监管过严的担忧有所缓和。（4）对资产质量和盈利模式的质疑是长期因素，不妨碍银行股走出中短期估值修复行情。需要密切跟踪的是作为催化剂的资金和政策面的变化。 \n";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B4C1A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B4C1A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController1";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"本周行业焦点";
    baFourData.baText.iPageIndex = 3;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFiveDataExtend *)create4_3Data{
    BAFiveDataExtend *baFiveData = [[BAFiveDataExtend alloc] init];
    
    baFiveData.imagedata.strPortraitImageName = @"InvationChapter4Por.png";
    baFiveData.imagedata.strLandscapeImageName = @"InvationChapter4Lan.png";
    baFiveData.imagedata.strTitle = @"章节首页";
    baFiveData.imagedata.iPageIndex = 5;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"行业动态评述\n本周对银行板块走势影响较大的因素有（1）农行发行价格预期较高（2）央行启动人民币汇率形成机制改革（3）公开市场操作维持宽松态势（4）汇金表态支持工行、中行、建行配股。对于前3 个因素，我们在近期报告中已进行提示和点评。我们维持前期观点，认为在农行上市前以及上市后的较短时期内，行业估值将继续受到一定支撑，银行板块较好的相对表现有望延续。\n本周央行在公开市场继续投放流动性，一周仅回笼货币100 亿元，而到期央票及正回购共计2110 亿元，从而累计净投放货币2010 亿元，再创春节后新高。至此，央行在公开市场已连续五周净投放，累计净投放资金达7160 亿元。灵活的公开市场操作一定程度上缓解了货币市场资金紧张局面，预计农行发行结束前，公开市场操作将继续保持宽松态势。\n在央行 19 日宣布进一步推进人民币汇率形成机制改革后，本周人民币汇率变动明显，银行间外汇市场美元对人民币汇率中间价收于1：6.7896，人民币较上周末升值0.56%。虽然在中期内，人民币汇率波动对于实体经济及流动性的影响尚难以定性判断，但在当前时点上，资本市场显然将其解读为正面因素。随着汇率改革的启动，预计5 月份游资大规模外流的趋势将有所改变；而国际资本的边际投资倾向和投资标的偏好决定了银行、地产等蓝筹行业更容易受到青睐。上述作用渠道可以部分解释市场的乐观情绪。\n6月23日银监会发布了《银行业金融机构国别风险管理指引》，要求银行业金融机构于2011 年6 月前完成对具有国别风险的资产的识别、风险计量及准备金计提。我们认为：（1）由于我国商业银行国际化程度较低，且金融危机后各行对相关资产均已计提了较为充足的拨备，《指引》对行业业绩影响极小；（2）预计境外股权和债权投资占比较高的国有大银行（如中行）受影响相对较大。\n央行： 本周央行在公开市场仅回笼货币100 亿元，而一周到期央票及正回购共计2110 亿元，从而累计净投放货币2010 亿元，再创春节后新高。3个月期及1 年期央票利率维持不变。\n人民币汇率： 6 月25 日银行间外汇市场美元对人民币汇率中间价为1：6.7896，人民币较上周末升值0.56%。\n外汇占款： 截至5 月底，我国外汇占款达204769.34 亿元，5 月新增外汇占款1315.64 亿元，较4 月份2800 多亿元的增量下降五成。\n银监会： 发布《银行业金融机构国别风险管理指引》办公厅副主任杨少俊表示，目前各商业银行对地方政府融资平台贷款的自查工作已陆续收尾，7 月上旬将上报至银监会；年底前，银监会将完成对地方政府融资平台贷款的清理规范工作。（ 中国证券报/2010.06.24）\n汇金公司： 发布公告称，已向建行提供以现金认购其配股股份的承诺函。并表示将积极支持工、中、建三行采取包括配股在内的再融资方式有序补充资本。\n审计署： 《关于2009 年度中央预算执行和其他财政收支的审计工作报告》指出，部分地方政府偿债压力较大，存在一定的债务风险。";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    KeyWord *key=[[KeyWord alloc]init];
    key.tag=1;
    key.Range=NSMakeRange(103, 4);
    NSArray *arrKeywords = [[NSArray alloc] initWithObjects:key, nil];
    baText.arrKeywords = arrKeywords;
    
    //landscape
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    
    //Portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    
    //图片名称
    NSString *strPicName = @"B4C2A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    NSString *strPicNamePor = @"B4C2A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController2";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFiveData.baText = baText;
    baFiveData.baText.strTitle = @"行业动态评述";
    baFiveData.baText.iPageIndex = 6;
    
    BAText *baText1 = [[BAText alloc] init];
    
    baText1.text = @"市场化利率\n本周货币市场利率大幅回落，短期回购利率跌至年内最低位，1 天/7 天/14 天/21 天/1 月回购利率分别回落75bp/94bp/334bp/210bp/49bp 至1.90%/2.21%/2.57%/3.00%/4.01%。银行间同业拆借利率1 天/7 天/14 天分别回落81bp/84bp/331bp。票据贴现利率亦有所回落，6 个月票据直贴/转帖利率较上周分别回落55bp/55bp 至5.45%/5.10% ";
    
    baText1.iTitleFontSize = 38;
    baText1.iTitleLength = 5;
    baText1.strTitlFontName = @"Helvetica";
    baText1.iContentFontSize = 14;
    baText1.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors1 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColors = arrAttributeColors1;
    NSArray *arrAttributeRanges1 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,6)), nil];
    baText1.arrAttributeRanges = arrAttributeRanges1;
    
    NSArray *arrAttributeColors1Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText1.arrAttributeColorsPor = arrAttributeColors1Por;
    NSArray *arrAttributeRanges1Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,6)), nil];
    baText1.arrAttributeRangesPor = arrAttributeRanges1Por;
    
    //横屏
    baText1.arrRects = [LeastTextNoAbstract setTextRect];
    baText1.arrPicRect = [LeastTextNoAbstract setImageRect];
    
    //portrait
    baText1.arrRectsPor = [LeastTextNoAbstractPor setTextRect];
    baText1.arrPicRectPor = [LeastTextNoAbstractPor setImageRect];
    
    //图片名称
    NSString *strPicName_1 = @"B4C2A2.png";
    NSArray *arrPicNames_1 = [[NSArray alloc] initWithObjects:strPicName_1,nil];
    baText1.arrPicNames = arrPicNames_1;
    
    NSString *strPicNamePor_1 = @"B4C2A2Por.png";
    NSArray *arrPicNamesPor_1 = [[NSArray alloc] initWithObjects:strPicNamePor_1,nil];
    baText1.arrPicNamesPor = arrPicNamesPor_1;
    
    //push Class
    NSString *pushClassName_1 = @"";
    NSArray *arrPSNamesPor_1 = [[NSArray alloc] initWithObjects:pushClassName_1,nil];
    baText1.arrPushClassNames = arrPSNamesPor_1;
    
    baFiveData.baText1 = baText1;
    baFiveData.baText1.strTitle = @"市场化利率";
    baFiveData.baText1.iPageIndex = 8;
    
    BAText *baText2 = [[BAText alloc] init];
    baText2.text = @"公开市场操作\n本周央票发行20 亿元，正回购400 亿，最终实现净投放1030 亿元；3 个月央行发行票据利率小幅上升1bp 至2.63%，因二级市场利率回落，目前央票一二级市场利率已接轨，其回笼功能将显现。1 年和3 年期央票一二级市场利差分别在30bp 和72bp。 ";
    baText2.iTitleFontSize = 38;
    baText2.iTitleLength = 6;
    baText2.strTitlFontName = @"Helvetica";
    baText2.iContentFontSize = 14;
    baText2.strContentFontName = @"Helvetica";
    
    //指定字体颜色和区域
    NSArray *arrAttributeColors2 = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText2.arrAttributeColors = arrAttributeColors2;
    NSArray *arrAttributeRanges2 = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText2.arrAttributeRanges = arrAttributeRanges2;
    
    NSArray *arrAttributeColors2Por = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText2.arrAttributeColorsPor = arrAttributeColors2Por;
    NSArray *arrAttributeRanges2Por = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText2.arrAttributeRangesPor = arrAttributeRanges2Por;
    
    //landscape
    baText2.arrRects = [LeastTextNoAbstract setTextRect];
    baText2.arrPicRect = [LeastTextNoAbstract setImageRect];
    
    baText2.arrRectsPor = [LeastTextNoAbstractPor setTextRect];
    baText2.arrPicRectPor = [LeastTextNoAbstractPor setImageRect];
    //图片名称
    NSString *strPicName_2 = @"B4C2A3.png";
    NSArray *arrPicNames_2 = [[NSArray alloc] initWithObjects:strPicName_2,nil];
    baText2.arrPicNames = arrPicNames_2;
    
    NSString *strPicNamePor_2 = @"B4C2A3Por.png";
    NSArray *arrPicNamesPor_2 = [[NSArray alloc] initWithObjects:strPicNamePor_2,nil];
    baText2.arrPicNamesPor = arrPicNamesPor_2;
    
    //push Class
    NSString *pushClassName_2 = @"";
    NSArray *arrPSNamesPor_2 = [[NSArray alloc] initWithObjects:pushClassName_2,nil];
    baText2.arrPushClassNames = arrPSNamesPor_2;
    
    baFiveData.baText2 = baText2;
    baFiveData.baText2.strTitle = @"公开市场操作";
    baFiveData.baText2.iPageIndex = 9;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFiveData.imagedata, baFiveData.baText, baFiveData.baText1, baFiveData.baText2, nil];
    baFiveData.arrPageData = arrPageData;
    
    return baFiveData;
}
+ (BAFourData *)create5_3Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"InvationChapter5Por.png";
    baFourData.imagedata.strLandscapeImageName = @"InvationChapter5Lan.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 10;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"公司跟踪\n工商银行： 办公室副主任谢泰峰表示，公司1-5 月新增贷款4554 亿元。此外，公司发放的地方政府融资平台贷款中没有打包贷款。（证券时报网/2010.06.21）\n据传，公司拟向中国五矿集团收购上海金盛人寿保险49%股权。近期已获批及拟入股保险公司的上市银行包括中国银行（中银保险）、交通银行（交银康联）、北京银行（首创安泰）及建设银行（太平洋安泰）等。（华夏时报、香港文汇报）\n建设银行： 汇金发出承诺函，承诺按持股比例以现金全额认购公司可配股票。截至10 年1 季度末，汇金持有公司股份总数的57.09%，上述承诺有助于公司再融资顺利完成，对公司股价也有一定的支撑作用。A 股及H 股配股方案获股东大会通过。\n交通银行： A 股配股有效认购数量为3,805,587,475 股， 认购金额为17,125,143,637.50 元，占可配股份总数的97.84%。董事长胡怀邦表示，公司将从探索船舶融资新途径、创新资金结算方式、设计开发汇率产品、为航运价格衍生产品提供配套服务等方面入手，大力发展航运金融。（金融界/2010.06.26）\n华夏银行： 推出国内第一张现金分期信用卡 “易达金卡”。（环球财经/2010.06.22）\n南京银行： 获江苏银监局批准筹建苏州分行。\n农业银行： 据悉，在公司 A 股IPO 初步询价中，机构报价中枢约2.70 元。（上海证券报/2010.06.25）\n上海银行： 上海市金融服务办公室主任方星海表示，今年将协调推进上海银行上市工作。（上海证券报/2010.06.23）\n深发展 ：行长理查德• 杰克逊表示，除向监管部门积极争取发行 65 亿混合\n宁波银行：业绩快报， 2010 年全年实现营业收入59.11 亿元，同比增长41.57%，营业利润26.66 亿元,同比增长52.13%，利润总额29.48 亿元，同比增长68.48%，归属母公司净利润23.24 亿元，同比增长59.47%，基本每股收益0.91 元，同比增长55.49%。 \n";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 4;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,5)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,5)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [MoreTextNoAbstract setTextRect];
    baText.arrPicRect = [MoreTextNoAbstract setImageRect];
    NSString *strPicName = @"B4C3A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [MoreTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [MoreTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B4C3A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"BFGraphViewController3";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"公司跟踪";
    baFourData.baText.iPageIndex = 11;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAFourData *)create6_3Data{
    BAFourData *baFourData = [[BAFourData alloc] init];
    
    baFourData.imagedata.strPortraitImageName = @"InvationChapter6Por.png";
    baFourData.imagedata.strLandscapeImageName = @"InvationChapter6Lan.png";
    baFourData.imagedata.strTitle = @"章节首页";
    baFourData.imagedata.iPageIndex = 12;
    
    BAText *baText = [[BAText alloc] init];
    baText.text = @"本期个股推荐\n观点：在宏观经济复苏和企业盈利恢复的大背景下，2010 年银行业经营基本面仍相对稳定。但受到房地产调控、融资平台清理、结构调整以及政策趋紧的影响，商业银行信用成本在下半年有上行压力。我们估算上述因素对银行业绩的负面影响在10%以内，保守测算2010 年上市银行合计的盈利增长15%。由于相关因素已持续被市场考虑并在估值上得到反映，我们仍维持行业“增持”评级。待相关问题渐趋明朗，过度悲观预期的修正会带来估值上升动力。未来行业估值回补动力来自：融资平台贷款清理结果好于预期；房地产市场软着陆；行业政策风险低于预期；股市资金面改善。\n个股推荐：大银行估值水平较上一周期底部已非常接近，短期将表现出较强的防御性；超跌的优质中型银行（浦发、招行、农业、民生、深发展）可择机在底部吸纳。\n本月投资组合：招行、浦发、华夏、南京\n推荐股公司点评：\n浦发银行 \n农业银行 \n";
    baText.iTitleFontSize = 38;
    baText.iTitleLength = 6;
    baText.strTitlFontName = @"Helvetica";
    baText.iContentFontSize = 14;
    baText.strContentFontName = @"Helvetica";
    //指定字体颜色和区域
    NSArray *arrAttributeColors = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColors = arrAttributeColors;
    
    NSArray *arrAttributeRanges = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRanges = arrAttributeRanges;
    
    NSArray *arrAttributeColorsPor = [[NSArray alloc] initWithObjects:[UIColor redColor], nil];
    baText.arrAttributeColorsPor = arrAttributeColorsPor;
    
    NSArray *arrAttributeRangesPor = [[NSArray alloc] initWithObjects:NSStringFromRange(NSMakeRange(0,7)), nil];
    baText.arrAttributeRangesPor = arrAttributeRangesPor;
    
    //文字位置
    //横屏
    baText.arrRects = [LeastTextNoAbstract setTextRect];
    baText.arrPicRect = [LeastTextNoAbstract setImageRect];
    NSString *strPicName = @"B4C4A1.png";
    NSArray *arrPicNames = [[NSArray alloc] initWithObjects:strPicName,nil];
    baText.arrPicNames = arrPicNames;
    
    //portrait
    baText.arrRectsPor = [LeastTextNoAbstractPor setTextRect];
    baText.arrPicRectPor = [LeastTextNoAbstractPor setImageRect];
    NSString *strPicNamePor = @"B4C4A1Por.png";
    NSArray *arrPicNamesPor = [[NSArray alloc] initWithObjects:strPicNamePor,nil];
    baText.arrPicNamesPor = arrPicNamesPor;
    
    //push Class
    NSString *pushClassName = @"";
    NSArray *arrPSNamesPor = [[NSArray alloc] initWithObjects:pushClassName,nil];
    baText.arrPushClassNames = arrPSNamesPor;
    
    baFourData.baText = baText;
    baFourData.baText.strTitle = @"本期个股推荐";
    baFourData.baText.iPageIndex = 13;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baFourData.imagedata, baFourData.baText, nil];
    baFourData.arrPageData = arrPageData;
    
    return baFourData;
}
+ (BAImagaNameData *)create8_3Data{
    BAImagaNameData *baImagaNameData = [[BAImagaNameData alloc] init];
    baImagaNameData.imagedata.strPortraitImageName = @"InvationChapter7Por.png";
    baImagaNameData.imagedata.strLandscapeImageName = @"InvationChapter7Lan.png";
    baImagaNameData.imagedata.strTitle = @"章节首页";
    baImagaNameData.imagedata.iPageIndex = 15;
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baImagaNameData.imagedata, nil];
    baImagaNameData.arrPageData = arrPageData;
    return baImagaNameData;
}
+ (BAThreeData *)create9_3Data{
    BAThreeData *baThreeData = [[BAThreeData alloc] init];
    baThreeData.imagedata.strPortraitImageName = @"InvationChapter8Por.png";
    baThreeData.imagedata.strLandscapeImageName = @"InvationChapter8Lan.png";
    baThreeData.imagedata.strTitle = @"章节首页";
    baThreeData.imagedata.iPageIndex = 16;
    
    baThreeData.arrButtonFrame = [[NSMutableArray alloc] init];
    NSString *strRect1 = NSStringFromCGRect(CGRectMake(49, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect1];
    NSString *strRect2 = NSStringFromCGRect(CGRectMake(378, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect2];
    NSString *strRect3 = NSStringFromCGRect(CGRectMake(707, 202, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect3];
    NSString *strRect4 = NSStringFromCGRect(CGRectMake(49, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect4];
    NSString *strRect5 = NSStringFromCGRect(CGRectMake(378, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect5];
    NSString *strRect6 = NSStringFromCGRect(CGRectMake(707, 433, 269, 191));
    [baThreeData.arrButtonFrame addObject:strRect6];
    
    baThreeData.arrButtonFramePor = [[NSMutableArray alloc] init];
    NSString *strRect1Por = NSStringFromCGRect(CGRectMake(87, 252, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect1Por];
    NSString *strRect2Por = NSStringFromCGRect(CGRectMake(415, 252, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect2Por];
    NSString *strRect3Por = NSStringFromCGRect(CGRectMake(87, 484, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect3Por];
    NSString *strRect4Por = NSStringFromCGRect(CGRectMake(415, 484, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect4Por];
    NSString *strRect5Por = NSStringFromCGRect(CGRectMake(87, 716, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect5Por];
    NSString *strRect6Por = NSStringFromCGRect(CGRectMake(415, 716, 269, 191));
    [baThreeData.arrButtonFramePor addObject:strRect6Por];
    
    baThreeData.arrButtonTag = [[NSMutableArray alloc] init];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 50]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 60]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 70]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 80]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 90]];
    [baThreeData.arrButtonTag addObject:[NSString stringWithFormat:@"%d", 100]];
    
    NSMutableArray *arrPageData = [[NSMutableArray alloc] initWithObjects:baThreeData.imagedata, nil];
    baThreeData.arrPageData = arrPageData;
    
    return baThreeData;
}

@end

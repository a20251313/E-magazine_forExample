//
//  getDataFromFile.m
//  E-magazine
//
//  Created by mike.sun on 6/18/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "getDataFromFile.h"
#import "chapterData.h"
#import "textData.h"
#import "pushClassNames.h"
#import "picNames.h"
#import "picNamesPor.h"
#import "picRects.h"
#import "picRectsPor.h"
#import "bgNames.h"
#import "bgNamesPor.h"
#import "bgRects.h"
#import "bgRectsPor.h"
#import "colors.h"
#import "ranges.h"
#import "colorsPor.h"
#import "rangesPor.h"
#import "rects.h"
#import "rectsPor.h"
#import "key.h"
#import "NewBannerText.h"
#import "NewBannerTextPor.h"
#import "NewLeastTextNoAbstract.h"
#import "NewLeastTextNoAbstractPor.h"
#import "NewLessTextNoAbstract.h"
#import "NewLessTextNoAbstractPor.h"
#import "NewMoreTextNoAbstract.h"
#import "NewMoreTextNoAbstractPor.h"

@implementation getDataFromFile

-(bookData*)getDocumentWithDictionary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"test.plist"];
    NSDictionary *dataDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    bookData *dataOfBook = [[bookData alloc] init];
    dataOfBook.bookName = [dataDictionary objectForKey:@"bookName"];
    dataOfBook.covorImage = [dataDictionary objectForKey:@"covorImage"];
    
    //chapterData
    NSMutableArray *sourceChapterDatas = [dataDictionary objectForKey:@"chapterData"];
    NSMutableArray *chapterDatas=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *sourceChapterData in sourceChapterDatas) {
        chapterData *chapterOfData = [[chapterData alloc] init];
        chapterOfData.chapterName = [sourceChapterData objectForKey:@"chapterName"];
        chapterOfData.chapterIndex = [sourceChapterData objectForKey:@"chapterIndex"];
        
        //textData;
        NSMutableArray *sourceTextDatas = [sourceChapterData objectForKey:@"textData"];
        NSMutableArray *textDatas=[[NSMutableArray alloc]init];
        for (NSMutableDictionary *sourceTextData in sourceTextDatas) {
            textData *dataOfText = [[textData alloc] init];
            dataOfText.title = [sourceTextData objectForKey:@"title"];
            dataOfText.text = [sourceTextData objectForKey:@"text"];
            dataOfText.titleFontSize = [sourceTextData objectForKey:@"titleFontSize"];
            dataOfText.titleFontName = [sourceTextData objectForKey:@"titleFontName"];
            dataOfText.titleLength = [sourceTextData objectForKey:@"titleLength"];
            dataOfText.contentFontSize = [sourceTextData objectForKey:@"contentFontSize"];
            dataOfText.contentFontName = [sourceTextData objectForKey:@"contentFontName"];
            
            //colors
            NSMutableArray *sourceColorsData = [sourceChapterData objectForKey:@"colors"];
            NSMutableArray *colorsData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceColorData in sourceColorsData) {
                colors *colorData = [[colors alloc]  init];
                colorData.color = [sourceColorData objectForKey:@"color"];
                [colorsData addObject:colorData];
            }
            dataOfText.colors = colorsData;
            
            //colorsPor
            NSMutableArray *sourceColorsPorData = [sourceChapterData objectForKey:@"colorsPor"];
            NSMutableArray *colorsPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceColorPorData in sourceColorsPorData) {
                colorsPor *colorPorData = [[colorsPor alloc]  init];
                colorPorData.colorPor = [sourceColorPorData objectForKey:@"colorPor"];
                [colorsPorData addObject:colorPorData];
            }
            dataOfText.colorsPor = colorsPorData;
            
            //ranges
            NSMutableArray *sourceRangesData = [sourceChapterData objectForKey:@"ranges"];
            NSMutableArray *rangesData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceRangeData in sourceRangesData) {
                ranges *rangeData = [[ranges alloc]  init];
                rangeData.range = [sourceRangeData objectForKey:@"range"];
                [rangesData addObject:rangeData];
            }
            dataOfText.ranges = rangesData;
            
            //rangesPor
            NSMutableArray *sourceRangesPorData = [sourceChapterData objectForKey:@"rangesPor"];
            NSMutableArray *rangesPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceRangePorData in sourceRangesPorData) {
                rangesPor *rangePorData = [[rangesPor alloc]  init];
                rangePorData.rangePor = [sourceRangePorData objectForKey:@"rangePor"];
                [rangesPorData addObject:rangePorData];
            }
            dataOfText.rangesPor = rangesPorData;
            
            //bgRects
            NSMutableArray *sourceBgRectsData = [sourceChapterData objectForKey:@"bgRects"];
            NSMutableArray *bgRectsData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceBgRectData in sourceBgRectsData) {
                bgRects *bgRectData = [[bgRects alloc]  init];
                bgRectData.bgRect = [sourceBgRectData objectForKey:@"bgRect"];
                [bgRectsData addObject:bgRectData];
            }
            dataOfText.bgRects = bgRectsData;
            
            //bgRectsPor
            NSMutableArray *sourceBgRectsPorData = [sourceChapterData objectForKey:@"bgRectsPor"];
            NSMutableArray *bgRectsPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceBgRectPorData in sourceBgRectsPorData) {
                bgRectsPor *bgRectPorData = [[bgRectsPor alloc]  init];
                bgRectPorData.bgRectPor = [sourceBgRectPorData objectForKey:@"bgRectPor"];
                [bgRectsPorData addObject:bgRectPorData];
            }
            dataOfText.bgRectsPor = bgRectsPorData;
            
            //bgNames
            NSMutableArray *sourceBgNamesData = [sourceChapterData objectForKey:@"bgNames"];
            NSMutableArray *bgNamesData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceBgNameData in sourceBgNamesData) {
                bgNames *bgNameData = [[bgNames alloc]  init];
                bgNameData.bgName = [sourceBgNameData objectForKey:@"bgName"];
                [bgNamesData addObject:bgNameData];
            }
            dataOfText.bgNames = bgNamesData;
            
            //bgNamesPor
            NSMutableArray *sourceBgNamesPorData = [sourceChapterData objectForKey:@"bgNamesPor"];
            NSMutableArray *bgNamesPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceBgNamePorData in sourceBgNamesPorData) {
                bgNamesPor *bgNamePorData = [[bgNamesPor alloc]  init];
                bgNamePorData.bgNamePor = [sourceBgNamePorData objectForKey:@"bgNamePor"];
                [bgNamesPorData addObject:bgNamePorData];
            }
            dataOfText.bgNamesPor = bgNamesPorData;
            
            //picRects
            NSMutableArray *sourcePicRectsData = [sourceChapterData objectForKey:@"picRects"];
            NSMutableArray *picRectsData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourcePicRectData in sourcePicRectsData) {
                picRects *picRectData = [[picRects alloc]  init];
                picRectData.picRect = [sourcePicRectData objectForKey:@"picRect"];
                [picRectsData addObject:picRectData];
            }
            dataOfText.picRects = picRectsData;
            
            //picRectsPor
            NSMutableArray *sourcePicRectsPorData = [sourceChapterData objectForKey:@"picRectsPor"];
            NSMutableArray *picRectsPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourcePicRectPorData in sourcePicRectsPorData) {
                picRectsPor *picRectPorData = [[picRectsPor alloc]  init];
                picRectPorData.picRectPor = [sourcePicRectPorData objectForKey:@"picRectPor"];
                [picRectsPorData addObject:picRectPorData];
            }
            dataOfText.picRectsPor = picRectsPorData;
            
            //picNames
            NSMutableArray *sourcePicNamesData = [sourceChapterData objectForKey:@"picNames"];
            NSMutableArray *picNamesData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourcePicNameData in sourcePicNamesData) {
                picNames *picNameData = [[picNames alloc]  init];
                picNameData.picName = [sourcePicNameData objectForKey:@"picName"];
                [picNamesData addObject:picNameData];
            }
            dataOfText.picNames = picNamesData;
            
            //picNamesPor
            NSMutableArray *sourcePicNamesPorData = [sourceChapterData objectForKey:@"picNamesPor"];
            NSMutableArray *picNamesPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourcePicNamePorData in sourcePicNamesPorData) {
                picNamesPor *picNamePorData = [[picNamesPor alloc]  init];
                picNamePorData.picNamePor = [sourcePicNamePorData objectForKey:@"picNamePor"];
                [picNamesPorData addObject:picNamePorData];
            }
            dataOfText.picNamesPor = picNamesPorData;
            
            //rects
            NSMutableArray *sourceRectsData = [sourceChapterData objectForKey:@"rects"];
            NSMutableArray *rectsData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceRectData in sourceRectsData) {
                rects *rectData = [[rects alloc]  init];
                rectData.rect = [sourceRectData objectForKey:@"rect"];
                [rectsData addObject:rectData];
            }
            dataOfText.rects = rectsData;
            
            //rectsPor
            NSMutableArray *sourceRectsPorData = [sourceChapterData objectForKey:@"rectsPor"];
            NSMutableArray *rectsPorData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceRectPorData in sourceRectsPorData) {
                rectsPor *rectPorData = [[rectsPor alloc]  init];
                rectPorData.rectPor = [sourceRectPorData objectForKey:@"rectPor"];
                [rectsPorData addObject:rectPorData];
            }
            dataOfText.rectsPor = rectsPorData;
            
            //key
            NSMutableArray *sourceKeysData = [sourceChapterData objectForKey:@"key"];
            NSMutableArray *keysData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourceKeyData in sourceKeysData) {
                key *keyData = [[key alloc]  init];
                keyData.tag = [sourceKeyData objectForKey:@"tag"];
                keyData.range = [sourceKeyData objectForKey:@"range"];
                [keysData addObject:keyData];
            }
            dataOfText.key = keysData;
            
            //pushClassNames
            NSMutableArray *sourcePushClassNamesData = [sourceChapterData objectForKey:@"pushClassNames"];
            NSMutableArray *pushClassNamesData=[[NSMutableArray alloc]init];
            for (NSMutableDictionary *sourcePushClassNameData in sourcePushClassNamesData) {
                pushClassNames *pushClassNameData = [[pushClassNames alloc]  init];
                pushClassNameData.pushClassName = [sourcePushClassNameData objectForKey:@"pushClassName"];
                [pushClassNamesData addObject:pushClassNameData];
            }
            dataOfText.pushClassNames = pushClassNamesData;
            
            [textDatas addObject:dataOfText];
        }
        chapterOfData.textData = textDatas;
        [chapterDatas addObject:chapterOfData];
    }
    dataOfBook.chapterData = chapterDatas;
    
    return dataOfBook;
}

@end

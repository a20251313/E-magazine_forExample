//
//  CustomUILabel.h
//  Test
//
//  Created by mac  on 13-1-24.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyWord.h"

@class CustomUILabel;

@protocol CustomUILabelDelegate<NSObject>

- (void)label:(CustomUILabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword;
- (void)label:(CustomUILabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword;
- (void)label:(CustomUILabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(KeyWord*)keyword;
- (void)label:(CustomUILabel*)label didCancelTouch:(UITouch*)touch;

@end

@interface CustomUILabel : UILabel
{
    NSMutableArray *ImageRects; //各种图片位置信息,需避开
}
@property (nonatomic, assign) id <CustomUILabelDelegate> delegate;
@property (nonatomic, retain)NSMutableArray *ImageRects;
@property (nonatomic, retain)NSMutableArray *KeyWords;
@property int linespec;
@property float totalTextHeight;
@property (nonatomic, retain)NSMutableAttributedString *attributedText;

-(void)addRect:(CGRect)_image;
-(void)addKeyWord:(KeyWord *)_keyword;
- (KeyWord*)characterIndexAtPoint:(CGPoint)point;//查看点击目标
-(void)InRange:(NSRange)range Hightlightornot:(BOOL)flg;

@end

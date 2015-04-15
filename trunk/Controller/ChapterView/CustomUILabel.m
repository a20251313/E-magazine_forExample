//
//  CustomUILabel.m
//  Test
//
//  Created by mac  on 13-1-24.
//  Copyright (c) 2013年 mac . All rights reserved.
//
#import<CoreText/CoreText.h>
#import "CustomUILabel.h"
#import "KeyWord.h"

@implementation CustomUILabel
@synthesize ImageRects,KeyWords,linespec,totalTextHeight,attributedText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        ImageRects=[[NSMutableArray alloc]init];
        KeyWords=[[NSMutableArray alloc]init];
        
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(void)addRect:(CGRect)_image
{
    [ImageRects addObject:[NSValue valueWithCGRect:_image ]];
}

-(void)addKeyWord:(KeyWord *)_keyword
{
    [KeyWords addObject:_keyword];
}

-(void)InRange:(NSRange)range Hightlightornot:(BOOL)flg
{
    if(flg){
        [self.attributedText addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:range];
    }else{
        [self.attributedText removeAttribute:NSBackgroundColorAttributeName range:range];
    }
}

- (KeyWord*)characterIndexAtPoint:(CGPoint)point {
    
    int currentIndex=0;
    int lineall=0;
    bool start=true;
    
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    for(int i=0;i<[ImageRects count];i++){//遍历方块,顺序写入
        CGRect re=[[ImageRects objectAtIndex:i]CGRectValue];//获取要写的rect
        lineall=0;
        while(start){//循环,直到没有字或者写满
            CFIndex lineLength=CTTypesetterSuggestLineBreak(typeSetter,currentIndex,re.size.width);
            CFRange lineRange=CFRangeMake(currentIndex, lineLength);
            CTLineRef line = CTTypesetterCreateLine(typeSetter,lineRange);
            
            if((point.y-re.origin.y)>lineall*linespec && (point.y-re.origin.y)<(lineall+1)*linespec){
                for(KeyWord *key in KeyWords){
                    if(key.Range.location>=currentIndex && key.Range.location<=currentIndex+lineLength){//key在本行中
                        CFIndex index=CTLineGetStringIndexForPosition(line,point);
                        if(index>key.Range.location && index<key.Range.location+key.Range.length){
                            return key;
                        }
                    }
                }
                
            }
            CFRelease(line);
            lineall++;
            //写完后判断
            if(currentIndex + lineLength >= [self.text length]){//文字写完
                start=false;
                break;//这样就会继续搜索方块,但是不会搜索文字
            }
            currentIndex=currentIndex+lineLength;
            if((lineall+1)*linespec>re.size.height){//方块写完
                break;
            }
        }
    }
    CFRelease(typeSetter);
    return nil;
    
}



#pragma mark --

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    KeyWord *keyword = [self characterIndexAtPoint:[touch locationInView:self]];
    
    [self.delegate label:self didBeginTouch:touch onCharacterAtIndex:keyword];
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    KeyWord *keyword = [self characterIndexAtPoint:[touch locationInView:self]];
    
    [self.delegate label:self didMoveTouch:touch onCharacterAtIndex:keyword];
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    KeyWord *keyword = [self characterIndexAtPoint:[touch locationInView:self]];
    
    [self.delegate label:self didEndTouch:touch onCharacterAtIndex:keyword];
    
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    [self.delegate label:self didCancelTouch:touch];
    
    [super touchesCancelled:touches withEvent:event];
}



-(void)drawTextInRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);//重置
    CGContextTranslateCTM(context,0,self.bounds.size.height); //y轴高度
    CGContextScaleCTM(context,1.0,-1.0);//y轴翻转
    
    
    int currentIndex=0;
    int lineall=0;
    bool start=true;
    
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    for(int i=0;i<[ImageRects count];i++){//遍历方块,顺序写入
        CGRect re=[[ImageRects objectAtIndex:i] CGRectValue];//获取要写的rect
        lineall=0;
        
        while(start){//循环,直到没有字或者写满
            CFIndex lineLength=CTTypesetterSuggestLineBreak(typeSetter,currentIndex,re.size.width);
            CFRange lineRange=CFRangeMake(currentIndex, lineLength);
            CTLineRef line = CTTypesetterCreateLine(typeSetter,lineRange);
            
            CGContextSetTextPosition(context,re.origin.x,self.frame.size.height-re.origin.y-(lineall+1)*linespec);
            lineall++;
            
            CTLineDraw(line,context);
            CFRelease(line);
            
            //写完后判断
            if(currentIndex + lineLength >= [self.text length]){//文字写完
                start=false;
                break;//这样就会继续搜索方块,但是不会搜索文字
            }
            currentIndex=currentIndex+lineLength;
            if((lineall+1)*linespec>re.size.height){//方块写完
                break;
            }
            
        }
    }
    
    CFRelease(typeSetter);
}

- (void)dealloc{
    self.ImageRects = nil;
    self.KeyWords = nil;
    self.attributedText = nil;
    //[super dealloc];
}

@end

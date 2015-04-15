#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import <CoreImage/CoreImage.h>

@interface TreemapViewCell ()
{
    
}
-(BOOL)calLabelSizeWithFontSize:(int)fontSize;
- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font;

@end

@implementation TreemapViewCell

@synthesize valueLabel;
@synthesize textLabel;
@synthesize index;
@synthesize delegate;
@synthesize scaleFactor;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];

        self.textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)] autorelease];
        textLabel.font = [UIFont boldSystemFontOfSize:20];
        textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];

        self.valueLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)] autorelease];
        valueLabel.font = [UIFont boldSystemFontOfSize:20];
        valueLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        valueLabel.textAlignment = UITextAlignmentCenter;
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        valueLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:valueLabel];
        
        scaleFactor = 1.0f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //origin function
    //textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20);
    //valueLabel.frame = CGRectMake(0, self.frame.size.height / 2 + 10, self.frame.size.width, 20);
    
    if (self.frame.size.width < 24 || self.frame.size.height < 24) {
        textLabel.alpha = 0;
        valueLabel.alpha = 0;
    }
    else
    {
        textLabel.alpha = 1;
        valueLabel.alpha = 1;
    }
    
    //iterator
    if (![self calLabelSizeWithFontSize:20]) {
        textLabel.alpha = 0;
        valueLabel.alpha = 0;
        
        //NSLog(@"%@ is alpha", textLabel.text);
    }    
    
    valueLabel.alpha = 0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    if (delegate && [delegate respondsToSelector:@selector(treemapViewCell:tapped:)]) {
        [delegate treemapViewCell:self tapped:index];
    }
}

- (void)dealloc {
    [valueLabel release];
    [textLabel release];
    [delegate release];

    [super dealloc];
}

//label字符排布算法，
//返回是否显示，no则将alpha设置为0
//需要提供这段字符串，font size（<16则视为无效）
//配给的宽度为cell宽度的80％
//没增加一行，文字font size-2
-(BOOL)calLabelSizeWithFontSize:(int)fontSize
{
    //16以下，不做计算
    if (fontSize < 8) {
        
        return NO;
    }

    CGSize cellSize = self.bounds.size;
    //计算lines
    int lines = (24 - fontSize) / 2 - 1;    //TOTOL LINES
    
    float width1 = [self widthOfString:textLabel.text withFont:[UIFont boldSystemFontOfSize:fontSize]];
    float width2 = [self widthOfString:textLabel.text withFont:[UIFont boldSystemFontOfSize:fontSize-4]];
    
    /*NSLog(@"now the scale is %f", scaleFactor);
    NSLog(@"fontSize is %d, 内容 is %@", fontSize, textLabel.text);
    NSLog(@"width1 = %f, width2 = %f", width1, width2);
    NSLog(@"the cell bounds is width: %f, height: %f", cellSize.width, cellSize.height);*/
    
    if(width1/lines <= cellSize.width*0.8 && ((fontSize + 4)* lines) <= cellSize.height*0.8)
    {
        
        textLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        valueLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        
        //NSLog(@"1------------%@", textLabel.text);
        
        //float singleLineWidth = ceilf(width1/(lines-1));
        
        //float gap = floorf((self.frame.size.width - singleLineWidth)/2);
        //textLabel.frame = CGRectMake(gap, self.frame.size.height / 2 - fontSize - 4 - ((fontSize+4)/2)*(lines-2) , singleLineWidth, (fontSize+4)*(lines-1));
        textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - fontSize - 4 - ((fontSize+4)/2)*(lines-2) , self.frame.size.width, (fontSize+4)*lines);
        valueLabel.frame = CGRectMake(0, self.frame.size.height / 2 + ((fontSize+4)/2)*(lines-2), self.frame.size.width, fontSize+4);
        return YES;
    }
    else if(width2/lines <= cellSize.width*0.9 && (fontSize * lines) <= cellSize.height*0.9)
    {
        
        textLabel.font = [UIFont boldSystemFontOfSize:(fontSize-4)];
        valueLabel.font = [UIFont boldSystemFontOfSize:(fontSize-4)];
        
        //NSLog(@"2------------%@", textLabel.text);
        
       // float singleLineWidth = ceilf(width2/(lines-1));
        
        //float gap = floorf((self.frame.size.width - singleLineWidth)/2);
        //textLabel.frame = CGRectMake(gap, self.frame.size.height / 2 - (fontSize-6) - 4 - (fontSize/2)*(lines-2) , singleLineWidth, (fontSize)*(lines-1));
        textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - (fontSize-6) - 4 - (fontSize/2)*(lines-2) , self.frame.size.width, (fontSize)*lines);
        valueLabel.frame = CGRectMake(0, self.frame.size.height / 2 + (fontSize/2)*(lines-2), self.frame.size.width, fontSize);
        return YES;
    }
    else
    {
        return [self calLabelSizeWithFontSize:(fontSize-2)];
    }

}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    if (NO) {
        //NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        //NSFontAttributeName for ios6
        //return [[[[NSAttributedString alloc] initWithString:string attributes:attributes] autorelease] size].width;
        return 0;
    }
    else {
        return [string sizeWithFont:font].width;
    }

    
}

@end

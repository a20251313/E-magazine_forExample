//
//  BaseAnnotationView.m
//  IRnovationBI
//
//  Created by 顾民 on 12-11-3.
//
//

#import "BaseAnnotationView.h"
#import "CAAnnotation.h"

@implementation BaseAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    //CAAnnotation *ann = (CAAnnotation*)self.annotation;
    
    if (selected) {
        rectView = [[UIImageView alloc] initWithFrame:[self bounds]];
        [rectView setImage:[UIImage imageNamed:@"000-04.png"]];
        
        [self animateCalloutAppearance2];
        [self addSubview:rectView];
    }
    else
    {
        [rectView removeFromSuperview];

    }
   
    
}


- (void)animateCalloutAppearance2
{
    CGFloat scale = 2.0f;
    rectView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 0.8f;
        rectView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 1.1;
            rectView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
        } completion:nil];
    }];
}

@end

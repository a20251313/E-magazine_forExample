//
//  BATouchView.h
//  IRnovationBI
//
//  Created by Yann on 12-12-10.
//
//

#import <UIKit/UIKit.h>

@interface BATouchView : UIView
@property (nonatomic,weak) id delegate;
@property float x;
@property float x2;
@property NSUInteger touchCount;
@end
@protocol BATouchViewDelegate <NSObject>

-(void)getTouchPointX;


@end
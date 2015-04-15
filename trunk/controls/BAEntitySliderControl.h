//
//  BAEntitySliderControl.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseControl.h"

@interface BAEntitySliderControl : BABaseControl
@property (nonatomic,strong) NMRangeSlider *slider;
-(NMRangeSlider*)configureEntitySliderControl;
- (void)changeEntity:(NMRangeSlider *)sender;
-(NMRangeSlider*)configureWithBounds:(CGRect)frame;
-(void)changeEntity:(float)lowerValue upperValue:(float)upperValue;
@end

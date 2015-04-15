//
//  NCInfoView.h
//  myMapDemo
//
//  Created by aplee on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCInfoView : UIView
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *cityName;
//@property (weak, nonatomic) IBOutlet UILabel *longitude;
//@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *extraInfo1;
@property (weak, nonatomic) IBOutlet UILabel *extraValue1;
@property (weak, nonatomic) IBOutlet UILabel *extraInfo2;
@property (weak, nonatomic) IBOutlet UILabel *extraValue2;

-(void)configue;

@end

//
//  CInfoView.h
//  myMapDemo
//
//  Created by aplee on 12-11-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CAAnnotation;

@protocol clusterBtnPress <NSObject>
@required
-(void)onRightBtnPress;


@end

@interface CInfoView : UIView
{
    id<clusterBtnPress> delegate;
}

@property (nonatomic, retain) id<clusterBtnPress> delegate;
@property (strong, nonatomic) IBOutlet UILabel *titleName;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
//@property (strong, nonatomic) IBOutlet UILabel *longitude;
//@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *extraInfo1;
@property (strong, nonatomic) IBOutlet UILabel *extraValue1;
@property (weak, nonatomic) IBOutlet UILabel *extraInfo2;
@property (weak, nonatomic) IBOutlet UILabel *extraValue2;

@property (nonatomic, readwrite) BOOL isRespond;

-(void)configue;
-(void)press;


@end

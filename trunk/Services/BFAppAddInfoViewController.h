//
//  BFAppAddInfoViewController.h
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAppAddInfoView.h"

@interface BFAppAddInfoViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>

@property (assign,nonatomic) id delegate;
@property(nonatomic ,strong) NSString *userName;
@property(nonatomic ,strong) BFAppAddInfoView *appAddInfo;

@end

@protocol BFAppAddInfoDelegate <NSObject>
-(void)dismissPostUserController;
@end

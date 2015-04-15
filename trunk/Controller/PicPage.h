//
//  PicPage.h
//  E-magazine
//
//  Created by mike.sun on 6/28/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicPage : UIView

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageNamePor;

-(void)changeFramesWhenRotate;
@end

//
//  BFScrollMenuView.h
//  E-magazine
//
//  Created by sunjian on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BFScrollMenuView : UIView<UIScrollViewDelegate>{
    
}

@property (strong, nonatomic) IBOutlet UILabel *menuInfoString;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;

@end

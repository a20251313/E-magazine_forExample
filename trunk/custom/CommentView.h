//
//  CommentView.h
//  Magazine
//
//  Created by mac  on 13-1-24.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHeaderViewDelegate.h"

@interface CommentView : UIView<UITextFieldDelegate>
{
    UITextField *comment;
}
@property (assign, nonatomic) id<BFHeaderViewDelegate> delegate;
@property (strong,nonatomic)UITextField *comment;
@end

//
//  BFMiniSearchView.h
//  E-magazine
//
//  Created by mike.sun on 3/22/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFHeaderViewDelegate.h"

@interface BFMiniSearchView : UIView

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fullButton;
@property (weak,nonatomic) id delegate;
@property (nonatomic, strong) NSMutableArray *arrPages;

- (void)setBtnDisable:(BOOL)bCanPre canNext:(BOOL)bCanNext;//bCanPre前一项按钮可点 bCanNext后一项按钮可点 iIndicator:2均可点

@end
@protocol BFMiniSearchDelegate <NSObject>
- (void)searchCancelAct;
- (void)miniSearchPrevSwitchAct;
- (void)miniSearchNextSwitchAct;
- (void)miniSearchFullAct;
@end

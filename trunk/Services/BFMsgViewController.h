//
//  BFMsgViewController.h
//  E-magazine
//
//  Created by summer.zhu on 5/29/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MsgDelegate;

@interface BFMsgViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate
>{
    IBOutlet UITableView *tableMsg;
}

@property(nonatomic, retain) NSMutableArray *arrData;
@property(nonatomic, retain) NSString *strMsgKey;
@property(nonatomic, assign) id<MsgDelegate> delegate;

- (void)addNewMsg:(NSMutableArray *)arrNewMsg;

@end

@protocol MsgDelegate <NSObject>

@optional
- (void)delegateMsg:(NSString *)strDelMsg;
- (void)delegateMsg_1:(NSString *)strDelMsg;

@end

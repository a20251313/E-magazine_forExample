//
//  BFFootView.h
//  BizFocus-periodical
//
//  Created by Yann on 13-1-23.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BFAppDelegate.h"
#import "BAScrollView.h"
#import "BookmarkObject.h"
#import "BFMiniSearchView.h"
#import "BFHeaderViewDelegate.h"
#import "BFMsgViewController.h"
#import "BFPageViewController.h"
#import "BACommentViewController.h"
#import "BFSearchWordViewController.h"
#import "PagesInChapterViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface BFHeaderView : UIView<BAScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,UIPrintInteractionControllerDelegate,UIPopoverControllerDelegate,UISearchBarDelegate,PagesInChapterDelegate,MsgDelegate>
{
    BookmarkObject *bookmark;
    BFMiniSearchView *miniSearchView;
    BFAppDelegate *del;
    BACommentViewController *commentController;
    BFSearchWordViewController *searchViewController;
    NSInteger actionMark;
    
    NSInteger addBookmarkButtonIndex;
    NSInteger viewBookmarkButtonIndex;
    
    NSInteger sendUrlButtonIndex;
    NSInteger printButtonIndex;
    NSInteger AddCollectIndex;
    
    UIWebView *webView;
    UIImageView *BGImageview;
    
    NSInteger iSelected;
    
    NSMutableArray *arrNewMsg;
    NSMutableArray *arrNewMsg_1;
}
@property (strong, nonatomic) NSString *strMsgKey;
@property (strong, nonatomic) NSString *strMsgKey_1;
@property (strong, nonatomic) IBOutlet UIButton *btnTitle;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imageviewTriangle;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UIButton *toolBtn;
@property (strong, nonatomic) IBOutlet UIButton *savedBookmarks;
@property (strong, nonatomic) IBOutlet UIButton *collectBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UIButton *btnMsg;
@property (strong, nonatomic) IBOutlet UIButton *btnMsg_1;
@property (strong, nonatomic) UIViewController *controller;
@property (strong, nonatomic) UIActionSheet *actionActionSheet;
@property (strong, nonatomic) UIActionSheet *actionActionSheet2;
@property (strong, nonatomic) UIPopoverController *bookmarkPopoverController;
@property (strong, nonatomic) UIPopoverController *addBookmarkPopoverController;
@property (strong, nonatomic) UIPopoverController *addCollectPopoverController;
@property (strong, nonatomic) UIPopoverController *searchWordPopoverController;
@property (strong, nonatomic) UIPopoverController *showNotePopoverController;
@property (strong, nonatomic) UIPrintInteractionController *printInteraction;
@property (strong, nonatomic) UIPopoverController *popoverPagesInChapter;
@property (strong, nonatomic) UIPopoverController *popoverPagesInChapter_1;
@property (assign, nonatomic) id<BFHeaderViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *arrSearchResult;
@property (strong, nonatomic) NSMutableArray *arrPagesData;
@property (strong, nonatomic) BFMiniSearchView *miniSearchView;
@property (strong, nonatomic) ViewControllerAndPage *curVcAndPage;

- (void)adjust;
- (void)loadMsgFromLocal;
- (void)loadMsgFromLocal_1;
- (void)reloadMsg:(NSArray *)arr;
- (void)reloadMsg_1:(NSArray *)arr;
- (void)loadTitle:(NSString *)strTitle;
- (void)changeMsgBtnFrame:(NSInteger)iNumber;
- (IBAction)didPressedBtnTitle:(id)sender;
- (void)refreshMiniSearchBtns:(ViewControllerAndPage *)vcAndPage;

- (IBAction)addBookMarkAndPrint:(UIButton *)sender;
- (IBAction)showHomeView:(UIButton *)sender;
- (IBAction)showContentMenu:(UIButton *)sender;
- (IBAction)gotoMyCollect:(UIButton*)sender;
- (IBAction)editSavedBookmarks:(UIButton *)sender;
- (IBAction)showNoteAndShare:(UIButton *)sender;
- (IBAction)searchKeyword:(UIButton *)sender;
- (IBAction)didPressedBtnMsg:(id)sender;
- (IBAction)didPressedBtnMsg_1:(id)sender;

- (void)doEditSavedBookmark:(UIButton *)sender;
- (void)doAddBookMarkAndPrint:(UIButton *)sender;
@end

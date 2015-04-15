//
//  BFFootView.m
//  BizFocus-periodical
//
//  Created by Yann on 13-1-23.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFHeaderView.h"
#import "AddBookmarkViewController.h"
#import "AddCollectMarkViewController.h"
#import "ViewBookmarkViewController.h"
#import "BFMiniSearchView.h"
#import "BFPageViewController.h"
#import "DataFactory.h"
#import "ViewControllerAndPage.h"

@implementation BFHeaderView
@synthesize strMsgKey;
@synthesize homeBtn;
@synthesize btnTitle;
@synthesize imageviewTriangle;
@synthesize delegate;
@synthesize menuBtn;
@synthesize toolBtn;
@synthesize shareBtn;
@synthesize savedBookmarks;
@synthesize collectBtn;
@synthesize searchBtn;
@synthesize btnMsg;
@synthesize btnMsg_1;
@synthesize actionActionSheet;
@synthesize actionActionSheet2;
@synthesize bookmarkPopoverController;
@synthesize addBookmarkPopoverController;
@synthesize addCollectPopoverController;
@synthesize searchWordPopoverController;
@synthesize showNotePopoverController;
@synthesize printInteraction;
@synthesize popoverPagesInChapter;
@synthesize popoverPagesInChapter_1;
@synthesize controller;
@synthesize arrSearchResult;
@synthesize arrPagesData;
@synthesize curVcAndPage;
@synthesize miniSearchView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self loadMsgFromLocal];
    [self loadMsgFromLocal_1];

    miniSearchView=[[[NSBundle mainBundle] loadNibNamed:@"BFMiniSearchView" owner:nil options:nil]lastObject];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        miniSearchView.frame=CGRectMake(0, 960, 768,44);
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        miniSearchView.frame=CGRectMake(0, 704, 1024,44);
    }
    miniSearchView.delegate = self;
    [self.controller.view addSubview:miniSearchView];
    miniSearchView.hidden = YES;
    miniSearchView.arrPages = ((BFPageViewController *)controller).arrPages;
}

- (void)loadMsgFromLocal{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefault objectForKey:self.strMsgKey];
    arrNewMsg = [[NSMutableArray alloc] initWithArray:arr];
    if (arrNewMsg.count == 0) {
        btnMsg.hidden = YES;
    }else{
        btnMsg.hidden = NO;
        NSInteger iMsgNumber = arrNewMsg.count;
        NSString *str = [NSString stringWithFormat:@"%d", iMsgNumber];
        [btnMsg setTitle:str forState:UIControlStateNormal];
    }
    [self changeMsgBtnFrame:arrNewMsg.count];
}
- (void)loadMsgFromLocal_1{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.strMsgKey_1 = [strMsgKey stringByAppendingFormat:@"_1"];
    NSArray *arr = [userDefault objectForKey:self.strMsgKey_1];
    arrNewMsg_1 = [[NSMutableArray alloc] initWithArray:arr];
    if (arrNewMsg_1.count == 0) {
        btnMsg_1.hidden = YES;
    }else{
        btnMsg_1.hidden = NO;
        NSInteger iMsgNumber = arrNewMsg_1.count;
        NSString *str = [NSString stringWithFormat:@"%d", iMsgNumber];
        [btnMsg_1 setTitle:str forState:UIControlStateNormal];
    }
    [self changeMsgBtnFrame_1:arrNewMsg_1.count];
}
- (void)reloadMsg:(NSArray *)arr{
    if (arr.count > 0) {
        btnMsg.hidden = NO;
        [arrNewMsg addObjectsFromArray:arr];
        NSInteger iMsgNumber = arrNewMsg.count;
        NSString *str = [NSString stringWithFormat:@"%d", iMsgNumber];
        [btnMsg setTitle:str forState:UIControlStateNormal];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:arrNewMsg forKey:self.strMsgKey];
        [userDefault synchronize];
        
        [self changeMsgBtnFrame:arrNewMsg.count];
    }
}
- (void)reloadMsg_1:(NSArray *)arr{
    if (arr.count > 0) {
        btnMsg_1.hidden = NO;
        [arrNewMsg_1 addObjectsFromArray:arr];
        NSInteger iMsgNumber = arrNewMsg_1.count;
        NSString *str = [NSString stringWithFormat:@"%d", iMsgNumber];
        [btnMsg_1 setTitle:str forState:UIControlStateNormal];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:arrNewMsg_1 forKey:self.strMsgKey_1];
        [userDefault synchronize];
        
        [self changeMsgBtnFrame:arrNewMsg_1.count];
    }
}

- (void)changeMsgBtnFrame:(NSInteger)iNumber{
    if (iNumber < 10) {
        CGRect rect = btnMsg.frame;
        rect.origin.x = 734;
        rect.size.width = 36;
        btnMsg.frame = rect;
        UIImage *image = [UIImage imageNamed:@"msg.png"];
        [btnMsg setBackgroundImage:image forState:UIControlStateNormal];
    }else if (iNumber >= 10 && iNumber < 100){
        CGRect rect = btnMsg.frame;
        rect.origin.x = 734-10;
        rect.size.width = 36+10;
        btnMsg.frame = rect;
        UIImage *image = [[UIImage imageNamed:@"msg.png"] stretchableImageWithLeftCapWidth:36 topCapHeight:0];
        [btnMsg setBackgroundImage:image forState:UIControlStateNormal];
    }else if (iNumber >= 100){
        CGRect rect = btnMsg.frame;
        rect.origin.x = 734-20;
        rect.size.width = 36+20;
        btnMsg.frame = rect;
        UIImage *image = [[UIImage imageNamed:@"msg.png"] stretchableImageWithLeftCapWidth:36 topCapHeight:0];
        [btnMsg setBackgroundImage:image forState:UIControlStateNormal];
    }
}
- (void)changeMsgBtnFrame_1:(NSInteger)iNumber{
    if (iNumber < 10) {
        CGRect rect = btnMsg_1.frame;
        rect.origin.x = 687;
        rect.size.width = 36;
        btnMsg_1.frame = rect;
        UIImage *image = [UIImage imageNamed:@"msg.png"];
        [btnMsg_1 setBackgroundImage:image forState:UIControlStateNormal];
    }else if (iNumber >= 10 && iNumber < 100){
        CGRect rect = btnMsg_1.frame;
        rect.origin.x = 687-10;
        rect.size.width = 36+10;
        btnMsg_1.frame = rect;
        UIImage *image = [[UIImage imageNamed:@"msg.png"] stretchableImageWithLeftCapWidth:36 topCapHeight:0];
        [btnMsg_1 setBackgroundImage:image forState:UIControlStateNormal];
    }else if (iNumber >= 100){
        CGRect rect = btnMsg_1.frame;
        rect.origin.x = 687-20;
        rect.size.width = 36+20;
        btnMsg_1.frame = rect;
        UIImage *image = [[UIImage imageNamed:@"msg.png"] stretchableImageWithLeftCapWidth:36 topCapHeight:0];
        [btnMsg_1 setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (IBAction)showHomeView:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(backToHome)]) {
        [delegate backToHome];
    }
}
- (IBAction)showContentMenu:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(showContent:)]) {
        [delegate showContent:menuBtn];
    }
}
- (IBAction)gotoMyCollect:(UIButton*)sender {
    if (delegate && [delegate respondsToSelector:@selector(showCollect:)]) {
        [delegate showCollect:collectBtn];
    }
}

- (IBAction)editSavedBookmarks:(UIButton *)sender {
    [self doEditSavedBookmark:savedBookmarks];
}
- (IBAction)addBookMarkAndPrint:(UIButton *)sender {
    [self doAddBookMarkAndPrint:shareBtn];
}
- (IBAction)showNoteAndShare:(UIButton *)sender {
    [self doShowNoteAndShare:toolBtn];
}
- (IBAction)searchKeyword:(UIButton *)sender {
    [self doSearchWord:searchBtn];
}
- (IBAction)didPressedBtnMsg:(id)sender{
    BFMsgViewController *msgVC = [[BFMsgViewController alloc] initWithNibName:@"BFMsgViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:msgVC];
    
    self.popoverPagesInChapter = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popoverPagesInChapter.popoverContentSize = CGSizeMake(300, 500);
    [self.popoverPagesInChapter presentPopoverFromRect:btnMsg.frame inView:controller.view permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    msgVC.strMsgKey = self.strMsgKey;
    [msgVC addNewMsg:arrNewMsg];
    msgVC.delegate = self;
}
- (IBAction)didPressedBtnMsg_1:(id)sender {
    BFMsgViewController *msgVC = [[BFMsgViewController alloc] initWithNibName:@"BFMsgViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:msgVC];
    
    self.popoverPagesInChapter_1 = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popoverPagesInChapter_1.popoverContentSize = CGSizeMake(300, 500);
    [self.popoverPagesInChapter_1 presentPopoverFromRect:btnMsg_1.frame inView:controller.view permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    msgVC.strMsgKey = self.strMsgKey_1;
    [msgVC addNewMsg:arrNewMsg_1];
    msgVC.delegate = self;
}

- (void)doEditSavedBookmark:(UIButton *)sender {
    actionMark = 2;
    if (!self.actionActionSheet2) {
        self.actionActionSheet2 = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        self.actionActionSheet2.actionSheetStyle = UIActionSheetStyleDefault;
        
        addBookmarkButtonIndex = [self.actionActionSheet2 addButtonWithTitle:@"添加书签"];
        viewBookmarkButtonIndex =  [self.actionActionSheet2 addButtonWithTitle:@"查看我的书签"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.actionActionSheet2.cancelButtonIndex = -1;
        } else {
            self.actionActionSheet2.cancelButtonIndex = [actionActionSheet2 addButtonWithTitle:@"Cancel"];
        }
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (actionActionSheet2.visible) {
            [actionActionSheet2 dismissWithClickedButtonIndex:actionActionSheet2.cancelButtonIndex
                                                     animated:YES];
        } else {
            [actionActionSheet2 showFromRect:sender.frame inView:self animated:YES];
        }
    }
    else {
        [actionActionSheet2 showInView:self];
    }
}
- (void)doAddBookMarkAndPrint:(UIButton *)sender {
    actionMark = 1;    
    if (printInteraction != nil) {
        [printInteraction dismissAnimated:YES];
        printInteraction = nil;
        return;
    }
    if (!self.actionActionSheet) {
        self.actionActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        self.actionActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        sendUrlButtonIndex = [self.actionActionSheet addButtonWithTitle:@"发送邮件"];
        printButtonIndex = [self.actionActionSheet addButtonWithTitle:@"打印"];
        AddCollectIndex =  [self.actionActionSheet addButtonWithTitle:@"添加到我的收藏"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.actionActionSheet.cancelButtonIndex = -1;
        } else {
            self.actionActionSheet.cancelButtonIndex = [actionActionSheet addButtonWithTitle:@"Cancel"];
        }
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (actionActionSheet.visible) {
            [actionActionSheet dismissWithClickedButtonIndex:actionActionSheet.cancelButtonIndex
                                                    animated:YES];
        } else {
            [actionActionSheet showFromRect:sender.frame inView:self animated:YES];
        }
    }
    else {
        [actionActionSheet showInView:self];
    }
}
- (void)doShowNoteAndShare:(UIButton *)sender {
    UITableViewController *tableViewController=[[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    tableViewController.tableView.delegate=self;
    tableViewController.tableView.dataSource=self;
    [showNotePopoverController dismissPopoverAnimated:YES];
    
    showNotePopoverController = [[UIPopoverController alloc] initWithContentViewController:tableViewController];
    showNotePopoverController.popoverContentSize=CGSizeMake(200, 120);
    [showNotePopoverController presentPopoverFromRect:sender.frame  inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    
}
-(void)doSearchWord:(UIButton *)sender{
    searchViewController=[[BFSearchWordViewController alloc] init];
    searchViewController.dicSearchSource = ((BFPageViewController *)controller).dicSearchDataSource;
    searchViewController.arrSearchKeys = ((BFPageViewController *)controller).arrSearchKey;
    [showNotePopoverController dismissPopoverAnimated:YES];
    searchViewController.arrPages = ((BFPageViewController *)controller).arrPages;
    searchViewController.delegate = self;
    searchWordPopoverController = [[UIPopoverController alloc] initWithContentViewController:searchViewController];
    searchWordPopoverController.popoverContentSize=CGSizeMake(543, 262+44);
    [searchWordPopoverController presentPopoverFromRect:sender.frame  inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
}
#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionMark == 1) {
        if (sendUrlButtonIndex == buttonIndex) {
            [self sendMail];
        }
        if (printButtonIndex == buttonIndex) {
            [self printCurrentView];
        }
        if (AddCollectIndex == buttonIndex) {
            [self addCollectmark];
        }
        
    }
    else{
        if (addBookmarkButtonIndex == buttonIndex) {
            [self addBookmark];
        }
        if (viewBookmarkButtonIndex == buttonIndex) {
            [self viewBookmark];
        }
        
    }
}
- (void)addBookmark {
    AddBookmarkViewController * addBookmarkViewController = [[AddBookmarkViewController alloc] initWithStyle:UITableViewStyleGrouped];
    addBookmarkViewController.strBookMark = ((BFPageViewController *) controller).bookMarksStr;
    del = (BFAppDelegate *)[[UIApplication sharedApplication] delegate];
    [addBookmarkViewController setBookmark:del.titleStr andNumber:[NSString stringWithFormat:@"%d",del.numberOfPage]];
    addBookmarkViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addBookmarkViewController];
    
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.addBookmarkPopoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
        self.addBookmarkPopoverController.popoverContentSize = CGSizeMake(320.0, 150.0);
        [self.addBookmarkPopoverController presentPopoverFromRect:savedBookmarks.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    } else {
        [controller presentViewController:navController animated:YES completion:nil];
    }
}
- (void)viewBookmark {
    ViewBookmarkViewController * viewBookmarkViewController = [[ViewBookmarkViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewBookmarkViewController.strBookMark = ((BFPageViewController *) controller).bookMarksStr;
    viewBookmarkViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewBookmarkViewController];
    
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.bookmarkPopoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
        self.bookmarkPopoverController.popoverContentSize=CGSizeMake(320, 500);
        
        [self.bookmarkPopoverController presentPopoverFromRect:savedBookmarks.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    } else {
        [controller presentViewController:navController animated:YES completion:nil];
    }
    
}
- (void)sendMail {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if ((mailClass != nil)&&[mailClass canSendMail]) {
        UIGraphicsBeginImageContext(controller.view.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [controller.view.layer renderInContext:context];
        UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        NSData *imageData = UIImagePNGRepresentation(theImage);
        [mailViewController addAttachmentData: imageData mimeType: @"" fileName: @"screenshot.png"];
        NSString *emailBody = @"";
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            mailViewController.modalPresentationStyle = UIModalPresentationPageSheet;
        }
        [mailViewController setMessageBody:emailBody isHTML:YES];
        [controller presentViewController:mailViewController animated:YES completion:nil];
    }
    else{
        UIAlertView *mailAlertView = [[UIAlertView alloc] initWithTitle:@"无邮箱帐户" message:@"尚未配置邮箱帐户。\n您可在“设置”中添加或\n创建微博账号" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"取消", nil];
        [mailAlertView show];
    }
}
- (void)printCurrentView {
    Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");
    
    if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
    {
        NSURL *fileURL = [NSURL URLWithString:@"123"];
        printInteraction = [printInteractionController sharedPrintController];
        printInteraction.delegate = self;
        
        UIPrintInfo *printInfo = [NSClassFromString(@"UIPrintInfo") printInfo];
        
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"Apple";
        
        printInteraction.printInfo = printInfo;
        printInteraction.showsPageRange = YES;
        printInteraction.printingItem = fileURL;
        
        UIViewPrintFormatter *formatter = [webView viewPrintFormatter];
        printInteraction.printFormatter = formatter;
        
        [printInteraction presentFromRect:shareBtn.frame inView:controller.view animated:YES completionHandler:^(UIPrintInteractionController *pic, BOOL completed, NSError *error)
         {
             if ((completed == NO) && (error != nil)) NSLog(@"%s %@", __FUNCTION__, error);
         }
         ];
    }
    else // Presume UIUserInterfaceIdiomPhone
    {
        [printInteraction presentAnimated:YES completionHandler:
         ^(UIPrintInteractionController *pic, BOOL completed, NSError *error)
         {
             if ((completed == NO) && (error != nil)) NSLog(@"%s %@", __FUNCTION__, error);
         }
         ];
    }
}
- (void)addCollectmark {
    AddCollectMarkViewController * addCollectmarkViewController = [[AddCollectMarkViewController alloc] initWithStyle:UITableViewStyleGrouped];
    addCollectmarkViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addCollectmarkViewController];
    
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.addCollectPopoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
        self.addCollectPopoverController.popoverContentSize = CGSizeMake(320.0, 150.0);
        [self.addCollectPopoverController presentPopoverFromRect:shareBtn.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
    } else {
        [controller presentViewController:navController animated:YES completion:nil];
    }
}

#pragma mark - msgdelegate
- (void)delegateMsg:(NSString *)strDelMsg{
    [arrNewMsg removeLastObject];
    NSInteger iMsgLeft = arrNewMsg.count;
    if (iMsgLeft > 0) {
        NSString *str = [NSString stringWithFormat:@"%d", iMsgLeft];
        [btnMsg setTitle:str forState:UIControlStateNormal];
        [self changeMsgBtnFrame:iMsgLeft];
    }else{
        btnMsg.hidden = YES;
        [self.popoverPagesInChapter dismissPopoverAnimated:YES];
    }
}
- (void)delegateMsg_1:(NSString *)strDelMsg{
    [arrNewMsg_1 removeLastObject];
    NSInteger iMsgLeft = arrNewMsg_1.count;
    if (iMsgLeft > 0) {
        NSString *str = [NSString stringWithFormat:@"%d", iMsgLeft];
        [btnMsg_1 setTitle:str forState:UIControlStateNormal];
        [self changeMsgBtnFrame_1:iMsgLeft];
    }else{
        btnMsg_1.hidden = YES;
        [self.popoverPagesInChapter_1 dismissPopoverAnimated:YES];
    }
}

- (void)loadTitle:(NSString *)strTitle{
    CGSize size = [strTitle sizeWithFont:[UIFont boldSystemFontOfSize:22.0] constrainedToSize:CGSizeMake(530, 44) lineBreakMode:UILineBreakModeCharacterWrap];
    [btnTitle setTitle:strTitle forState:UIControlStateNormal];
    CGFloat x_imageViewTriangle;
    CGFloat x_btnTitle;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        x_imageViewTriangle = 768/2 + size.width/2+15;
        x_btnTitle = 768/2 - size.width/2;
    }
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        x_imageViewTriangle = 1024/2 + size.width/2+15;
        x_btnTitle = 1024/2 - size.width/2;
    }
    
    CGRect rectBtnTitle = CGRectMake(x_btnTitle-50, btnTitle.frame.origin.y, size.width+imageviewTriangle.frame.size.width+15, btnTitle.frame.size.height);
    btnTitle.frame = rectBtnTitle;
    
    CGRect rect = imageviewTriangle.frame;
    rect.origin.x = x_imageViewTriangle-50;
    imageviewTriangle.frame = rect;
}

- (IBAction)didPressedBtnTitle:(id)sender{
    PagesInChapterViewController *pagesInChapter = [[PagesInChapterViewController alloc] initWithNibName:@"PagesInChapterViewController" bundle:nil];
    pagesInChapter.delegate = self;
    
    NSMutableArray *arrTitles = [[NSMutableArray alloc] init];
    for (int i=0; i<self.arrPagesData.count; i++) {
        BAPageData *pageData = (BAPageData *)[self.arrPagesData objectAtIndex:i];
        [arrTitles addObject:pageData.strTitle];
    }
    pagesInChapter.arrPages = arrTitles;//[[NSMutableArray alloc] initWithObjects:@"1", @"2", nil];//
    if (popoverPagesInChapter != nil) {
        self.popoverPagesInChapter = nil;
    }
    self.popoverPagesInChapter = [[UIPopoverController alloc] initWithContentViewController:pagesInChapter];
    self.popoverPagesInChapter.popoverContentSize = CGSizeMake(320.0, 300.0);
    [self.popoverPagesInChapter presentPopoverFromRect:btnTitle.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - PagesInChapterDelegate 点击title跳转到相应的文章
- (void)didSelectedRow:(NSInteger)iRow{
    BAPageData *pageData = (BAPageData *)[self.arrPagesData objectAtIndex:iRow];
    if ([self.delegate respondsToSelector:@selector(selectPageInChapter:)]) {
        [self.delegate selectPageInChapter:pageData.iPageIndex];
    }
    
    [popoverPagesInChapter dismissPopoverAnimated:YES];
}

#pragma mark -
#pragma mark MFMailComposeViewController delegates
- (void)mailComposeController:(MFMailComposeViewController *)controller01 didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [controller dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送";
            [BAGeneralTools showMsg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
}

#pragma mark -
#pragma mark UIPrintInteractionControllerDelegate
- (void)printInteractionControllerDidDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"printInteractionControllerDidDismissPrinterOptions");
    printInteraction = nil;
}
#pragma mark - Bookmark delegates
- (void)dismissViewBookmMarkViewController:(ViewBookmarkViewController *)viewController {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.bookmarkPopoverController dismissPopoverAnimated:YES];
    } else {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - ViewBookmarkDelegate delegates
- (void)scrollViewToIndex:(int)iControllerIndex{
    [delegate comeToController:iControllerIndex];
}

#pragma mark addBookmark delegates
- (void)dismissAddBookmMarkViewController:(AddBookmarkViewController *)viewController {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.addBookmarkPopoverController dismissPopoverAnimated:YES];
    } else {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark -
#pragma mark seachWord delegates
- (void)dismissViewSearchWordViewController:(BFSearchWordViewController *)viewController{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.searchWordPopoverController dismissPopoverAnimated:YES];
    } else {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark UITableView delegates&&datasources
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
#pragma mark - searchviewdelegate 点击搜索列表
- (void)scrollViewToIndex2:(NSInteger)iRow{   
    iSelected = iRow;
    
    self.arrSearchResult = searchViewController.switchDataArray;
    
    ViewControllerAndPage *vcAndPage = (ViewControllerAndPage *)[self.arrSearchResult objectAtIndex:iRow];
    if ([self.delegate respondsToSelector:@selector(comeToIndexView:)]) {
        [self.delegate comeToIndexView:vcAndPage];
    }
    
    [self refreshMiniSearchBtns:vcAndPage];
}
- (void)showMiniSearchView{
    miniSearchView.hidden = NO;    
}

#pragma mark - miniSearch delegates 上一项，下一项
- (void)searchCancelAct{
    miniSearchView.hidden = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"markWord"];
}
- (void)miniSearchPrevSwitchAct{
    iSelected = iSelected - 1;
    if (self.arrSearchResult.count > 1) {
        curVcAndPage = (ViewControllerAndPage *)[self.arrSearchResult objectAtIndex:iSelected];
        [self refreshMiniSearchBtns:curVcAndPage];
        ViewControllerAndPage *vcAndPage = (ViewControllerAndPage *)[self.arrSearchResult objectAtIndex:iSelected];
        [delegate miniSearchPrevSwitch:vcAndPage];
    }
}
- (void)miniSearchNextSwitchAct{
    iSelected = iSelected + 1;
    
    if (self.arrSearchResult.count > 1) {
        curVcAndPage = (ViewControllerAndPage *)[self.arrSearchResult objectAtIndex:iSelected];
        [self refreshMiniSearchBtns:curVcAndPage];
        ViewControllerAndPage *vcAndPage = (ViewControllerAndPage *)[self.arrSearchResult objectAtIndex:iSelected];
        [delegate miniSearchPrevSwitch:vcAndPage];
    }
}
-(void)miniSearchFullAct{
    [self doSearchWord:searchBtn];
}

- (void)refreshMiniSearchBtns:(ViewControllerAndPage *)vcAndPage{
    for (int i=0; i<arrSearchResult.count; i++) {
        ViewControllerAndPage *vcAndPageTemp = (ViewControllerAndPage *)[arrSearchResult objectAtIndex:i];
        if ([vcAndPageTemp.viewControllerIndex isEqualToString:vcAndPage.viewControllerIndex] &&
            [vcAndPageTemp.pageIndex isEqualToString:vcAndPage.pageIndex]) {
            iSelected = i;
            self.curVcAndPage = vcAndPage;
            //控制前一下按钮，后一项按钮是否可点
            BOOL bCanPre = YES;
            BOOL bCanNext = YES;
            if (self.arrSearchResult.count > 1) {
                if (iSelected == 0) {
                    bCanPre = NO;
                }
                if (iSelected == self.arrSearchResult.count-1) {
                    bCanNext = NO;
                }
            }else{
                bCanPre = NO;
                bCanNext = NO;
            }
            [miniSearchView setBtnDisable:bCanPre canNext:bCanNext];
            break;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *title;
    switch (indexPath.row) {
        case 0:
        {
            title=@"注释并共享";
        }
            break;
        default:
            title=@"";
            break;
    }
    
    [[cell textLabel] setText:title];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [showNotePopoverController dismissPopoverAnimated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIGraphicsBeginImageContext(controller.view.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [controller.view.layer renderInContext:context];
            UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            commentController=[[BACommentViewController alloc]initWithImage:theImage ];
            [self.controller presentViewController:commentController animated:NO completion:nil];
        }
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
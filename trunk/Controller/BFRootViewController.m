//
//  BFRootViewController.m
//  E-magazine
//
//  Created by zhonghao zhang on 1/29/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFRootViewController.h"
#import "BADefinition.h"
#import "NewDataFactory.h"
#import "DataFactory.h"
#import "BookCover.h"
#import "bookData.h"
#import "OCReflection.h"

@interface BFRootViewController ()
{
    UIActivityIndicatorView *progressInd;
}

- (void)initBookData:(NSString *)strIndex;
@end

@implementation BFRootViewController
@synthesize BackGroundView;
@synthesize arrBookMarksStr;
@synthesize arrMsgKey;
@synthesize arrViewsIndex;
@synthesize arrViewsAtIndex;
@synthesize arrTitles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - Life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    if (IOS7ANDLATER)
    {
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            self.BackGroundView.frame=CGRectMake(0,22, 768, 1024-22);
            self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf00.png"]];
            tableviewBook.frame = CGRectMake(0,54+22, 768, 1024-54-22);
        }
        else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            self.BackGroundView.frame=CGRectMake(0,22, 1024, 748-22);
            self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf01.png"]];
            tableviewBook.frame = CGRectMake(0,54+22, 1024, 748-54-22);
        }
        
        [tableviewBook setBackgroundColor:[UIColor clearColor]];
      //  [tableviewBook setBackgroundColor:[UIView new]];
        
    }else
    {
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            self.BackGroundView.frame=CGRectMake(0,0, 768, 1004);
            self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf00.png"]];
            tableviewBook.frame = CGRectMake(0,54, 768, 1004-54);
            
           
        }
        else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            self.BackGroundView.frame=CGRectMake(0,0, 1024, 748);
            self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf01.png"]];
            tableviewBook.frame = CGRectMake(0,54, 1024, 748-54);
        }
    
    }
   
    [tableviewBook reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrDataBook = [[NSMutableArray alloc] init];
    arrBookMarksStr = [[NSMutableArray alloc] init];
    arrMsgKey = [[NSMutableArray alloc] init];
    arrViewsIndex = [[NSMutableArray alloc] init];
    arrViewsAtIndex = [[NSMutableArray alloc] init];
    arrTitles = [[NSMutableArray alloc] init];
    
    //初始化书籍
    BookCover *bookCover = [[BookCover alloc] init];
    bookCover.strBookName = @"能化周刊3月刊";
    bookCover.strBookImageName = @"Book01.png";
    NSMutableArray *arrBook1 = [[NSMutableArray alloc] initWithObjects:bookCover, nil];
    
    BookCover *bookCover1 = [[BookCover alloc] init];
    bookCover1.strBookName = @"2012年度报告";
    bookCover1.strBookImageName = @"Book02.png";
    NSMutableArray *arrBook2 = [[NSMutableArray alloc] initWithObjects:bookCover1, nil];
    
    BookCover *bookCover2 = [[BookCover alloc] init];
    bookCover2.strBookName = @"消费信贷市场";
    bookCover2.strBookImageName = @"Book03.png";
    NSMutableArray *arrBook3 = [[NSMutableArray alloc] initWithObjects:bookCover2, nil];
    
    BookCover *bookCover3 = [[BookCover alloc] init];
    bookCover3.strBookName = @"投资分析周报";
    bookCover3.strBookImageName = @"Book04.png";
    NSMutableArray *arrBook4 = [[NSMutableArray alloc] initWithObjects:bookCover3, nil];
    
    [arrDataBook addObject:arrBook2];
    [arrDataBook addObject:arrBook3];
    [arrDataBook addObject:arrBook4];
    [arrDataBook addObject:arrBook1];
    
    [self.BackGroundView addSubview:tableviewBook];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - GridViewRowDelegate
- (void)didPressedGrid:(Position *)pos{
    AppDelegateEntity.activityView.hidden = NO;
    [AppDelegateEntity.activityView startAnimating];
    NSInteger iIndex = pos.iRow*1+(pos.iCol+1)-1;
    NSString *strIndex = [NSString stringWithFormat:@"%d",  iIndex];
    [self performSelector:@selector(initBookData:) withObject:strIndex afterDelay:0.0];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrDataBook.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 232;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"UIGridViewRowIndentifier";
    UIGridViewRow *cell = (UIGridViewRow *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"UIGridViewRow" owner:self options:nil];
        for (id nib in nibs) {
            if ([nib isKindOfClass:[UIGridViewRow class]]) {
                cell = nib;
            }
        }
    }
    
    NSString *strImage = @"";
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        strImage = @"landscapeShell.png";
    }
    else if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        strImage = @"PortraitShell.png";
    }
    
    
    [cell setBackgroundColor:[UIColor clearColor]];
    UIView  *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    [cell setBackgroundView:bgView];
    
    cell.imageViewShell.image = [UIImage imageNamed:strImage];
    cell.arrBooks = [arrDataBook objectAtIndex:indexPath.row];
    cell.iRow = indexPath.row;
    cell.delegate = self;
    
    return cell;
}

- (void)initBookData:(NSString *)strIndex{
    bookData *data;
    if ([strIndex isEqualToString:@"0"]) {
        data = [NewDataFactory createBook1];
    }
    if ([strIndex isEqualToString:@"1"]) {
        data = [NewDataFactory createBook2];
    }
    if ([strIndex isEqualToString:@"2"]) {
        data = [NewDataFactory createBook3];
    }
    if ([strIndex isEqualToString:@"3"]) {
        data = [NewDataFactory createBook4];
    }
    NSDictionary *dic = [OCReflection getDictionaryFromClass:data];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"test.plist"];
    [dic writeToFile:filePath atomically:YES];
        
    NSInteger iIndex = [strIndex integerValue];
    BFPageViewController *pageView=[[BFPageViewController alloc] initWithNibName:@"BFPageViewController" bundle:nil];
    pageView.bookData = [DataFactory createBookData:iIndex];
    
    [self presentModalViewController:pageView animated:YES];
}

///ios 5.0
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.BackGroundView.frame=CGRectMake(0,0, 768, 1004);
        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf00.png"]];
        tableviewBook.frame=CGRectMake(0,54, 768, 1004-54);
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.BackGroundView.frame=CGRectMake(0,0, 1024, 748);
        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf01.png"]];
        tableviewBook.frame=CGRectMake(0,54, 1024, 748-54);
    }
    [tableviewBook reloadData];

    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation)||UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

///ios 6.0
-(BOOL)shouldAutorotate{
//    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
//        self.BackGroundView.frame=CGRectMake(0,0, 768, 1004);
//        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf00.png"]];
//        tableviewBook.frame=CGRectMake(0,54, 768, 1004-54);
//    }
//    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
//        self.BackGroundView.frame=CGRectMake(0,0, 1024, 748);
//        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf01.png"]];
//        tableviewBook.frame=CGRectMake(0,54, 1024, 748-54);
//    }
//    [tableviewBook reloadData];

    return YES;
}

///ios 6.0
-(NSUInteger)supportedInterfaceOrientations{
//    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
//        self.BackGroundView.frame=CGRectMake(0,0, 768, 1004);
//        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf00.png"]];
//        tableviewBook.frame=CGRectMake(0,54, 768, 1004-54);
//    }
//    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
//        self.BackGroundView.frame=CGRectMake(0,0, 1024, 748);
//        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf01.png"]];
//        tableviewBook.frame=CGRectMake(0,54, 1024, 748-54);
//    }
//    [tableviewBook reloadData];

    return UIInterfaceOrientationMaskAll;
}

///ios 6.0 && 5.0
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
}

///ios 6.0 && 5.0
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        self.BackGroundView.frame=CGRectMake(0,0, 768, 1004);
        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf00.png"]];
        tableviewBook.frame=CGRectMake(0,54, 768, 1004-54);
    }
    else if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
        self.BackGroundView.frame=CGRectMake(0,0, 1024, 748);
        self.BackGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelf01.png"]];
        tableviewBook.frame=CGRectMake(0,54, 1024, 748-54);
    }
    [tableviewBook reloadData];

}

///ios 5.0
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
}

@end

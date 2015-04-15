//
//  ArticleListViewController.m
//  HorizontalTables
//
//  Created by Felipe Laso on 8/6/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ControlVariables.h"
#import "HorizontalTableCell.h"
#define kHeadlineSectionHeight  34
#define kRegularSectionHeight   24

@implementation ArticleListViewController
@synthesize customTable;
@synthesize articleDictionary;
@synthesize sortedCategories;
#pragma mark - View Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"smart report";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.view.frame=CGRectMake(0,0, 768, 1004);
        self.customTable = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 1004)] autorelease];
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.view.frame=CGRectMake(0,0, 1024, 748);
        self.customTable = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)] autorelease];
    }

    [self.customTable setBackgroundColor:kVerticalTableBackgroundColor];
    self.customTable.rowHeight = kCellHeight_iPad + (kRowVerticalPadding_iPad * 0.5) + ((kRowVerticalPadding_iPad * 0.5) * 0.5);
    self.customTable.delegate = self;
    self.customTable.dataSource = self;
    [self.view addSubview:self.customTable];
    
    del = (BFAppDelegate *)[[UIApplication sharedApplication] delegate];
    del.selectedDataAll = [[NSMutableDictionary alloc] init];
    backButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAct)];
    editButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:  UIBarButtonSystemItemTrash  target:self action:@selector(editAct)];
    cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:  UIBarButtonSystemItemCancel  target:self action:@selector(cancelAct)];
    deleteButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:  UIBarButtonSystemItemDone  target:self action:@selector(deleteAct)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = editButton;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"Articles.plist"];
    
    self.articleDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    self.sortedCategories = [self.articleDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

-(void)backAct{
    del.selectedMark = @"not delete state";
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)editAct{
    self.navigationItem.rightBarButtonItem = cancelButton;
    self.navigationItem.leftBarButtonItem =  deleteButton;
    del.selectedMark = @"delete state";
    self.title = @"请选择内容";
}
-(void)deleteAct{
    for (id aKey in [del.selectedDataAll allKeys]) {
        NSMutableArray *temp = [[[NSMutableArray alloc]initWithArray:[self.articleDictionary objectForKey:aKey]] autorelease];
        for (NSDictionary *aDic in [del.selectedDataAll objectForKey:aKey]) {
            [temp removeObject:[[self.articleDictionary objectForKey:aKey] objectAtIndex:[[[aDic allKeys] objectAtIndex:0] integerValue]]];
        }
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"Articles.plist"];
        NSMutableDictionary *applist = [[[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy] autorelease];
        [applist removeObjectForKey:aKey];
        if ([temp count]!=0) {
            [applist setValue:temp forKey:aKey];
        }
        [applist writeToFile:path atomically:YES];
    }
    [self viewDidLoad];
    [self.customTable reloadData];
    
    self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.leftBarButtonItem =  backButton;
    del.selectedMark = @"not delete state";
    self.title = @"我的E-magazine收藏";
}
-(void)cancelAct{
    [self viewDidLoad];
    [self.customTable reloadData];
    
    self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.leftBarButtonItem =  backButton;
    del.selectedMark = @"not delete state";
    self.title = @"我的E-magazine收藏";
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.articleDictionary.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? kHeadlineSectionHeight : kRegularSectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customSectionHeaderView;
    UILabel *titleLabel;
    UIFont *labelFont;
    
    if (section == 0)
    {
        customSectionHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kHeadlineSectionHeight)] autorelease];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, kHeadlineSectionHeight)];
        labelFont = [UIFont boldSystemFontOfSize:20];
    }
    else
    {
        customSectionHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kRegularSectionHeight)] autorelease];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, kRegularSectionHeight)];
        
        labelFont = [UIFont boldSystemFontOfSize:13];
    }
    
    customSectionHeaderView.backgroundColor = [UIColor colorWithRed:0 green:0.40784314 blue:0.21568627 alpha:0.95];
    
    titleLabel.textAlignment = UITextAlignmentLeft;
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.font = labelFont;
        
    NSString *categoryName = [sortedCategories objectAtIndex:section];
    titleLabel.text = [categoryName substringFromIndex:0];
    
    [customSectionHeaderView addSubview:titleLabel];
    [titleLabel release];
    
    return customSectionHeaderView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identify = @"HorizontalCell";
    HorizontalTableCell *cell = (HorizontalTableCell*)[tableView dequeueReusableCellWithIdentifier:identify];
    NSString *categoryName;
    NSArray *currentCategory;
    
    categoryName = [self.sortedCategories objectAtIndex:indexPath.section];
    currentCategory = [self.articleDictionary objectForKey:categoryName];

    if (cell == nil) {
        cell = [[[HorizontalTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify withArray:[self.articleDictionary objectForKey:categoryName] andCategory:categoryName] autorelease];
        
    }
    return cell;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        self.view.frame=CGRectMake(0, 0, 1024, 748);
        self.customTable.frame=CGRectMake(0, 0, 1024, 748);
    }
    else{
        self.view.frame=CGRectMake(0, 0, 768, 1004);
        self.customTable.frame=CGRectMake(0, 0, 768, 1004);
    }
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation)||UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

///ios 6.0
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        self.view.frame=CGRectMake(0, 0, 1024, 748);
        self.customTable.frame=CGRectMake(0, 0, 1024, 748);
    }
    else{
        self.view.frame=CGRectMake(0, 0, 768, 1004);
        self.customTable.frame=CGRectMake(0, 0, 768, 1004);
    }
}
#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload
{
    self.articleDictionary = nil;
    [self.articleDictionary release];
    self.customTable = nil;
    [self.customTable release];
    self.sortedCategories = nil;
    [self.sortedCategories release];

    [super viewDidUnload];
}
- (void)dealloc
{
    self.articleDictionary = nil;
    [self.articleDictionary release];
    self.customTable = nil;
    [self.customTable release];
    self.sortedCategories = nil;
    [self.sortedCategories release];
    [super dealloc];
}
@end
//
//  AddBookmarkViewController.m
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import "AddCollectMarkViewController.h"

@interface AddCollectMarkViewController ()
- (void)saveAction;
- (void)cancelAction;
- (void)saveCollectmarks;
@end

@implementation AddCollectMarkViewController

@synthesize delegate;
@synthesize collectmark;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    del = (BFAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setBookmark:del.bookName andNumber:nil];
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.title = @"添加到我的收藏";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction) ] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction) ] autorelease];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSData * bookmarks = [defaults objectForKey:@"collectmarks"];
    if (bookmarks) {
        collectmarksArray= [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:bookmarks]];
    } else {
        collectmarksArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    
    [nameTextField becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

#pragma mark -
#pragma mark Buttons methods

- (void)saveAction {
    [nameTextField resignFirstResponder];
    collectmark.name = nameTextField.text;
    [self saveCollectmarks];
    [delegate dismissAddBookmMarkViewController:self];
}

- (void)cancelAction {
    [delegate dismissAddBookmMarkViewController:self];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    switch (section) {
        case 0:
        {
            rows = 1;
            break;
        }
        default:
        {
            break;
        }
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TextFieldCellIdentifier = @"textFieldCell";
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
                    if (cell == nil) {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextFieldCellIdentifier] autorelease];
                        
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
                        nameTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                        nameTextField.adjustsFontSizeToFitWidth = YES;
                        nameTextField.textColor = [UIColor colorWithRed:50.0/255 green:79.0/255 blue:133.0/255 alpha:1.0];
                        nameTextField.keyboardType = UIKeyboardTypeDefault;
                        nameTextField.returnKeyType = UIReturnKeyDone;
                        nameTextField.backgroundColor = [UIColor clearColor];
                        nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
                        nameTextField.autocapitalizationType =UITextAutocapitalizationTypeNone;
                        nameTextField.textAlignment = NSTextAlignmentLeft;
                        nameTextField.delegate = self;
                        nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                        [nameTextField setEnabled: YES];
                        nameTextField.text = collectmark.name;
                        
                        [cell addSubview:nameTextField];
                        [nameTextField release];
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            break;
        }
        default:
        {
            break;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark -
#pragma mark TextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self saveAction];
}


#pragma mark -

- (void)saveCollectmarks {
    [nameTextField resignFirstResponder];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"Articles.plist"];
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        //此处可以自己写显示plist文件内容
        NSLog(@"文件已存在");
    }
    else
    {
        //如果没有plist文件就自动创建
        NSMutableDictionary *RootPlist = [[NSMutableDictionary alloc ] init];
        [RootPlist writeToFile:plistPath atomically:YES];
    }
    NSString *title = collectmark.name;
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd aa 5"];
    NSString *time1=[dateformatter stringFromDate:senddate];
    
    dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd aa HH:mm:ss"];
    NSString *pubDate=[dateformatter stringFromDate:senddate];
    
    NSString *imageName=[NSString stringWithFormat:@"MistyBigBen.png"];
    
    NSDictionary *dictplist = [NSDictionary dictionaryWithObjectsAndKeys:title,@"Title",pubDate,@"PubDate",imageName,@"ImageName" ,nil];
    
    NSMutableDictionary *RootPlist = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath] ;
    NSMutableArray *dicttxt = [[NSMutableArray alloc ] init];
    BOOL saveMark = NO;
    BOOL saveMark2 = YES;
    
    for (id aKey in [RootPlist allKeys]) {
        if ([aKey isEqualToString:time1]) {
            dicttxt= (NSMutableArray *)[RootPlist objectForKey:aKey];
            saveMark = YES;
            break;
        }
    }
    if (saveMark) {
        for (NSDictionary *aDic in dicttxt) {
            if ([[aDic objectForKey:@"Title"] isEqualToString:title]) {
                saveMark2 = NO;
                break;
            }
        }
    }
    if (saveMark2 == YES) {
        [dicttxt addObject:dictplist];
    }
    [RootPlist setObject:dicttxt forKey:time1];
    [RootPlist writeToFile:plistPath atomically:YES];
    
}
- (void)setBookmark:(NSString *)aName andNumber:(NSString *)aNumber{
    collectmark = [[CollectmarkObject alloc] initWithName:aName andNumber:aNumber];
}

- (void)dealloc {
    self.collectmark = nil;
    [collectmarksArray release];
    [super dealloc];
}

@end


//
//  AddBookmarkViewController.m
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import "AddBookmarkViewController.h"

@interface AddBookmarkViewController ()
- (void)saveAction;
- (void)cancelAction;
- (void)saveBookmarks;
@end

@implementation AddBookmarkViewController

@synthesize delegate;
@synthesize bookmark;
@synthesize strBookMark;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.title = @"添加书签";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction) ] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction) ] autorelease];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSData * bookmarks = [defaults objectForKey:strBookMark];
    if (bookmarks) {
        bookmarksArray= [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:bookmarks]];
    } else {
        bookmarksArray = [[NSMutableArray alloc] initWithCapacity:1];        
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
    BOOL saveMark = YES;
    for (BookmarkObject * bookmark01 in bookmarksArray) {
        if ([bookmark01.name isEqualToString:nameTextField.text] &&
            [bookmark01.pageNumber isEqualToString:bookmark.pageNumber]) {
            saveMark = NO;
            break;
        }
    }
    
    if (saveMark) {
        bookmark.name = nameTextField.text;
        [bookmarksArray addObject:bookmark];
        [self.tableView reloadData];
    }
    
    [self saveBookmarks];
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
            rows = 2;
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
    static NSString *UrlCellIdentifier = @"urlCell";
    static NSString *TextFieldCellIdentifier = @"textFieldCell";
    UITableViewCell *cell = nil;

    // Set up the cell...
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
                        nameTextField.text = bookmark.name;
                        [cell addSubview:nameTextField];
                        [nameTextField release];
                    }
                    break;
                }
                case 1:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:UrlCellIdentifier];
                    if (cell == nil) {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UrlCellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    cell.textLabel.adjustsFontSizeToFitWidth = YES;
                    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
                    cell.textLabel.minimumFontSize = 18.0;
                    cell.textLabel.textColor = [UIColor colorWithRed:165.0/255 green:165.0/255 blue:165.0/255 alpha:1.0];
                    cell.textLabel.text = [NSString stringWithFormat:@"%d",[bookmark.pageNumber intValue]+1];
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
//    [self saveAction];
}

#pragma mark -

- (void)saveBookmarks {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:bookmarksArray] forKey:strBookMark];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setBookmark:(NSString *)aName andNumber:(NSString *)aNumber{
    bookmark = [[BookmarkObject alloc] initWithName:aName andNumber:aNumber];
}

- (void)dealloc {
    self.bookmark = nil;
    [bookmarksArray release];
    self.strBookMark = nil;
    [self.strBookMark release];
    [super dealloc];
}

@end


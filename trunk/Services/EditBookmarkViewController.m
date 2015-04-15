//
//  EditBookmarkViewController.m
//  CIALBrowser
//
//  Created by Sylver Bruneau on 03/03/12.
//  Copyright 2012 CodeIsALie. All rights reserved.
//

#import "EditBookmarkViewController.h"

@implementation EditBookmarkViewController

@synthesize bookmark;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setContentSizeForViewInPopover:)])
    {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
    }
    
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.title = @"Edit Bookmark";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    
    [nameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [self save];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section)
    {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *UrlCellIdentifier = @"urlCell";
    static NSString *TextFieldCellIdentifier = @"textFieldCell";
    UITableViewCell *cell = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
                    if (cell == nil)
                    {
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
                        nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; 
                        nameTextField.textAlignment = NSTextAlignmentLeft;
                        nameTextField.delegate = self;
                        nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                        
                        [nameTextField setEnabled: YES];
                        
                        [cell addSubview:nameTextField];
                        
                        [nameTextField release];
                    }
                    nameTextField.text = bookmark.name;
                    break;
                }
                case 1:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:UrlCellIdentifier];
                    if (cell == nil)
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UrlCellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        indexTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
                        indexTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                        indexTextField.adjustsFontSizeToFitWidth = YES;
                        indexTextField.minimumFontSize = 14.0;
                        indexTextField.font = [UIFont systemFontOfSize:17.0];
                        indexTextField.textColor = [UIColor colorWithRed:50.0/255 green:79.0/255 blue:133.0/255 alpha:1.0];
                        indexTextField.keyboardType = UIKeyboardTypeURL;
                        indexTextField.returnKeyType = UIReturnKeyDone;
                        indexTextField.backgroundColor = [UIColor clearColor];
                        indexTextField.autocorrectionType = UITextAutocorrectionTypeNo;
                        indexTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                        indexTextField.textAlignment = UITextAlignmentLeft;
                        indexTextField.delegate = self;
                        indexTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                        [indexTextField setEnabled: YES];
                        
                        [cell addSubview:indexTextField];
                        
                        [indexTextField release];

                     }
                    indexTextField.text = [NSString stringWithFormat:@"%d",[bookmark.pageNumber intValue]+1 ];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    bookmark.name = nameTextField.text;
    bookmark.pageNumber = indexTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
    return NO;
}

#pragma mark -
#pragma mark private methods

- (void)save
{
    [nameTextField resignFirstResponder];
    bookmark.name = nameTextField.text;
    bookmark.pageNumber = indexTextField.text;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    self.bookmark = nil;
    [self.bookmark release];
    [super dealloc];
}

@end

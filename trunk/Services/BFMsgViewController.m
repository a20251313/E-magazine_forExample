//
//  BFMsgViewController.m
//  E-magazine
//
//  Created by summer.zhu on 5/29/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFMsgViewController.h"

@interface BFMsgViewController ()
- (void)saveMsg;
@end

@implementation BFMsgViewController
@synthesize arrData;
@synthesize strMsgKey;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrData = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didPressedBtnEdit)];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

- (void)saveMsg{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:arrData forKey:strMsgKey];
    [userDefault synchronize];
}

- (void)didPressedBtnEdit{
    [tableMsg setEditing:YES animated:YES];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didPressedBtnDone)];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

- (void)didPressedBtnDone{
    [tableMsg setEditing:NO animated:YES];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didPressedBtnEdit)];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewMsg:(NSMutableArray *)arrNewMsg{
    [arrData addObjectsFromArray:arrNewMsg];
    [tableMsg reloadData];
    [self saveMsg];
}

#pragma mark - tablaview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *strMsg = [arrData objectAtIndex:indexPath.row];
    cell.textLabel.text = strMsg;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *messageStr;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        messageStr = [arrData objectAtIndex:indexPath.row];
        [arrData removeObjectAtIndex:indexPath.row];
        [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                               withRowAnimation:UITableViewRowAnimationFade];
        [self saveMsg];
        if ([strMsgKey isEqualToString:@"msgKey0"]) {
            if ([self.delegate respondsToSelector:@selector(delegateMsg:)]) {
                [self.delegate delegateMsg:messageStr];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(delegateMsg_1:)]) {
                [self.delegate delegateMsg_1:messageStr];
            }
        }

    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSString *str = [arrData objectAtIndex:sourceIndexPath.row];
	[arrData removeObjectAtIndex:sourceIndexPath.row];
	[arrData insertObject:str atIndex:destinationIndexPath.row];
    [self saveMsg];
}
- (void)dealloc{
    [tableMsg release];
    [super dealloc];
}

@end

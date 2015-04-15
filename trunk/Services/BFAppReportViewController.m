//
//  BFAppReportViewController.m
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFAppReportViewController.h"
#import "BFAppAddInfoViewController.h"

@interface BFAppReportViewController ()

@end

@implementation BFAppReportViewController
@synthesize delegate;
@synthesize users;
@synthesize appReportView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"提交系统";
        UIBarButtonItem *backButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
        backButton.title = @"取消";
        self.navigationItem.leftBarButtonItem = backButton;
        
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(next)];
        nextButton.title = @"下一步";
        self.navigationItem.rightBarButtonItem = nextButton;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    users = [[NSArray alloc] initWithObjects:@"赵广",@"钱泳",@"孙进",@"李镇国",@"周韵",@"吴显",@"郑当时",@"王李",@"韩前卫", nil];
    self.appReportView = [[BFAppReportView alloc]  initWithFrame:self.view.frame];
    self.appReportView.PostUsers.delegate = self;
    self.appReportView.PostUsers.dataSource =self;
    self.view = self.appReportView;
}
-(void)back{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)next{
    BFAppAddInfoViewController *appAddInfoViewController = [[BFAppAddInfoViewController alloc] init];
    appAddInfoViewController.delegate = self;
    [self.navigationController pushViewController:appAddInfoViewController animated:YES];
}
-(void)dismissPostUserController{
    [self dismissViewControllerAnimated:NO completion:nil];
    [delegate dismissController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [users count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *title;
    title = [users objectAtIndex:indexPath.row];
    [[cell textLabel] setText:title];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFAppAddInfoViewController *appAddInfoViewController = [[BFAppAddInfoViewController alloc] init];
    appAddInfoViewController.delegate = self;
    appAddInfoViewController.userName = [users objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:appAddInfoViewController animated:YES];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    }
    else{
        return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    }
    
}
///ios 6.0
-(BOOL)shouldAutorotate{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
}

@end

//
//  BFCollectViewController.m
//  E-magazine
//
//  Created by sunjian on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFCollectViewController.h"

@interface BFCollectViewController ()

@end

@implementation BFCollectViewController
@synthesize btnImage1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [label setText:@"我的收藏"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:25];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    [self navigationItem].leftBarButtonItem = back;
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [myScrollView setContentSize:CGSizeMake(1024, 800)];
    [self.view addSubview:myScrollView];
    
    [btnImage1 setBackgroundImage:[UIImage imageNamed:@"03-00.png"] forState:UIControlStateNormal];
    [btnImage1 addTarget:self action:@selector(actionOne) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:btnImage1];

}
-(void)backAction{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)actionOne
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {
    btnImage1 = nil;
    [super viewDidUnload];
}

@end

//
//  BFMenuInfoViewController.m
//  E-magazine
//
//  Created by sunjian on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFMenuInfoViewController.h"

@interface BFMenuInfoViewController ()

@end

@implementation BFMenuInfoViewController

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
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    [self navigationItem].leftBarButtonItem = back;
}
-(void)backAction{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

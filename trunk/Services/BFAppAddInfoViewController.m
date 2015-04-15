//
//  BFAppAddInfoViewController.m
//  E-magazine
//
//  Created by mike.sun on 6/6/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFAppAddInfoViewController.h"

@interface BFAppAddInfoViewController ()

@end

@implementation BFAppAddInfoViewController
@synthesize delegate;
@synthesize userName;
@synthesize appAddInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *backButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(back)];
        backButton.title = @"返回";
        self.navigationItem.leftBarButtonItem = backButton;
        
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(next)];
        nextButton.title = @"提交";
        self.navigationItem.rightBarButtonItem = nextButton;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = userName;
    appAddInfo = [[BFAppAddInfoView alloc] init];
    appAddInfo.suggestTextView.delegate = self;
    self.view = appAddInfo;
}
-(void)back{
    [self.appAddInfo.suggestTextView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next{
    [self.navigationController popViewControllerAnimated:NO];
    [delegate dismissPostUserController];
}
-(BOOL)textView:(UITextView *)atextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)atext
{
    if ([atext isEqualToString:@"\n"]) {
        [self.appAddInfo.suggestTextView resignFirstResponder];
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1];
        CGRect frame = self.appAddInfo.suggestTextView.frame;
        frame.origin.y = 60;
        self.appAddInfo.suggestTextView.frame = frame;
        [UIView commitAnimations];
        
        return NO;
    }

    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)atextView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    CGRect frame = self.appAddInfo.suggestTextView.frame;
    frame.origin.y = 10;
    self.appAddInfo.suggestTextView.frame = frame;
    [UIView commitAnimations];
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

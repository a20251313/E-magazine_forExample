//
//  BACommentViewController.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BACommentViewController.h"
#import "BFAppReportViewController.h"
#import "SNViewController.h"
#import "BFAppDelegate.h"
#import "SmoothLineView.h"
#import "BFHeaderView.h"

#import "BFAppDelegate.h"
#import "Global.h"

@interface BACommentViewController ()
{
    UIImage *myImage;
    int commentCount;
    UIView *commentHolder;
    UIView *selectComment;
    CGPoint preOrgin;
    SmoothLineView *smoothLineView;
    UIPopoverController *popover;
}
@end

@implementation BACommentViewController
@synthesize screenshot=_screenshot;
-(id)initWithImage:(UIImage*)image
{
    self = [super init];
    if (self) {
        myImage=image;
    }
    return self;
    
}
-(void)setScreenshot:(UIImageView *)screenshot
{
    _screenshot=screenshot;
}
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

    tabeleData = [[NSArray alloc] initWithObjects:@"以邮件发送屏幕截图",@"保存到照片",@"发送到服务器",@"提交本系统", nil];
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.view.frame=CGRectMake(0,0, 768, 1004);
        self.screenshot.frame=CGRectMake(0,0, 768, 1004);
    }
    else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        self.view.frame=CGRectMake(0,0, 1024, 748);
        self.screenshot.frame=CGRectMake(0,0, 1024, 748);
    }

    [self.screenshot setImage:myImage];
    smoothLineView=[[SmoothLineView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:smoothLineView];
    header=[[[NSBundle mainBundle] loadNibNamed:@"BFDrawHeader" owner:nil options:nil]lastObject];
    header.frame=CGRectMake(0, 0, self.view.frame.size.width,44);
    header.delegate = self;
    [self.view addSubview:header];

}
-(void)backAction
{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否退出编辑注释？"  
                                                             delegate:self  
                                                    cancelButtonTitle:@"取消"  
                                               destructiveButtonTitle:@"确认"  
                                                    otherButtonTitles:@"取消",nil
                                  ];  
    [actionSheet showInView:self.view]; 

}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{  
    if(buttonIndex ==[actionSheet destructiveButtonIndex]){
    header.hidden = YES;
    [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(void)showTools:(UIButton*)button
{
    UITableViewController *tableViewController=[[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    tableViewController.tableView.delegate=self;
    tableViewController.tableView.dataSource=self;
    
    [popover dismissPopoverAnimated:YES];
    popover=[[UIPopoverController alloc]initWithContentViewController:tableViewController];
    popover.popoverContentSize=CGSizeMake(200, 44*[tabeleData count]);
    [popover presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
-(void)showLogin{
    
    SNViewController *snViewController=[BFAppDelegate instance].viewController3;
    snViewController.delegate=self;
    snViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentViewController:snViewController animated:YES completion:nil];
    
    snViewController.view.superview.frame=CGRectMake(0, 0,669,382);
    if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOrientation])){
        //横屏
        snViewController.view.superview.center=CGPointMake(512,384);
    }else{
        //竖屏
        snViewController.view.superview.center=CGPointMake(384,512);
    }
}

-(void)cleanImage
{
    smoothLineView.clean=YES;
    [smoothLineView setNeedsDisplay];
}
-(CGPoint)midPositionOfView:(UIImageView*)view
{
    float width=view.bounds.size.width;
    float height=view.bounds.size.height;
    return CGPointMake(width/2, height/2);
}
-(void)generateComment
{
    if (commentCount>9) {
        return;
    }
    commentCount++;
    commentHolder=[[UIView alloc]initWithFrame:CGRectMake([self midPositionOfView:_screenshot].x+commentCount*10, 100+commentCount*10, 150, 100)];
    commentHolder.layer.shadowColor=[[UIColor blackColor]CGColor];
    commentHolder.layer.shadowOffset=CGSizeMake(4, 4);
    commentHolder.layer.shadowRadius=2;
    commentHolder.layer.shadowOpacity=0.5;
    commentHolder.layer.cornerRadius=5.0f;
    UITextView *textView=[[UITextView alloc]initWithFrame:commentHolder.bounds];
    textView.editable=YES;
    textView.delegate=self;
    textView.tag=1;
    textView.userInteractionEnabled=NO;
    [textView setFont:[UIFont fontWithName:@"Arial" size:15.0f]];
    textView.backgroundColor=[BAColorHelper stringToUIColor:@"fffacd" alpha:@"1"];
    
    UIView *banner=[[UIView alloc]initWithFrame:CGRectMake(0, 0, commentHolder.bounds.size.width, 20)];
    banner.tag=2;
    banner.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setTitle:@"X" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteComment:) forControlEvents:UIControlEventTouchUpInside];
    [banner addSubview:button];
    [banner setHidden:YES];

    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [pan requireGestureRecognizerToFail:longPress];
    [tap requireGestureRecognizerToFail:pan];
    [commentHolder addGestureRecognizer:tap];
    [commentHolder addGestureRecognizer:pan];
    [commentHolder addGestureRecognizer:longPress];
    [commentHolder addSubview:textView];
    [commentHolder addSubview:banner];
    [self.view addSubview:commentHolder];
    
}
-(void)tapAction:(UITapGestureRecognizer*)sender
{
    selectComment=sender.view;
    CGPoint location=[sender locationInView:sender.view];
    
    UIView *banner=(UIView*) [sender.view viewWithTag:2];
    if (banner.isHidden) {
        UITextView *textView=(UITextView*)[sender.view viewWithTag:1];
        textView.userInteractionEnabled=YES;
        [textView becomeFirstResponder];
    }else {
        if (location.x<=20&&location.y<=20) {
            [selectComment removeFromSuperview];
            commentCount--;
        }
    }
    
    [banner setHidden:YES];
    
}
-(void)longPressAction:(UILongPressGestureRecognizer*)sender
{
    selectComment=sender.view;
    UITextView *textView=(UITextView*)[sender.view viewWithTag:1];
    textView.userInteractionEnabled=NO;
    UIView *banner=(UIView*) [sender.view viewWithTag:2];
    banner.frame=CGRectMake(0,0,sender.view.frame.size.width,20);
    [banner setHidden:NO];
    /*NSDictionary *userInfo=[NSDictionary dictionaryWithObject:sender.view forKey:@"commentHolder"];
    NSTimer *timer=[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(shakeAction:) userInfo:userInfo repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];*/
}
-(void)shakeAction:(NSTimer*)timer
{
    UIView *comment=(UIView*)[timer.userInfo objectForKey:@"commentHolder"];
    [UIView beginAnimations:@"shake" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.1 animations:^
    {
     comment.transform= CGAffineTransformMakeRotation(M_PI/100);
    } completion:^(BOOL finished)
    {
        comment.transform=CGAffineTransformMakeRotation(-M_PI/100);
    } ];
}
-(void)deleteComment:(UIButton*)sender
{
    [selectComment removeFromSuperview];
    commentCount--;
}
-(void)panAction:(UIPanGestureRecognizer*)sender
{
    CGPoint translation=[sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x, sender.view.center.y + translation.y);
    //sender.view.transform=CGAffineTransformMakeTranslation(translation.x, translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text 
{ 
    if ([text isEqualToString:@"\n"]) { 
        [textView resignFirstResponder];  
        textView.userInteractionEnabled=NO;
        
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];        
        [UIView setAnimationDuration:0.3];        
        selectComment.frame=CGRectMake(preOrgin.x, preOrgin.y, selectComment.frame.size.width, selectComment.frame.size.height);
        [UIView commitAnimations];         
        
        return NO; 
    } 
    //CGSize constraint = CGSizeMake(textView.bounds.size.width - 16, textView.bounds.size.height-16);
    //CGSize size = [text sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    //float h=textView.contentSize.height;
    float expandSize=15;
    if (textView.bounds.size.height<textView.contentSize.height) {
        
        commentHolder.frame=CGRectMake(commentHolder.frame.origin.x, commentHolder.frame.origin.y, commentHolder.bounds.size.width+expandSize, commentHolder.bounds.size.height+expandSize/2);
        textView.frame=commentHolder.bounds;
    }
    return YES; 
} 
-(void) textViewDidBeginEditing:(UITextView *)textView
{  
    CGRect aframe = textView.frame;
    CGRect frame=[textView convertRect:aframe toView:self.view];
    int offset = frame.origin.y + frame.size.height - (self.view.frame.size.height - 352.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;                
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];                
    [UIView setAnimationDuration:animationDuration];  
    float x=selectComment.frame.origin.x;
    float y=selectComment.frame.origin.y;
    preOrgin=CGPointMake(x, y);
    if(offset > 0)
    {
        
        selectComment.frame=CGRectMake(x,self.view.frame.size.height - 352.0-selectComment.frame.size.height, selectComment.frame.size.width,selectComment.frame.size.height);
     
    } 
    [UIView commitAnimations];                

}  
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tabeleData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *title;
    title = [tabeleData objectAtIndex:indexPath.row];
    [[cell textLabel] setText:title];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [popover dismissPopoverAnimated:YES];
    UIGraphicsBeginImageContext(self.view.bounds.size);  
    CGContextRef context = UIGraphicsGetCurrentContext();  
    [self.view.layer renderInContext:context];  
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    switch (indexPath.row) {
        case 0:
        {
            Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
            if ([mailClass canSendMail]) {
                MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
                mailPicker.mailComposeDelegate = self;
                
                //设置主题
                //[mailPicker setSubject: @"eMail主题"];
                //添加收件人
                //NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
                //[mailPicker setToRecipients: toRecipients];
                //添加抄送
                //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
                //[mailPicker setCcRecipients:ccRecipients];
                //添加密送
                //NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
                //[mailPicker setBccRecipients:bccRecipients];
                
                // 添加一张图片
                
                NSData *imageData = UIImagePNGRepresentation(theImage);            // png
                //关于mimeType：http://www.iana.org/assignments/media-types/index.html
                [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"screenshot.png"];
                
                //添加一个pdf附件
                //NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
                //NSData *pdf = [NSData dataWithContentsOfFile:file];
                //[mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
                
                NSString *emailBody = @"";
                [mailPicker setMessageBody:emailBody isHTML:YES];
                [self presentViewController:mailPicker animated:YES completion:nil];
                //[mailPicker release];     
            }
        }
            break;
        case 1:
        {
            
            UIImageWriteToSavedPhotosAlbum(theImage, nil, nil, nil);
            [BAGeneralTools showMsg:@"图片已存入相册"];
        }
            break;
        case 2:
        {
            [AppDelegateEntity startTimer];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 3:
        {
            BFAppReportViewController *appReportViewController = [[BFAppReportViewController alloc] init];
            appReportViewController.delegate = self;
            UINavigationController  *nav = [[UINavigationController alloc] initWithRootViewController:appReportViewController];
            nav.navigationBar.barStyle =UIBarStyleBlack;
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dismissController{
    [AppDelegateEntity startTimer_1];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{   
    //关闭邮件发送窗口   
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;     
    switch (result) {     
        case MFMailComposeResultCancelled:     
            //msg = @"取消编辑邮件";     
            break;     
        case MFMailComposeResultSaved:     
            //msg = @"成功保存邮件";     
            break;     
        case MFMailComposeResultSent:     
            msg = @"邮件发送";     
            [BAGeneralTools showMsg:msg];
            break;     
        case MFMailComposeResultFailed:     
            //msg = @"保存或者发送邮件失败";     
            break;     
        default:     
            msg = @"";   
            break;     
    }  
    
 
} 
- (void)viewDidUnload
{
    [self setScreenshot:nil];
    [super viewDidUnload];
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

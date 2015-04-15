//
//  SNViewController.m
//  sinaweibo_ios_sdk_demo
//
//  Created by Wade Cheng on 4/23/12.
//  Copyright (c) 2012 SINA. All rights reserved.
//

#import "SNViewController.h"
#import "BFAppDelegate.h"
#import "CommentView.h"

@interface SNViewController ()

@end

@implementation SNViewController
@synthesize delegate;

- (void)dealloc
{
    [userInfo release], userInfo = nil;
    [statuses release], statuses = nil;
    [postStatusText release], postStatusText = nil;
    [postImageStatusText release], postImageStatusText = nil;
    [super dealloc];
}

- (SinaWeibo *)sinaweibo
{
    BFAppDelegate *appdelegate = (BFAppDelegate *)[UIApplication sharedApplication].delegate;
    return appdelegate.sinaweibo;
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)resetButtons
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;

    loginButton.enabled = !authValid;
    logoutButton.enabled = authValid;
    userInfoButton.enabled = authValid;
    timelineButton.enabled = authValid;
    postStatusButton.enabled = authValid;
    postImageStatusButton.enabled = authValid;
    
    if (authValid)
    {
        [logoutButton setTitle:[NSString stringWithFormat:@"logout uid=%@", sinaweibo.userID] forState:UIControlStateNormal];
        if (userInfo)
        {
            [userInfoButton setTitle:[userInfo objectForKey:@"screen_name"] forState:UIControlStateNormal];
        }
        if (statuses)
        {
            if (statuses.count > 0)
            {
                [timelineButton setTitle:[[statuses objectAtIndex:0] objectForKey:@"text"] forState:UIControlStateNormal];
            }
            else
            {
                [timelineButton setTitle:@"no status" forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        [logoutButton setTitle:@"logout" forState:UIControlStateNormal];
        [userInfoButton setTitle:@"get user info" forState:UIControlStateNormal];
        [timelineButton setTitle:@"get timeline" forState:UIControlStateNormal];
    }
}

- (UIButton *)buttonWithFrame:(CGRect)frame action:(SEL)action
{
    UIImage *buttonBackgroundImage = [[UIImage imageNamed:@"button_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *disabledButtonBackgroundImage = [[UIImage imageNamed:@"button_background_disabled.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:disabledButtonBackgroundImage forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return button;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sn0.png"]];
    [bg setFrame:CGRectMake(0, 0, 669, 382)];
    [self.view addSubview:bg];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    logoImageView.frame = CGRectMake(20, 10, 73, 30);
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    UIImageView *user = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userhead.jpg"]];
    user.frame = CGRectMake(30, 60, 52, 52);
    [self.view addSubview:user];
    [user release];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 200, 30)];
    name.text=@"Spmagician";
    [name setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:name];
    
    UILabel *name2=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 500, 190)];
    [name2 setFont:[UIFont systemFontOfSize:20]];
    name2.backgroundColor=[UIColor clearColor];
    name2.text=@"【无锡：生命之船，在浆声灯影里的古运河】我深深怀念在古运河边度过的愉快的夏夜。渔火、桨声、水响声，黑夜的音乐乘着涟漪的风从水面上传来。仰望在神秘而恬静的气氛中，用心灵与天上微笑的星星交流。而桥下的流水静静地唱着甜蜜的摇篮曲，催人在夜风温馨的抚摸中慢慢沉入梦乡http://t.cn/z0gPUM9  \n1月24日10:03 来自新浪微博";
    name2.numberOfLines=0;
    [self.view addSubview:name2];
    
    
    UIButton *login=[[UIButton alloc]initWithFrame:CGRectMake(440,320, 64, 42)];
    [login setBackgroundImage:[UIImage imageNamed:@"sn1.png"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    UIButton *collect=[[UIButton alloc]initWithFrame:CGRectMake(504,320, 64, 42)];
    [collect setBackgroundImage:[UIImage imageNamed:@"sn2.png"] forState:UIControlStateNormal];
    [collect addTarget:self action:@selector(collected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collect];
    UIButton *comment=[[UIButton alloc]initWithFrame:CGRectMake(568,320, 64, 42)];
    [comment setBackgroundImage:[UIImage imageNamed:@"sn3.png"] forState:UIControlStateNormal];
    [comment addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:comment];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(620,14, 32, 32)];
    [close setBackgroundImage:[UIImage imageNamed:@"sn4.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    
    commentview=[[CommentView alloc]initWithFrame:CGRectMake(0, 0, 504, 266)];
    [commentview setCenter:CGPointMake(bg.center.x, 1024)];
    
    commentview.delegate=self;
    [self.view addSubview:commentview];
}
-(void)collected{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收藏"
                                                        message:@"收藏成功"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
    [alertView release];
}
-(void)addComment{
    //动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];  //动画时间长度，单位秒，浮点数
    
    [commentview setFrame:CGRectMake(commentview.frame.origin.x, 20, 504,266)];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
-(void)dismissComment{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];  //动画时间长度，单位秒，浮点数
    
    [commentview setFrame:CGRectMake(commentview.frame.origin.x, 1024, 504,266)];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

    
}
-(void)PostComment:(NSString *)commentword{
   
    postStatusText = [[NSString alloc] initWithFormat:commentword, post_status_times, [NSDate date]];
    [self RepostStatusButtonPressed];
    
     [commentview.comment resignFirstResponder];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8];  //动画时间长度，单位秒，浮点数
    
    [commentview setFrame:CGRectMake(commentview.frame.origin.x, 1024, 504,266)];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

}


-(void)closed{
    [self logoutButtonPressed];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loginButtonPressed
{    
    [userInfo release], userInfo = nil;
    [statuses release], statuses = nil;
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logIn];
}

- (void)logoutButtonPressed
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logOut];
}

- (void)userInfoButtonPressed
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}

- (void)timelineButtonPressed
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}

static int post_status_times = 0;
- (void)postStatusButtonPressed
{
    if (!postStatusText)
    {
        post_status_times ++;
        [postStatusText release], postStatusText = nil;
        postStatusText = [[NSString alloc] initWithFormat:@"test post status : %i %@", post_status_times, [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"发送微博 \"%@\"", postStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 0;
    [alertView show];
    [alertView release];
}

-(void)RepostStatusButtonPressed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"转发微博并评论\"%@\"", postStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 2;
    [alertView show];
    [alertView release];
}

static int post_image_status_times = 0;
- (void)postImageStatusButtonPressed
{
    if (!postImageStatusText)
    {
        post_image_status_times ++;
        [postImageStatusText release], postImageStatusText = nil;
        postImageStatusText = [[NSString alloc] initWithFormat:@"test post image status : %i %@", post_image_status_times, [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"Will post image status with text \"%@\"", postImageStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 1;
    [alertView show];
    [alertView release];
}



- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (alertView.tag == 0)
        {
            // post status
            SinaWeibo *sinaweibo = [self sinaweibo];
            [sinaweibo requestWithURL:@"statuses/update.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                           httpMethod:@"POST"
                             delegate:self];
            
        }
        else if (alertView.tag == 1)
        {
            // post image status
            SinaWeibo *sinaweibo = [self sinaweibo];
            
            [sinaweibo requestWithURL:@"statuses/upload.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       postImageStatusText, @"status",
                                       [UIImage imageNamed:@"logo.png"], @"pic", nil]
                           httpMethod:@"POST"
                             delegate:self];
            
        }else if(alertView.tag==2){
            SinaWeibo *sinaweibo = [self sinaweibo];
            
            NSMutableDictionary *tmpDict=[[NSMutableDictionary alloc]init];
            NSString *sts =[NSString stringWithFormat:@"%d",1];

            [tmpDict setValue:@"3537935502221529" forKey:@"id"];
            [tmpDict setValue:postStatusText forKey:@"status"];
            [tmpDict setValue:sts forKey:@"is_comment"];
            
            [sinaweibo requestWithURL:@"statuses/repost.json"
                               params:tmpDict
                           httpMethod:@"POST"
                             delegate:self];

        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self resetButtons];
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    [self resetButtons];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
    [self resetButtons];
}

#pragma mark - SinaWeiboRequest Delegate 

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release], userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release], statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
    
    [self resetButtons];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release];
        userInfo = [result retain];
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release];
        statuses = [[result objectForKey:@"statuses"] retain];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"发送成功 \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];

        [postStatusText release], postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postImageStatusText release], postImageStatusText = nil;
    }else if([request.url hasSuffix:@"statuses/repost.json"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"评论成功"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postStatusText release], postStatusText = nil;    }
    
    [self resetButtons];
}

@end

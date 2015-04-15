//
//  BAToolsButton.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAToolsButton.h"
#import "BADefinition.h"

@implementation BAToolsButton
{
    UIBarButtonItem *button;
    UIPopoverController *popover;
    UIViewController *controller;
    BACommentViewController *commentController;
    
}
@synthesize controller;
-(UIBarButtonItem*)generateButtonWithController:(UIViewController*)viewController
{
    button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showPopover)];
    controller=viewController;
    return button;
    
    
}
-(UIBarButtonItem*)generateButtonWithControllerIphone:(UIViewController *)viewController
{
    button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showCommentController)];
    controller=viewController;
    return button;
}
-(void)showCommentController
{
    UIGraphicsBeginImageContext(controller.view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [controller.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    commentController=[[BACommentViewController alloc]initWithImage:theImage ];
    
    //BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    //[controller.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
    //[[controller navigationController]pushViewController:commentController animated:NO];
    
    [controller presentViewController:commentController animated:YES completion:^{}];
commentController=nil;
}
-(void)showPopover
{
    UITableViewController *tableViewController=[[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    tableViewController.tableView.delegate=self;
    tableViewController.tableView.dataSource=self;

    [popover dismissPopoverAnimated:YES];
    popover=[[UIPopoverController alloc]initWithContentViewController:tableViewController];
    popover.popoverContentSize=CGSizeMake(200, 120);
    [popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *title;
    switch (indexPath.row) {
        case 0:
        {
            title=@"注释并共享";
            
        }
            break;
        default:
            title=@"";
            break;
    }
    
    [[cell textLabel] setText:title];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [popover dismissPopoverAnimated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIGraphicsBeginImageContext(controller.view.bounds.size);  
            CGContextRef context = UIGraphicsGetCurrentContext();  
            [controller.view.layer renderInContext:context];  
            UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();  
            UIGraphicsEndImageContext(); 
            
            commentController=[[BACommentViewController alloc]initWithImage:theImage ];

            //BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
            //[controller.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
            [[controller navigationController]pushViewController:commentController animated:NO];
            commentController=nil;
        }
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

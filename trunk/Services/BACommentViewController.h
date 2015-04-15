//
//  BACommentViewController.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h> 
#import "BFDrawHeader.h"
#import "BADefinition.h"
#import "BFHeaderViewDelegate.h"
#import "BFAppReportViewController.h"
@interface BACommentViewController : UIViewController
<
UITextViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
MFMailComposeViewControllerDelegate,
UIActionSheetDelegate,
BFHeaderViewDelegate,
BFAppReportDelegate
>
{
    BFDrawHeader *header;
    NSArray *tabeleData;
}
@property (strong, nonatomic) IBOutlet UIImageView *screenshot;
-(id)initWithImage:(UIImage*)image;
@end

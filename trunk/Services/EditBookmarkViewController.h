//
//  EditBookmarkViewController.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 03/03/12.
//  Copyright 2012 CodeIsALie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkObject.h"

@interface EditBookmarkViewController : UITableViewController<UITextFieldDelegate, UIActionSheetDelegate> {
    BookmarkObject *bookmark;
    UITextField *nameTextField;
    UITextField *indexTextField;
}

@property (retain,nonatomic) BookmarkObject *bookmark;

- (void)save;

@end

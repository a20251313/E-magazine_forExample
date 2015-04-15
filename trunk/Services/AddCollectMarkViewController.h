//
//  AddBookmarkViewController.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectmarkObject.h"
#import "BFAppDelegate.h"

@interface AddCollectMarkViewController : UITableViewController<UITextFieldDelegate, UIActionSheetDelegate> {
    NSMutableArray *collectmarksArray;
    CollectmarkObject *collectmark;
    UITextField *nameTextField;
    BFAppDelegate *del;
}

@property (assign,nonatomic) id delegate;
@property (retain,nonatomic) CollectmarkObject *collectmark;

- (void)setBookmark:(NSString *)aName andNumber:(NSString *)aNumber;
@end

@protocol AddCollectmarkDelegate <NSObject>
- (void)dismissAddBookmMarkViewController:(AddCollectMarkViewController *)viewController;
@end


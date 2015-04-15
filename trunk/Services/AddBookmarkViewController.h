//
//  AddBookmarkViewController.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkObject.h"
#import "BFAppDelegate.h"

@interface AddBookmarkViewController : UITableViewController<UITextFieldDelegate, UIActionSheetDelegate> {
    NSMutableArray *bookmarksArray;
    BookmarkObject *bookmark;
    UITextField *nameTextField;
    BFAppDelegate *del;
}

@property (assign,nonatomic) id delegate;
@property (retain,nonatomic) BookmarkObject *bookmark;
@property (retain,nonatomic) NSString *strBookMark;

- (void)setBookmark:(NSString *)aName andNumber:(NSString *)aNumber;

@end

@protocol AddBookmarkDelegate <NSObject>
- (void)dismissAddBookmMarkViewController:(AddBookmarkViewController *)viewController;
@end

//
//  ViewBookmarkViewController.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkObject.h"

@interface ViewBookmarkViewController : UITableViewController<UITextFieldDelegate> {
    UIBarButtonItem *doneButtonItem;
    NSMutableArray *bookmarksArray;
    BookmarkObject *bookmark;
}

@property (assign,nonatomic) id delegate;
@property (copy,nonatomic) UIBarButtonItem *doneButtonItem;
@property (copy,nonatomic) BookmarkObject *bookmark;
@property (copy,nonatomic) NSString *strBookMark;

- (void)setBookmark:(NSString *)aName andNumber:(NSString *)aNumber;
- (void)doneButtonAction;
- (void)saveBookmarks;
@end

@protocol ViewBookmarkDelegate <NSObject>
- (void)scrollViewToIndex:(int)index;
- (void)openThisURL:(NSURL *)url;
- (void)dismissViewBookmMarkViewController:(ViewBookmarkViewController *)viewController;
@end

//
//  ViewBookmarkViewController.m
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import "ViewBookmarkViewController.h"
#import "EditBookmarkViewController.h"

@implementation ViewBookmarkViewController

@synthesize delegate;
@synthesize doneButtonItem;
@synthesize bookmark;
@synthesize strBookMark;
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setContentSizeForViewInPopover:)])
    {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.title = @"已收藏的书签";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                           target:self
                                           action:@selector(editButtonAction)];
        self.navigationItem.rightBarButtonItem = editButtonItem;
        editButtonItem = nil;
    }
    else
    {
        self.doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonAction)];
        self.navigationItem.rightBarButtonItem = doneButtonItem;
        NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:9];
        UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]
                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                    target:nil
                                                    action:nil];
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                           target:self
                                           action:@selector(editButtonAction)];
        [buttons addObject:editButtonItem];
        [buttons addObject:flexibleSpaceButtonItem];
        self.doneButtonItem = nil;
        flexibleSpaceButtonItem = nil;
        editButtonItem = nil;
        [self setToolbarItems:buttons];
        [self.navigationController setToolbarHidden:NO animated:NO];
    }
    
    // get bookmarks from userDefaults
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSData * bookmarks = [defaults objectForKey:strBookMark];
    if (bookmarks) {
        bookmarksArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:bookmarks]];
    } else {
        bookmarksArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self saveBookmarks];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark Buttons methods

- (void)doneButtonAction {
    [self saveBookmarks];
    [delegate dismissViewBookmMarkViewController:self];
}

- (void)editButtonAction {
    [self.tableView setEditing:YES animated:YES];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *doneEditingButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:
                                                  UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(doneEditingButtonAction)];
        self.navigationItem.rightBarButtonItem = doneEditingButtonItem;
        doneEditingButtonItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
        NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:9];
        UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]
                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                    target:nil
                                                    action:nil];
        UIBarButtonItem *doneEditingButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(doneEditingButtonAction)];
        [buttons addObject:doneEditingButtonItem];
        [buttons addObject:flexibleSpaceButtonItem];
        flexibleSpaceButtonItem = nil;
        doneEditingButtonItem = nil;
        [self setToolbarItems:buttons];
    }
}
- (void)doneEditingButtonAction {
    [self.tableView setEditing:NO animated:YES];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                        target:self
                                                                                        action:@selector(editButtonAction)];
        self.navigationItem.rightBarButtonItem = editButtonItem;
        editButtonItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = doneButtonItem;
        
        NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:9];
        UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                                 target:nil
                                                                                                 action:nil];
        UIBarButtonItem *doneEditingButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                               target:self
                                                                                               action:@selector(editButtonAction)];
        [buttons addObject:doneEditingButtonItem];
        [buttons addObject:flexibleSpaceButtonItem];
        flexibleSpaceButtonItem = nil;
        doneEditingButtonItem = nil;
        [self setToolbarItems:buttons];
    }
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [bookmarksArray count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [bookmarksArray removeObjectAtIndex:indexPath.row];
        [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                               withRowAnimation:UITableViewRowAnimationFade];
        [self saveBookmarks];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *LabelCellIdentifier = @"LabelCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:LabelCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelCellIdentifier];
    }
    
    bookmark = [bookmarksArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setText:bookmark.name];
    cell.imageView.image = [UIImage imageNamed:@"Bookmark.png"];
    cell.imageView.highlightedImage = [UIImage imageNamed:@"BookmarkSelected.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing)
    {
        EditBookmarkViewController *editBookmarkViewController = [[EditBookmarkViewController alloc] initWithStyle:UITableViewStyleGrouped];
        bookmark = [bookmarksArray objectAtIndex:indexPath.row];
        [editBookmarkViewController setBookmark:[bookmarksArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:editBookmarkViewController animated:YES];
        editBookmarkViewController = nil;
    }
    else
    {
        bookmark = [bookmarksArray objectAtIndex:indexPath.row];
        
        if ([self.delegate respondsToSelector:@selector(scrollViewToIndex:)]) {
            [delegate scrollViewToIndex:[bookmark.pageNumber intValue]];
        }
        
        [self saveBookmarks];
        [delegate dismissViewBookmMarkViewController:self];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	BookmarkObject *bookmarkToMove = [bookmarksArray objectAtIndex:sourceIndexPath.row];
	[bookmarksArray removeObjectAtIndex:sourceIndexPath.row];
	[bookmarksArray insertObject:bookmarkToMove atIndex:destinationIndexPath.row];
	bookmarkToMove = nil;
	[self saveBookmarks];
}

- (void)saveBookmarks {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:bookmarksArray] forKey:strBookMark];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setBookmark:(NSString *)aName andNumber:(NSString *)aNumber{
    bookmark = [[BookmarkObject alloc] initWithName:aName andNumber:aNumber];
}

-(void) viewDidUnload{
    self.delegate = nil;
    self.tableView = nil;
    self.tabBarItem =  nil;
    self.doneButtonItem = nil;
    self.bookmark = nil;
    bookmarksArray = nil;
}
//-(void)dealloc{
//    self.doneButtonItem = nil;
//    [self.doneButtonItem release];
//    self.bookmark = nil;
//    [self.bookmark release];
//    self.strBookMark = nil;
//    [self.strBookMark release];
//}
@end


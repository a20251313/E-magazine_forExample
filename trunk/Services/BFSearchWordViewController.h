//
//  BFSearchWordViewController.h
//  E-magazine
//
//  Created by mike.sun on 3/21/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"
#import "BFHeaderViewDelegate.h"
#import "ViewControllerAndPage.h"

@protocol BFSearchWordDelegate;

@interface BFSearchWordViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *resultArray;
}
@property (retain,nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UITableView *SeachTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *wordSearchBar;
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic) NSMutableArray *switchDataArray;
@property (nonatomic, retain) NSMutableDictionary *dicSearchSource;
@property (nonatomic, retain) NSMutableArray *arrSearchKeys;
@property (nonatomic, retain) NSMutableArray *arrPages;
@property (nonatomic, strong) NSString *strSearchWord;

@end

@protocol BFSearchWordDelegate <NSObject>

@optional
- (void)scrollViewToIndex2:(NSInteger)iRow;
- (void)showMiniSearchView;
- (void)dismissViewSearchWordViewController:(BFSearchWordViewController *)viewController;
- (NSDictionary*)searchWordInPage:(NSString *) keyword searchContent:(NSString *)searchContent;
- (void)needRedraw:(NSDictionary *)dic;
@end

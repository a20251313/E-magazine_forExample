//
//  UIGridViewRow.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridView.h"

@protocol GridViewRowDelegate;

@interface UIGridViewRow : UITableViewCell
<
GribViewDelegate
>{

}
@property (nonatomic, retain) IBOutlet UIImageView *imageViewShell;
@property (nonatomic, retain) NSMutableArray *arrBooks;
@property (nonatomic, assign) id<GridViewRowDelegate> delegate;
@property (nonatomic) NSInteger iRow;

@end

@protocol GridViewRowDelegate <NSObject>

@optional
- (void)didPressedGrid:(Position *)pos;

@end

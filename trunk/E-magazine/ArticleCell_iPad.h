//
//  ArticleCell_iPad.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/21/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArticleTitleLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface ArticleCell_iPad : UITableViewCell
{
    UIImageView *thumbnail;
    ArticleTitleLabel *titleLabel;
}

@property (nonatomic, retain) UIImageView *thumbnail;
@property (nonatomic, retain) ArticleTitleLabel *titleLabel;

@end

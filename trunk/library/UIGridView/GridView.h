//
//  GridView.h
//  E-magazine
//
//  Created by summer.zhu on 5/24/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCover.h"

@interface Position : NSObject

@property(nonatomic) NSInteger iRow;
@property(nonatomic) NSInteger iCol;

@end

@protocol GribViewDelegate;

@interface GridView : UIView{
    IBOutlet UILabel *lblBookName;
    IBOutlet UIImageView *imageViewBook;
}
@property(nonatomic, retain) BookCover *bookCover;
@property(nonatomic, retain) Position *pos;
@property(nonatomic, assign) id<GribViewDelegate> delegate;

- (IBAction)didPressedBtn:(id)sender;

@end

@protocol GribViewDelegate <NSObject>

@optional
- (void)didPressedBtn:(Position *)position;

@end

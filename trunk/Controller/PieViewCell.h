//
//  PieViewCell.h
//  E-magazine
//
//  Created by summer.zhu on 5/3/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieViewCell : UITableViewCell{
    IBOutlet UILabel *lblType;
    IBOutlet UILabel *lblValue;
    IBOutlet UIImageView *imageviewBg;
}

@property (nonatomic) BOOL bSelected;
@property (nonatomic, strong) NSString *strType;
@property (nonatomic, strong) NSString *strValue;

@end

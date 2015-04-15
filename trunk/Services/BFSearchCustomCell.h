//
//  BFSearchCustomCell.h
//  E-magazine
//
//  Created by mike.sun on 3/14/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFSearchCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *number;
@end

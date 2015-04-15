//
//  PieViewCell.m
//  E-magazine
//
//  Created by summer.zhu on 5/3/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "PieViewCell.h"

@implementation PieViewCell
@synthesize bSelected;
@synthesize strType;
@synthesize strValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStrType:(NSString *)_strType{
    strType = _strType;
    lblType.text = self.strType;
}

- (void)setStrValue:(NSString *)_strValue{
    strValue = _strValue;
    lblValue.text = self.strValue;
}

- (void)setBSelected:(BOOL)_bSelected{
    bSelected = _bSelected;
    if (bSelected) {
        imageviewBg.image = [UIImage imageNamed:@"pieCellSelect.png"];
        CGRect rect = imageviewBg.frame;
        rect.origin.x = 0;
        rect.size.width = 465;
        imageviewBg.frame = rect;
    }else{
        imageviewBg.image = [UIImage imageNamed:@"pieCellBg.png"];
        CGRect rect = imageviewBg.frame;
        rect.origin.x = 17;
        rect.size.width = 448;
        imageviewBg.frame = rect;
    }
}

@end

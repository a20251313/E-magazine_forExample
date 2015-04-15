//
//  BAMicroGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAMicroGraphGroup.h"
#import "BAMicroCell.h"
#import "BAMicroGraph.h"

@implementation BAMicroGraphGroup
@synthesize myTableView;
@synthesize graphs;
@synthesize title;
@synthesize delegate;



- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"BAMicroCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"BAMicroCell"];
        nibsRegistered = YES;
    }
    BAMicroCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BAMicroCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BAMicroCell" owner:self options:nil] objectAtIndex:0];
    }
    [cell setBounds:CGRectMake(0, 0*indexPath.row, self.frame.size.width, 40)];
    cell.backgroundColor=[UIColor grayColor];
    cell.entity.text=[[graphs objectAtIndex:indexPath.row] city];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    //NSLog(@"%@",[graphs.allKeys objectAtIndex:indexPath.row]);

    [[graphs objectAtIndex:indexPath.row] renderInHostView:cell.hostView];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return graphs.count;
}

/*-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return title;
}*/

//微图代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(microGraphGroup:didSelectRowAtIndexPath:)])
    {
        [delegate microGraphGroup:self didSelectRowAtIndexPath:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}
-(void)renderTable
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

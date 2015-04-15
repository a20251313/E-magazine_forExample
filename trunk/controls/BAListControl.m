//
//  BAListControl.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAListControl.h"

@implementation BAListControl
@synthesize myTableView;
@synthesize hostView;
@synthesize popover;
@synthesize button;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return graphs.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [baseGraph renderInHostView:hostView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    BAReport *report=[graphs objectAtIndex:indexPath.row];
    [[cell textLabel] setText:report.reportName];
    return cell;
}
-(void)showPopover
{
    UITableViewController* vc = [[UITableViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    
    [[vc tableView] setDataSource:self];
    [[vc tableView] setDelegate:self];
    popover=[[UIPopoverController alloc]initWithContentViewController:vc];
    popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    popover.popoverContentSize=CGSizeMake(200, 120);
    [popover presentPopoverFromRect:button.frame  inView:hostView permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
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

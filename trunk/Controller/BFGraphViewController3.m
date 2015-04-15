//
//  BFGraphViewController3ViewController.m
//  E-magazine
//
//  Created by yann.cai on 5/9/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFGraphViewController3.h"
#import "BAColorHelper.h"
#import "BADefinition.h"
#import "BFGraph3Cell.h"
#import "BFAppDelegate.h"
#import "Global.h"
#import "BAMixGraph4.h"
#import "BFGraph3Button.h"

#define BASETAG 10000
@interface BFGraphViewController3 ()

@end

@implementation BFGraphViewController3
{
    BADocument *document;
    BAMixGraph4 *graph;
    BAReport *myReport;
    NSInteger dimensionIndex;
    NSInteger index;
    NSArray *models;
    NSMutableArray *status;
}
@synthesize hostView,myTableView,myScrollView;
#pragma mark - system method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidUnload
{
    
    
    [self setMyTableView:nil];
    [self setMyScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    //从数据源获取document
    document=[documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000"]];
    BAReport *report=[document.reports objectAtIndex:63];
    //int dataCount=report.reportData.entity.entityValues.count;
    myReport=report;
    
    NSArray *regionArr=[NSArray arrayWithObjects:@"华东",@"中南",@"华北",@"东北",@"西南",@"西北", nil];
    NSArray *productArr=[NSArray arrayWithObjects:@"图书音像",@"家用电器",@"手机数码",@"家居家具家装厨具",@"服饰鞋帽",@"食品饮料",@"运动健康", nil];
    NSArray *ageArr=[NSArray arrayWithObjects:@"20以下",@"20-30",@"30-40",@"40-50",@"50-60",@"60以上", nil];
    models=[NSArray arrayWithObjects:regionArr,productArr,ageArr, nil];
    
    //NSArray *regionStatus=[NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0], nil];
    
    index=0;
    dimensionIndex=0;
    NSIndexPath *tempIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [myTableView selectRowAtIndexPath:tempIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self renderGraph];
    [self reloadButton];
}
#pragma mark - custom method
-(void)highlightButton:(UIButton*)sender
{
    [sender setHighlighted:YES];
    
}
-(void)selectRect:(BFGraph3Button*)sender
{
    index=sender.tag-BASETAG;
    [status replaceObjectAtIndex:dimensionIndex withObject:[NSNumber numberWithInt:index]];
    for (id view in sender.superview.subviews) {
        if ([view isKindOfClass:[BFGraph3Button class]]&&view!=sender) {
            BFGraph3Button *btn=(BFGraph3Button*)view;
            btn.valueLabel.textColor=[BAColorHelper stringToUIColor:@"05e1ef" alpha:@"1"];
            [btn setHighlighted:NO];
        }else if(view==sender)
        {
            BFGraph3Button *btn=(BFGraph3Button*)view;
            btn.valueLabel.textColor=[BAColorHelper stringToUIColor:@"13e628" alpha:@"1"];
        }
    }
    [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
    
    NSArray *array=[models objectAtIndex:dimensionIndex];
    
    NSIndexPath *tempIndexPath=[NSIndexPath indexPathForRow:dimensionIndex inSection:0];
    BFGraph3Cell *cell=(BFGraph3Cell*)[myTableView cellForRowAtIndexPath:tempIndexPath];
    cell.valueLabel.text=[array objectAtIndex:index];
    [self renderGraph];
    //[sender setHighlighted:YES];
}
-(void)reloadButton
{
    for (int i=0; i<myScrollView.subviews.count; i++) {
        [[myScrollView.subviews objectAtIndex:i] removeFromSuperview];
    }
    NSArray *array=[models objectAtIndex:dimensionIndex];
    [myScrollView setContentSize:CGSizeMake(196*array.count, 94)];
    BAMetric *metric=[myReport.reportData.metrics objectAtIndex:0];
    
    for (int i=0; i<array.count; i++) {
        double value=[[metric.dataValues objectAtIndex:i] doubleValue];
        value=value*(arc4random()%8+5)*0.1;
        BFGraph3Button *button=(BFGraph3Button*)[[[NSBundle mainBundle]loadNibNamed:@"BFGraph3Button" owner:self options:nil]lastObject];
        [button setTag:i+BASETAG];
        button.frame=CGRectMake(i*196, 0, 196,94);
        [button setBackgroundImage:[UIImage imageNamed:@"graph3-button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"graph3-button-selected"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectRect:) forControlEvents:UIControlEventTouchUpInside];
        button.nameLabel.text=[array objectAtIndex:i];
        button.valueLabel.text=[NSString stringWithFormat:@"%.2f",value];
        if (i==[[status objectAtIndex:dimensionIndex] intValue]) {
            [button setHighlighted:YES];
            button.valueLabel.textColor=[BAColorHelper stringToUIColor:@"13e628" alpha:@"1"];
        }
        [myScrollView addSubview:button];
        
    }
}
-(void)renderGraph
{
    //BAReport *report=[document.reports objectAtIndex:arc4random()%2];
    graph=[[BAMixGraph4 alloc]init];
    //graph->selectedIndex=2;
    [graph configurePlots:myReport];
    
    [graph renderInHostView:[self hostView]];
}
-(void)backHome
{
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    [self.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    document=nil;
    graph=nil;
    
    myReport=nil;
    
}
-(IBAction)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)didSelectCell:(UIPanGestureRecognizer*)sender
{
    BFGraph3Cell *cell= (BFGraph3Cell*)sender.view;
    [myTableView selectRowAtIndexPath:cell.indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFGraph3Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=(BFGraph3Cell*)[[[NSBundle mainBundle]loadNibNamed:@"BFGraph3Cell" owner:self options:nil]lastObject];
    }
    cell.indexPath=indexPath;
//    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectCell:)];
//    [cell addGestureRecognizer:panGesture];
    UIImageView *selectedBgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graph3-table-selected"]];
    cell.selectedBackgroundView=selectedBgView;
    NSString *name;
    
    switch (indexPath.row) {
        case 0:
        {
            name=@"区域";
            
            break;
        }
        case 1:
        {
            name=@"产品";
            break;
        }
        case 2:
        {
            name=@"年龄段";
            break;
        }
    }
    cell.nameLabel.text=name;
    NSArray *array=[models objectAtIndex:indexPath.row];
    cell.valueLabel.text=[array objectAtIndex:index];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i=0; i<3; i++) {
        NSIndexPath *tempIndexPath=[NSIndexPath indexPathForRow:i inSection:0];
        BFGraph3Cell *cell=(BFGraph3Cell*)[tableView cellForRowAtIndexPath:tempIndexPath];
        if (indexPath.row==i) {
            cell.nameLabel.font=[UIFont boldSystemFontOfSize:17];
            cell.nameLabel.textColor=[UIColor whiteColor];
            cell.valueLabel.font=[UIFont boldSystemFontOfSize:17];
            cell.valueLabel.textColor=[BAColorHelper stringToUIColor:@"11e727" alpha:@"1"];
        }else
        {
            cell.nameLabel.font=[UIFont systemFontOfSize:17];
            cell.nameLabel.textColor=[BAColorHelper stringToUIColor:@"044364" alpha:@"1"];
            cell.valueLabel.font=[UIFont systemFontOfSize:17];
            cell.valueLabel.textColor=[UIColor whiteColor];
        }
    }
    dimensionIndex=indexPath.row;
    [self reloadButton];
[self renderGraph];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
}

//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

@end

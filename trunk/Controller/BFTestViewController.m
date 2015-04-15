//
//  BFTestViewController.m
//  E-magazine
//
//  Created by Yann on 13-1-25.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFTestViewController.h"
#import "BADocumentButton.h"
#import "BAColorHelper.h"
#import "BADefinition.h"
#import "BATestCell.h"
#import "BAMixGraph3.h"
#import "BFGraph2Cell.h"
#import "BAMicroGraph4.h"
@interface BFTestViewController ()

@end

@implementation BFTestViewController
{
    BADocument *document;
    BAMicroGraph4 *graph;
}
@synthesize hostView;
@synthesize imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    //从数据源获取document
    document=[documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionary:@"000008"]];
    //BAReport *report=[document.reports objectAtIndex:0];
    BAReport *report=[document.reports objectAtIndex:4];
    graph=[[BAMicroGraph4 alloc]init];
    //graph->selectedIndex=2;
    [graph configure:report];
    imageView.image=[graph microImage];
    
    //[graph renderInHostView:[self hostView]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end

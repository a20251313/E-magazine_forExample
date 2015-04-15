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
@interface BFTestViewController ()

@end

@implementation BFTestViewController
{
    BADocument *document;
    BAMixGraph3 *graph;
}
@synthesize hostView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    graph=[[BAMixGraph3 alloc]init];
    //graph->selectedIndex=2;
    [graph configurePlots:report];
    
    [graph renderInHostView:[self hostView]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

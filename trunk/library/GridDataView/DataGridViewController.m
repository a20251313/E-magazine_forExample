//
//  DataGridViewController.m
//  IRnovationBI
//
//  Created by 顾民 on 12-11-4.
//
//

#import "DataGridViewController.h"

@interface DataGridViewController ()

@end

@implementation DataGridViewController

-(id)initWithDataResource:(DataGridComponentDataSource*)ds withRect:(CGRect)rt
{
    self = [super init];
    if (self) {
        component = [[DataGridComponent alloc] initWithFrame:rt data:ds isLinkable:NO];
        [[self view] addSubview:component];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

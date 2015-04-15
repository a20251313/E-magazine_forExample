//
//  BFScrollViewController.m
//  BizFocus-periodical
//
//  Created by Yann on 13-1-23.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFScrollViewController.h"
#import "BFHeaderView.h"
#import "BFFootView.h"
#import "FTCoreTextView.h"
@interface BFScrollViewController ()
{
    BAScrollView *scrollView;
    BFFootView *footer;
    BFHeaderView *header;
}
@end

@implementation BFScrollViewController
@synthesize scrollView;
//- (IBAction)test:(UIButton *)sender {
//    [scrollView scrollToPage:2];
//}
#pragma mark -
#pragma mark scroll datasource
-(NSInteger)numberOfPage
{
    return 10;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    NSInteger page=offsetofScrollView.x / scrollView1.frame.size.width ;
    
    footer.pageLabel.text=[NSString stringWithFormat:@"%d",page+1];
    if (page!=scrollView.currentPage) {
        scrollView.currentPage=page;
        //[scrollView renderContent];
    }
    
    
}
-(void)didScrollToPage:(BAScrollView *)scrollView page:(NSInteger)page
{
    footer.pageLabel.text=[NSString stringWithFormat:@"%d",page+1];
}
#pragma mark -
#pragma mark system method
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
        //scrollView.frame=CGRectMake(0, 0, 1024, 768);
        //header.frame=CGRectMake(0, 0, self.view.frame.size.width,50);
    }else
    {
        //header.frame=CGRectMake(0, 0, self.view.frame.size.width,50);
        //scrollView.frame=CGRectMake(0, 0, 768, 1024);
    }
    
    [self.scrollView adjust];
    //[self.scrollView renderContent];
    //[header adjust];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollView=[[BAScrollView alloc]initWithFrame:self.view.bounds];
//    BFHeaderView *header=[[BFHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    header=[[[NSBundle mainBundle] loadNibNamed:@"BFHeaderView" owner:nil options:nil]lastObject];
    header.frame=CGRectMake(0, 0, self.view.frame.size.width,50);
    //[header adjust];
    [self.view addSubview:header];
    footer=[[[NSBundle mainBundle] loadNibNamed:@"BFFootView" owner:nil options:nil]lastObject];
    footer.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width,50);
    [self.view addSubview:footer];
    scrollView.delegate=self;
    scrollView.dataSource=self;
    scrollView.myDelegate=self;
    [scrollView configure];
    
    [scrollView renderContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end

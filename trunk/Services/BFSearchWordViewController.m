//
//  BFSearchWordViewController.m
//  E-magazine
//
//  Created by mike.sun on 3/21/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFSearchWordViewController.h"
#import "BFSearchCustomCell.h"

@interface BFSearchWordViewController ()
@end

@implementation BFSearchWordViewController
@synthesize delegate;
@synthesize SeachTableView;
@synthesize wordSearchBar;
@synthesize resultArray;
@synthesize switchDataArray;
@synthesize dicSearchSource;
@synthesize arrSearchKeys;
@synthesize arrPages;
@synthesize strSearchWord;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.frame = CGRectMake(0, 0, 543, 306);
}
- (void)viewDidLoad
{
    resultArray = [[NSMutableArray alloc] init];
    switchDataArray = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"markWord"]) {
        wordSearchBar.text = [defaults objectForKey:@"markWord"];
        [self SearchWordFirst:[defaults objectForKey:@"markWord"]];
    }
    [super viewDidLoad];
}
-(void)SearchWordFirst:(NSString *)keyWord{
    self.strSearchWord = keyWord;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:keyWord forKey:@"markWord"];
    [resultArray removeAllObjects];
    [switchDataArray removeAllObjects];
    
    for (int i=0; i<[dicSearchSource count]; i++) {
        NSString *str = [arrSearchKeys objectAtIndex:i];
        NSDictionary *dic = [self searchWordInPage:keyWord searchContent:str];
        if ([[dic allKeys] count] > 0) {
            [resultArray addObject:dic];
            ViewControllerAndPage *vcAndPage = (ViewControllerAndPage *)[dicSearchSource objectForKey:str];
            [switchDataArray addObject:vcAndPage];
        }
    }
    [SeachTableView reloadData];
}
-(NSDictionary*)searchWordInPage:(NSString *) keyword searchContent:(NSString *)searchContent{
    NSString *searchData = searchContent;
    NSString *string1 = searchData;
    NSString *string2 = keyword;
    int indexMark;
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSRange range = [string1 rangeOfString:string2];
    int location = range.location;
    int leight = range.length;
    indexMark = location;
    
    for (int i=indexMark;i<searchData.length;i=indexMark) {
        if((location<string1.length)&&(leight>0)) {
            NSString *tempStr = [NSString stringWithFormat:@"%d",i];
            NSString *tempStr2 = [NSString stringWithFormat:@"%d",leight];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:tempStr2,tempStr,nil];
            
            string1 = [string1 substringFromIndex:(location+leight)];
            range = [string1 rangeOfString:string2];
            location = range.location;
            leight = range.length;
            indexMark = location+indexMark+range.length;
            [tempArr addObject:dic];
        }
    }
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (tempArr.count > 0) {
        [result setValue:tempArr forKey:[searchData substringToIndex:25]];
    }
//    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:tempArr, [searchData substringToIndex:25],nil];
    return  result;
}

-(void)viewDidUnload{
    self.SeachTableView = nil;
    self.wordSearchBar = nil;
    self.resultArray = nil;
    self.switchDataArray = nil;
    self.dicSearchSource = nil;
    self.arrSearchKeys = nil;
    self.arrPages = nil;
    [super viewDidUnload];
}
#pragma mark Search

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self SearchWordFirst:searchText];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark Table View Data Source Methods
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultArray count];
}

//新建某一行并返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"BFSearchCustomCell";
    
//    UINib *nib = [UINib nibWithNibName:@"BFSearchCustomCell" bundle:nil];
//    [tableView registerNib:nib forCellReuseIdentifier:TableSampleIdentifier];
//    
//    BFSearchCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:
//                                TableSampleIdentifier];
//    if (cell == nil) {
//        cell = [[BFSearchCustomCell alloc]
//                initWithStyle:UITableViewCellStyleDefault
//                reuseIdentifier:TableSampleIdentifier];
//    }

    BFSearchCustomCell *cell = (BFSearchCustomCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"BFSearchCustomCell" owner:self options:nil];
        for (id nib in nibs) {
            if ([nib isKindOfClass:[BFSearchCustomCell class]]) {
                cell = nib;
            }
        }
    }
    NSUInteger row = [indexPath row];
    cell.title = [[[resultArray objectAtIndex:row] allKeys] objectAtIndex:0];
    cell.number= [NSString stringWithFormat:@"%d", [[[resultArray objectAtIndex:row] objectForKey:cell.title] count] ];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (int i=0; i<arrPages.count; i++) {
        Page *page = (Page *)[arrPages objectAtIndex:i];
        [page setText:strSearchWord];
    }
    if ([self.delegate respondsToSelector:@selector(scrollViewToIndex2:)]) {
        [self.delegate scrollViewToIndex2:indexPath.row];
    }
    [delegate dismissViewSearchWordViewController:self];
    [delegate showMiniSearchView];
}
@end

//
//  HorizontalTableCell.m
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import "HorizontalTableCell.h"
#import "ArticleCell_iPad.h"
#import "ArticleTitleLabel.h"
#import "ControlVariables.h"

@implementation HorizontalTableCell

@synthesize horizontalTableView;
@synthesize articles;
@synthesize categoryName;
@synthesize selectedData;
#pragma mark - Table View Data Source
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray*)data andCategory:(NSString*)category
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        del = (BFAppDelegate *)[[UIApplication sharedApplication] delegate];
        selectedData = [[NSMutableArray alloc]init];
        self.articles = [[NSArray alloc] init];
        self.categoryName = [[NSString alloc] init];
        self.articles = data;
        self.categoryName = category;
        if ([[del.selectedDataAll objectForKey:self.categoryName] count]!=0) {
            self.selectedData =  [del.selectedDataAll objectForKey:self.categoryName];
        }
        self.horizontalTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
        self.horizontalTableView.showsVerticalScrollIndicator = NO;
        self.horizontalTableView.showsHorizontalScrollIndicator = NO;
        self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.horizontalTableView setFrame:CGRectMake(kRowHorizontalPadding_iPad * 0.5, kRowVerticalPadding_iPad * 0.5, kTableLength_iPad2 - kRowHorizontalPadding_iPad, kCellHeight_iPad)];
        
        self.horizontalTableView.rowHeight = kCellWidth_iPad;
        self.horizontalTableView.backgroundColor = kHorizontalTableBackgroundColor;
        
        self.horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.horizontalTableView.separatorColor = [UIColor clearColor];
        
        self.horizontalTableView.dataSource = self;
        self.horizontalTableView.delegate = self;
        [self addSubview:self.horizontalTableView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    
    __block ArticleCell_iPad *cell = (ArticleCell_iPad *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[ArticleCell_iPad alloc] initWithFrame:CGRectMake(0, 0, kCellWidth_iPad, kCellHeight_iPad)] autorelease];
    }
    
    __block NSDictionary *currentArticle = [self.articles objectAtIndex:indexPath.row];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{
        UIImage *image = nil;
        image = [UIImage imageNamed:[currentArticle objectForKey:@"ImageName"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.thumbnail setImage:image];
        });
    });
    NSString *str=[NSString stringWithFormat:@"%d",indexPath.row];
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:str,str ,nil];

    if ([[del.selectedDataAll objectForKey:self.categoryName] containsObject:dict]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.titleLabel.text = [currentArticle objectForKey:@"Title"];
    return cell;
}
#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([del.selectedMark isEqualToString:@"delete state"]) {
        UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
        if (oneCell.accessoryType == UITableViewCellAccessoryNone) {
            oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else
            oneCell.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *str=[NSString stringWithFormat:@"%d",indexPath.row];
        NSDictionary *dict=[[[NSDictionary alloc]initWithObjectsAndKeys:str,str ,nil] autorelease];

        if([self isExistsByName:str theArray:self.selectedData theIndexPath:indexPath] == NO){
            [self.selectedData removeObject:dict];
        }else{
            [self.selectedData addObject:dict];
        }
        [del.selectedDataAll setValue:self.selectedData forKey:self.categoryName];

    }
    else{
        
    }
    
}
-(BOOL)isExistsByName:(NSString *)string theArray:(NSMutableArray *)array theIndexPath:(NSIndexPath*)indexPath{
    BOOL tempBool = YES;
    for (NSDictionary* aDic in array) {
        if ([[[aDic allKeys] objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
            tempBool = NO;
            break;
        }
    }
    return tempBool;
}

#pragma mark - Memory Management

- (NSString *) reuseIdentifier
{
    return @"HorizontalCellDef";
}

- (void)dealloc
{
    self.horizontalTableView = nil;
    [self.horizontalTableView release];
    self.articles = nil;
    [self.articles release];
    [super dealloc];
}
@end

//
//  BFGraphViewController4.m
//  E-magazine
//
//  Created by Yann on 13-1-28.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFTableViewController4 .h"
#import "BADefinition.h"
#import "BFGraph4LeftModel.h"
#import "BFTable4Cell.h"

@interface BFTableViewController4 ()
{
    NSMutableArray *list;
    BADocument *document;
    //BAMicroGraph4 *microGraph;
    
}
@end

@implementation BFTableViewController4
@synthesize leftTable=_leftTable;
@synthesize rightTable=_rightTable;
@synthesize topScrollView=_topScrollView;
@synthesize rightScrollView=_rightScrollView;

#pragma mark - custom methods
- (IBAction)backToGraph:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

#pragma mark - TableView DataSource Methods


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFGraph4LeftModel *leftModel=[list objectAtIndex:indexPath.row];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
    
    if ([tableView isEqual:_leftTable]) {
        static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier: SimpleTableIdentifier];
        }
        cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
        switch (leftModel.level) {
            case 1:
                cell.textLabel.text=[NSString stringWithFormat:@"    %@",[leftModel desc]];
                break;
            case 2:
                cell.textLabel.text=[NSString stringWithFormat:@"        %@",[leftModel desc]];
                break;
            default:
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[leftModel desc]];
                break;
        }
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *view = [[UIView alloc]initWithFrame:cell.bounds];
        cell.backgroundView=view;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        view.backgroundColor=[BAColorHelper stringToUIColor:leftModel.leftColor alpha:@"1"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
        
        return cell;
    } else {
        BFTable4Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=(BFTable4Cell*)[[[NSBundle mainBundle]loadNibNamed:@"BFTable4Cell" owner:self options:nil]lastObject];
        }
        cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
        cell.textLabel.text=[leftModel desc];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *view = [[UIView alloc]initWithFrame:cell.bounds];
        cell.backgroundView=view;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        view.backgroundColor=[BAColorHelper stringToUIColor:leftModel.rightColor alpha:@"1"];
        
        cell.salesLabel.text=[NSString stringWithFormat:@"%.1f",[leftModel.sales doubleValue]];
        cell.salesTargetLabel.text=[NSString stringWithFormat:@"%.1f",[leftModel.salesTarget doubleValue]];

        cell.stLabel.text=[NSString stringWithFormat:@"%.1f%%",[leftModel.salesT doubleValue]*100];
        cell.shLabel.text=[NSString stringWithFormat:@"%.1f%%",[leftModel.salesH doubleValue]*100];
        cell.profitLabel.text=[NSString stringWithFormat:@"%.1f%%",[leftModel.profit doubleValue]*100];
        cell.profitTargetLabel.text=[NSString stringWithFormat:@"%.1f%%",[leftModel.profitTarget doubleValue]*100];
        cell.ptLabel.text=[NSString stringWithFormat:@"%.1f%%",[leftModel.profitT doubleValue]*100];
        cell.phLabel.text=[NSString stringWithFormat:@"%.1f%%",[leftModel.profitH doubleValue]*100];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list.count;
}

#pragma mark - TableView Delegate Methods


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *nextIndex=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    
    NSMutableArray *insertIndexPaths=[[NSMutableArray alloc]init];
    //NSMutableArray *indexArray=[[NSMutableArray alloc]init];
    BFGraph4LeftModel *model=[list objectAtIndex:indexPath.row];
    if ([tableView isEqual:_leftTable]) {
        if (!model.isSelected) {
            for (int i=0; i<model.subModels.count; i++) {
                BFGraph4LeftModel *model2=[model.subModels objectAtIndex:i];
                [list insertObject:model2 atIndex:nextIndex.row+i ];
                NSIndexPath *index=[NSIndexPath indexPathForRow:nextIndex.row+i inSection:indexPath.section];
                [insertIndexPaths addObject:index];
            }
            if (model.subModels.count>0) {
                model.isSelected=YES;
            }
            
            model.showLevel++;
            [_leftTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationMiddle];
            [_rightTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationMiddle];
        }else
        {
            BOOL canDel=true;
            for (int i=0; i<model.subModels.count; i++) {
                BFGraph4LeftModel *model2=[model.subModels objectAtIndex:i];
                if (model2.isSelected) {
                    canDel=false;
                }
            }
            for (int i=0; i<model.subModels.count; i++) {
                BFGraph4LeftModel *model2=[model.subModels objectAtIndex:i];
                if (canDel) {
                    [list removeObject:model2 ];
                    NSIndexPath *index=[NSIndexPath indexPathForRow:nextIndex.row+i inSection:indexPath.section];
                    [insertIndexPaths addObject:index];
                }
                
            }
            if (canDel) {
                model.isSelected=NO;
                [_leftTable deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationMiddle];
                [_rightTable deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationMiddle];
            }
        }
    }
    
    
    
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_leftTable]) {
        self.rightTable.contentOffset = _leftTable.contentOffset;
    } else if([scrollView isEqual:_rightTable]){
        self.leftTable.contentOffset = _rightTable.contentOffset;
    }else if ([scrollView isEqual:_topScrollView]) {
        self.rightScrollView.contentOffset=_topScrollView.contentOffset;
    }else if([scrollView isEqual:_rightScrollView])
    {
        self.topScrollView.contentOffset=_rightScrollView.contentOffset;
    }
}
#pragma mark -
#pragma mark system method
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        BADocumentService *documentService=[[BADocumentService alloc]init];
        BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
        document=[documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000"]];
        
//        BAReport *report=[document.reports objectAtIndex:0];
//        BAReportData *reportData=report.reportData;
//        NSMutableArray *metrics=reportData.metrics;
//        BAEntity *entity=reportData.entity;
//        NSMutableArray *entityValues=entity.entityValues;
//        for (int i=0; i<entityValues.count;i++) {
//            BAMetric *metric=[metrics objectAtIndex:i];
//            BFGraph4LeftModel *model1=[[BFGraph4LeftModel alloc]init];
//            model1.desc=[entityValues objectAtIndex:i];
//            model1.level=0;
//            model1.leftColor=@"1b1d24";
//            model1.rightColor=@"2f3138";
//            NSMutableArray *list2=[[NSMutableArray alloc]init];
//            BAReport *report=[document.reports objectAtIndex:4];
//            BAReportData *reportData=report.reportData;
//            NSMutableArray *metrics=reportData.metrics;
//            BAEntity *entity=reportData.entity;
//            NSMutableArray *entityValues=entity.entityValues;
//            for (int j=0; j<entityValues.count; j++) {
//                BFGraph4LeftModel *model2=[[BFGraph4LeftModel alloc]init];
//                model2.desc=[entityValues objectAtIndex:i];
//                model2.level=1;
//                model2.leftColor=@"2e303a";
//                model2.rightColor=@"42444e";
//                NSMutableArray *list3=[[NSMutableArray alloc]init];
//                for (int k=0; k<5; k++) {
//                    BFGraph4LeftModel *model3=[[BFGraph4LeftModel alloc]init];
//                    model3.desc=[NSString stringWithFormat:@"三级%d",k];
//                    model3.level=2;
//                    model3.leftColor=@"4b515f";
//                    model3.rightColor=@"5f6573";
//                    [list3 addObject:model3];
//                }
//                model2.subModels=list3;
//                [list2 addObject:model2];
//            }
//            model1.subModels=list2;
        BFGraph4LeftModel *model2001=[[BFGraph4LeftModel alloc]initWithParams:@"手机" level:2   salesReport:[document.reports objectAtIndex:14] metricReport:[document.reports objectAtIndex:13] entityIndex:0];
        BFGraph4LeftModel *model2002=[[BFGraph4LeftModel alloc]initWithParams:@"MP3/MP4" level:2 salesReport:[document.reports objectAtIndex:16] metricReport:[document.reports objectAtIndex:15] entityIndex:0];
        BFGraph4LeftModel *model2003=[[BFGraph4LeftModel alloc]initWithParams:@"耳机" level:2 salesReport:[document.reports objectAtIndex:17] metricReport:[document.reports objectAtIndex:15] entityIndex:1];
        BFGraph4LeftModel *model2004=[[BFGraph4LeftModel alloc]initWithParams:@"零食" level:2 salesReport:[document.reports objectAtIndex:19] metricReport:[document.reports objectAtIndex:18] entityIndex:0];
        BFGraph4LeftModel *model2005=[[BFGraph4LeftModel alloc]initWithParams:@"酒精饮料" level:2 salesReport:[document.reports objectAtIndex:21] metricReport:[document.reports objectAtIndex:20] entityIndex:0];
        BFGraph4LeftModel *model2006=[[BFGraph4LeftModel alloc]initWithParams:@"软饮料" level:2 salesReport:[document.reports objectAtIndex:22] metricReport:[document.reports objectAtIndex:20] entityIndex:1];
        BFGraph4LeftModel *model2007=[[BFGraph4LeftModel alloc]initWithParams:@"衬衫" level:2 salesReport:[document.reports objectAtIndex:24] metricReport:[document.reports objectAtIndex:23] entityIndex:0];
        BFGraph4LeftModel *model2008=[[BFGraph4LeftModel alloc]initWithParams:@"西服" level:2 salesReport:[document.reports objectAtIndex:25] metricReport:[document.reports objectAtIndex:23] entityIndex:1];
        BFGraph4LeftModel *model2009=[[BFGraph4LeftModel alloc]initWithParams:@"针织衫" level:2 salesReport:[document.reports objectAtIndex:27] metricReport:[document.reports objectAtIndex:26] entityIndex:0];
        BFGraph4LeftModel *model2010=[[BFGraph4LeftModel alloc]initWithParams:@"裙子" level:2 salesReport:[document.reports objectAtIndex:28] metricReport:[document.reports objectAtIndex:26] entityIndex:1];
        BFGraph4LeftModel *model2011=[[BFGraph4LeftModel alloc]initWithParams:@"牛仔" level:2 salesReport:[document.reports objectAtIndex:29] metricReport:[document.reports objectAtIndex:26] entityIndex:2];
        
        BFGraph4LeftModel *model1001=[[BFGraph4LeftModel alloc]initWithParams:@"手机通讯" level:1 salesReport:[document.reports objectAtIndex:5] metricReport:[document.reports objectAtIndex:4] entityIndex:0];
        model1001.subModels=[NSMutableArray arrayWithObjects:model2001, nil];
        BFGraph4LeftModel *model1002=[[BFGraph4LeftModel alloc]initWithParams:@"时尚影音" level:1 salesReport:[document.reports objectAtIndex:6] metricReport:[document.reports objectAtIndex:4] entityIndex:1];
        model1002.subModels=[NSMutableArray arrayWithObjects:model2002,model2003 ,nil];
        BFGraph4LeftModel *model1003=[[BFGraph4LeftModel alloc]initWithParams:@"休闲食品" level:1 salesReport:[document.reports objectAtIndex:8] metricReport:[document.reports objectAtIndex:7] entityIndex:0];
        model1003.subModels=[NSMutableArray arrayWithObjects:model2004, nil];
        BFGraph4LeftModel *model1004=[[BFGraph4LeftModel alloc]initWithParams:@"酒饮冲调" level:1 salesReport:[document.reports objectAtIndex:9] metricReport:[document.reports objectAtIndex:7] entityIndex:1];
        model1004.subModels=[NSMutableArray arrayWithObjects:model2005,model2006, nil];
        BFGraph4LeftModel *model1005=[[BFGraph4LeftModel alloc]initWithParams:@"男装" level:1 salesReport:[document.reports objectAtIndex:11] metricReport:[document.reports objectAtIndex:10] entityIndex:0];
        model1005.subModels=[NSMutableArray arrayWithObjects:model2007,model2008, nil];
        BFGraph4LeftModel *model1006=[[BFGraph4LeftModel alloc]initWithParams:@"女装" level:1 salesReport:[document.reports objectAtIndex:12] metricReport:[document.reports objectAtIndex:10] entityIndex:0];
        model1006.subModels=[NSMutableArray arrayWithObjects:model2009,model2010,model2011, nil];
        
        BFGraph4LeftModel *model0001=[[BFGraph4LeftModel alloc]initWithParams:@"手机数码" level:0 salesReport:[document.reports objectAtIndex:1] metricReport:[document.reports objectAtIndex:0] entityIndex:0];
        model0001.subModels=[NSMutableArray arrayWithObjects:model1001,model1002, nil];
        BFGraph4LeftModel *model0002=[[BFGraph4LeftModel alloc]initWithParams:@"食品饮料" level:0 salesReport:[document.reports objectAtIndex:2] metricReport:[document.reports objectAtIndex:0] entityIndex:1];
        model0002.subModels=[NSMutableArray arrayWithObjects:model1003,model1004, nil];
        BFGraph4LeftModel *model0003=[[BFGraph4LeftModel alloc]initWithParams:@"服饰鞋帽" level:0 salesReport:[document.reports objectAtIndex:3] metricReport:[document.reports objectAtIndex:0] entityIndex:1];
        model0003.subModels=[NSMutableArray arrayWithObjects:model1005,model1006, nil];
        list=[NSMutableArray arrayWithObjects:model0001,model0002,model0003, nil];

//        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _topScrollView.contentSize=CGSizeMake(1310, _topScrollView.frame.size.height);
    _rightScrollView.contentSize=CGSizeMake(1310, _rightTable.frame.size.height);
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

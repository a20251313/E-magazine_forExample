//
//  DataGridViewController.h
//  IRnovationBI
//
//  Created by 顾民 on 12-11-4.
//
//

#import <UIKit/UIKit.h>
#import "DataGridComponent.h"

@interface DataGridViewController : UIViewController
{
    DataGridComponent* component;
}

-(id)initWithDataResource:(DataGridComponentDataSource*)ds withRect:(CGRect)rt;

@end

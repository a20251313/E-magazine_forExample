//
//  BaseAnnotationView.h
//  IRnovationBI
//
//  Created by 顾民 on 12-11-3.
//
//

#import <MapKit/MapKit.h>

@interface BaseAnnotationView : MKAnnotationView
{
    //用于显示指示图样
    UIImageView* rectView;
}

@end

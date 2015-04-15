//
//  BFRootViewController.m
//  E-magazine
//
//  Created by zhonghao zhang on 1/29/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import "BFRootViewController.h"
#import "BADefinition.h"


@interface BFRootViewController ()

@end

@implementation BFRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
//        plView = (PLView *)self.view;
//        plView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    plView = [[PLView alloc] initWithFrame:self.view.frame];
    plView.delegate=self;
    [self.view addSubview:plView];
    //[self.view sendSubviewToBack:plView];
    [self selectPanorama:0];
    // Do any additional setup after loading the view from its nib.
}

-(void)selectPanorama:(NSInteger)index
{
    NSObject<PLIPanorama> *panorama = nil;
    //Spherical2 panorama example (supports up 2048x1024 texture)
    if(index == 0)
    {
        panorama = [PLSpherical2Panorama panorama];
        [(PLSpherical2Panorama *)panorama setImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere2" ofType:@"jpg"]]];
    }
    //Spherical panorama example (supports up 1024x512 texture)
    else if(index == 1)
    {
        panorama = [PLSphericalPanorama panorama];
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere" ofType:@"jpg"]]]];
    }
    //Cubic panorama example (supports up 1024x1024 texture per face)
    else if(index == 2)
    {
        PLCubicPanorama *cubicPanorama = [PLCubicPanorama panorama];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_f" ofType:@"jpg"]]] face:PLCubeFaceOrientationFront];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_b" ofType:@"jpg"]]] face:PLCubeFaceOrientationBack];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_l" ofType:@"jpg"]]] face:PLCubeFaceOrientationLeft];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_r" ofType:@"jpg"]]] face:PLCubeFaceOrientationRight];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_u" ofType:@"jpg"]]] face:PLCubeFaceOrientationUp];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_d" ofType:@"jpg"]]] face:PLCubeFaceOrientationDown];
        panorama = cubicPanorama;
    }
    //Cylindrical panorama example (supports up 1024x1024 texture)
    else if(index == 3)
    {
        panorama = [PLCylindricalPanorama panorama];
        ((PLCylindricalPanorama *)panorama).isHeightCalculated = NO;
        [(PLCylindricalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere" ofType:@"jpg"]]]];
    }
    
    //Add  hotspots

    PLTexture *hotspotTexture1 = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"0" ofType:@"png"]]];
    PLTexture *hotspotTexture2 = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"]]];
    PLTexture *hotspotTexture3 = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"]]];
    
    PLHotspot *hotspot1 = [PLHotspot hotspotWithId:0 texture:hotspotTexture1 atv:10.0f ath:45.0f width:0.08f height:0.08f];
    PLHotspot *hotspot2 = [PLHotspot hotspotWithId:1 texture:hotspotTexture2 atv:0.0f ath:30.0f width:0.08f height:0.08f];
    PLHotspot *hotspot3 = [PLHotspot hotspotWithId:2 texture:hotspotTexture3 atv:0.0f ath:0.0f width:0.08f height:0.08f];
    
    [panorama addHotspot:hotspot1];
    [panorama addHotspot:hotspot2];
    [panorama addHotspot:hotspot3];
    
    [plView setPanorama:panorama];
}

//Hotspot event
-(void)view:(UIView<PLIView> *)pView didClickHotspot:(PLHotspot *)hotspot screenPoint:(CGPoint)point scene3DPoint:(PLPosition)position
{
    switch (hotspot.identifier) {
        case 0:{
            BFScrollViewController *Controller1=[[BFScrollViewController alloc]initWithNibName:@"BFScrollViewController" bundle:nil];
            Controller1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:Controller1 animated:YES completion:nil];
            [UIView commitAnimations];
        }
            break;
        case 1:{
            BFGraphViewController2 *Controller2=[[BFGraphViewController2 alloc]initWithNibName:@"BFGraphViewController2" bundle:nil];
            Controller2.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:Controller2 animated:YES completion:nil];
            [UIView commitAnimations];
        }
            break;
        case 2:{
            BFGraphViewController3 *Controller3=[[BFGraphViewController3 alloc]initWithNibName:@"BFGraphViewController3" bundle:nil];
            Controller3.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:Controller3 animated:YES completion:nil];
            [UIView commitAnimations];
        }
            break;
        default:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hotspot" message:[NSString stringWithFormat:@"You select the hotspot with ID %d", hotspot.identifier] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

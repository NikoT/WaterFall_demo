//
//  ViewController.m
//  WaterFall_demo
//
//  Created by sven on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "WaterfallView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    WaterfallView *w = [[WaterfallView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:w];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:12];
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:12];
    for (int i =1 ; i<12; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    }
    for (int i =1 ; i<12; i++) {
        [arr1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    }
    
    [w addWaterfallImages:arr];
    [w addWaterfallImages:arr1];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

//
//  WaterfallView.h
//  WaterFall_demo
//
//  Created by sven on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterfallView : UIScrollView{

    NSMutableArray *volumeArr;
    
    float imageViewWedth;
}
- (void)addWaterfallImages:(NSArray*)imageArr;
@end

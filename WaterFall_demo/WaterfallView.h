//
//  WaterfallView.h
//  WaterFall_demo
//
//  Created by sven on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterfallView : UIScrollView{

    NSMutableArray *volumeArr;  //存列数的数组
    
    float imageViewWedth;  //瀑布流图片一列宽
    
    NSMutableArray *waterfallArr;  //瀑布流所有图片的位置信息
    
    NSMutableArray *showedImageArr;// 当前显示的图片
    NSMutableArray *cacheArr; //缓存区图片
    
}
- (void)addWaterfallImages:(NSArray*)imageArr;
@end

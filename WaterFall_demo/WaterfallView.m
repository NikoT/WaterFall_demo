//
//  WaterfallView.m
//  WaterFall_demo
//
//  Created by sven on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaterfallView.h"

#define VOLUME_NUM 3
#define VOLUME_OFFSET 4
#define LINE_OFFSET 3

@implementation WaterfallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        waterfallArr = [[NSMutableArray alloc]init];
        showedImageArr = [[NSMutableArray alloc]init];
        volumeArr = [[NSMutableArray alloc]initWithCapacity:VOLUME_NUM];
        for (int i = 0; i<VOLUME_NUM; i++) {
            [volumeArr addObject:[NSNumber numberWithInt:0]];
        }
        imageViewWedth = (frame.size.width-(VOLUME_NUM-1)*VOLUME_OFFSET)/VOLUME_NUM;
    }
    return self;
}


- (void)addWaterfallImages:(NSArray*)imageArr{
    if (imageArr) {
        
        for (UIImage *image in imageArr) {
            float ratio = image.size.height/image.size.width;
            int height =  imageViewWedth*ratio;
            int vol = 0;
            int y = [[volumeArr objectAtIndex:0] intValue];
            for (int i = 0; i<[volumeArr count]; i++) {
                if ([[volumeArr objectAtIndex:i] intValue]<y) {
                    y = [[volumeArr objectAtIndex:i] intValue];
                    vol = i ; 
                }
            }
            [volumeArr replaceObjectAtIndex:vol withObject:[NSNumber numberWithInt:(y+height+LINE_OFFSET)]];
            
            int x = vol*(VOLUME_OFFSET+imageViewWedth);
            CGRect rect= CGRectMake(x, y, imageViewWedth, height);
            NSArray *rectArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:x], 
                                [NSNumber numberWithInt:y],
                                [NSNumber numberWithInt:height],
                                image,nil];
            [waterfallArr addObject:rectArr];
            
//            if (y>self.frame.size.height) {
//                continue;
//            }
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            [imageView setImage:image];
            [self addSubview:imageView];
            [showedImageArr addObject:imageView];
            
        }
        int yMax=[[volumeArr objectAtIndex:0] intValue];
        for (int i = 0; i<[volumeArr count]; i++) {
            if ([[volumeArr objectAtIndex:i] intValue]>yMax) {
                yMax = [[volumeArr objectAtIndex:i] intValue];
            }
        }
        [self setContentSize:CGSizeMake(self.frame.size.width, yMax)]; 
    }
}

- (void)reloadImageViews{
    for (UIImag eView *imageV in showedImageArr) {
        if () {
            
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[self reloadImageViews];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	[self reloadImageViews];
}

















#warning not use
- (NSArray*)imageArrProcessing:(NSArray*)imageArr{
    NSMutableArray *arr = [NSMutableArray array];
    for (UIImage *image in imageArr) {
        UIImage *scaledImage = [self strenchImage:image];
        [arr addObject:scaledImage];
    }
    return arr;
}


- (UIImage*)strenchImage:(UIImage*)image{
    CGSize size = CGSizeMake(imageViewWedth, imageViewWedth*image.size.height/image.size.width);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();  
    return newImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

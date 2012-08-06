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
        self.delegate = (id<UIScrollViewDelegate>)self;        
        waterfallArr = [[NSMutableArray alloc]init];
        showedImageArr = [[NSMutableArray alloc]init];
        cacheArr = [[NSMutableArray alloc]init];
#warning release
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
            NSArray *rectArr = [NSArray arrayWithObjects:
                                [NSNumber numberWithInt:x], 
                                [NSNumber numberWithInt:y],
                                [NSNumber numberWithInt:height],
                                image,nil];
            [waterfallArr addObject:rectArr];
            
            if (y>self.frame.size.height) {
                continue;
            }
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            imageView.tag = 100+[waterfallArr indexOfObject:rectArr];
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
    float offSet_Y = self.contentOffset.y;
    NSMutableArray *readyToRemove = [NSMutableArray array];
    for (UIImageView *imageV in showedImageArr) {
        if (imageV.frame.origin.y+imageV.frame.size.height<offSet_Y||imageV.frame.origin.y>offSet_Y+self.frame.size.height) {//已经划出view的图片
            [readyToRemove addObject:imageV];
        }
    }
    for (UIImageView *view in readyToRemove) {
        [showedImageArr removeObject:view];
        [view removeFromSuperview];
        [cacheArr addObject:view];
    }
    for (NSArray *imageArr in waterfallArr) {
        BOOL SHOWED;
        float image_Y = [[imageArr objectAtIndex:1]floatValue];
        float image_H = [[imageArr objectAtIndex:2]floatValue];
        if (image_Y+image_H<offSet_Y||image_Y>offSet_Y+self.frame.size.height) {
            SHOWED = NO;
        }else {
            SHOWED = YES;
            for (UIImageView *ima in showedImageArr) {
                if (ima.tag-100 == [waterfallArr indexOfObject:imageArr]) {
                    SHOWED=NO;
                }
            }
        }
        if (SHOWED) {
            UIImageView *needShowedView = [self getCacheCell];
            if (needShowedView) {
                [needShowedView setImage:nil];
            }else {
                needShowedView = [[UIImageView alloc]init];
            }
            needShowedView.frame = CGRectMake([[imageArr objectAtIndex:0]floatValue], [[imageArr objectAtIndex:1]floatValue], imageViewWedth, [[imageArr objectAtIndex:2]floatValue]);
            needShowedView.tag = 100+[waterfallArr indexOfObject:imageArr];
            needShowedView.image = [imageArr objectAtIndex:3];
            [self addSubview:needShowedView];
            [showedImageArr addObject:needShowedView];
        }
    }
}


- (UIImageView*)getCacheCell{
    UIImageView *v = nil; 
    if (cacheArr&& [cacheArr isKindOfClass:[NSArray class]] &&[cacheArr count]>0) {
        v = [cacheArr lastObject];
        [cacheArr removeLastObject];
    }
    return v;
}






- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    NSLog(@" touches :%@ ",touches);
    [self reloadImageViews];
    return YES;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[self reloadImageViews];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
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

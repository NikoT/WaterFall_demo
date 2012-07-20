//
//  WaterfallView.m
//  WaterFall_demo
//
//  Created by sven on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaterfallView.h"

#define VOLUME_NUM 2
#define VOLUME_OFFSET 4
#define LINE_OFFSET 3

@implementation WaterfallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            [imageView setImage:image];
            [self addSubview:imageView];
            
            int yMax=[[volumeArr objectAtIndex:0] intValue];
            for (int i = 0; i<[volumeArr count]; i++) {
                if ([[volumeArr objectAtIndex:i] intValue]>y) {
                    yMax = [[volumeArr objectAtIndex:i] intValue];
                }
            }
            [self setContentSize:CGSizeMake(self.frame.size.width, yMax)]; 
        }
    }
}




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

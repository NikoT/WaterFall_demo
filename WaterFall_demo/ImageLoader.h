//
//  ImageLoader.h
//  WaterFall_demo
//
//  Created by goojje goojje on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageLoaderDelegate <NSObject>

- (void)loaderDidFinish:(UIImage*)image WithContext:(id)context;

@end

@interface ImageLoader : NSObject<NSURLConnectionDelegate>{
    id<ImageLoaderDelegate>imageLoaderDelegate;
    
    NSString *directory;
    
    NSURLConnection *connect;
    NSMutableData *receivedDada;
}
@property (nonatomic , copy)NSString *directory;
@property (nonatomic , retain)NSURLConnection *connect;
@property (nonatomic , retain)NSMutableData *receivedDada;


- (id)initWithDelegate:(id<ImageLoaderDelegate>)delegate;
- (void)loadImageFromUrl:(NSString*)url;
@end

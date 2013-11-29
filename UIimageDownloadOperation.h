//
//  UIimageDownloadOperation.h
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIimageDownloadOperation : NSOperation<NSURLConnectionDelegate>
@property(nonatomic,strong)NSURL * targetUrl;
@property(nonatomic,strong)NSMutableData * data;
@property(nonatomic,assign)NSOperationQueue * queue;
@property(nonatomic,strong)UIImageView      * imageView;
@property(nonatomic,strong)NSURLConnection  * connect;
@property(nonatomic,assign)id                 delegate;
-(void)cancelConnect;
//-(id)initWithUrl:(NSURL*)aUrl schInQueue:(NSOperationQueue*)aQueue andImageView:(UIImageView*)aImageView;
//-(id)initWithUrl:aUrl schInQueue:_queue andImageView:aImageView aDelegate:(id)delegate;
-(id)initWithUrl:(NSURL*)aUrl scheduInQueue:(NSOperationQueue*)aQueue andImageView:(UIImageView*)aImageView andDelegate:(id)delegate;
-(void)finishLoad:(NSDictionary*)aDict;
@end

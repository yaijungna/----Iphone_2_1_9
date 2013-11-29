//
//  FSOneDayTableListCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-9-4.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"
@class FSOneDayTableListCell;
@interface MyConternView : UIView
@property(nonatomic,assign)id data;
@property(nonatomic,assign)FSOneDayTableListCell *delegateCell;
@end
@interface FSOneDayTableListCell : FSTableViewCell{
@protected
    

    
//    FSAsyncImageView *_image_channelIcon;
//    UIImageView *_image_Icon;
//    FSAsyncImageView *_image_newsimage;
    
    UIView *_lineView;
    
    UIImageView *_oneday_eastImage;
    
}
@property(nonatomic,retain)UILabel * lab_title;
@property(nonatomic,retain)MyConternView *myContetView;
@property(nonatomic,retain)FSAsyncImageView * image_channelIcon;
@property(nonatomic,retain)UIImageView *image_Icon;
@property(nonatomic,retain)UIImageView *image_newsimage;
-(void)setContainer;

-(BOOL)isDownloadPic;

@end

//
//  FSNewsListCell.h
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-2.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTableViewCell.h"


@class FSAsyncImageView;
@class FSNewsListCell;
@interface MyContetView : UIView
@property(nonatomic,assign)FSNewsListCell * delegateCell;
@end
@interface FSNewsListCell : FSTableViewCell{
@protected
    //UILabel          *_lab_NewsTitle;
//    UILabel          *_lab_NewsType;
//    FSAsyncImageView *_image_Onright;

    
}
@property(nonatomic,retain)UILabel * lab_NewsTitle;
@property(nonatomic,retain)UILabel * lab_NewsType;
@property(nonatomic,retain)UIImageView *image_Onright;

@property(nonatomic,retain)MyContetView * myContentView;
-(BOOL)isDownloadPic;
-(NSString *)timeTostring:(NSNumber *)time;
@property(nonatomic,retain)UIView * leftView;

@end

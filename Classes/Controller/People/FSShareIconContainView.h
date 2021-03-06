//
//  FSShareIconContainView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-13.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseContainerView.h"


typedef enum _ShareSelectEvent{
    ShareSelectEvent_weixin = 0,    //微信
    ShareSelectEvent_friend,     //微信朋友圈
    ShareSelectEvent_netEaseMessaage,   //易信好友
    ShareSelectEvent_netEaseFriend,         //易信朋友圈
    ShareSelectEvent_peopleBlog,//人民微博

    ShareSelectEvent_sina,      //新浪
    ShareSelectEvent_tencent,   //腾讯微博
    ShareSelectEvent_netease,   //网易
    ShareSelectEvent_return,    //返回
    
    
}ShareSelectEvent;


@interface FSShareIconContainView : FSBaseContainerView{
@protected
    
    UILabel *_lab_title;
    UIButton *_bt_return;
    
    ShareSelectEvent _shareSelectEvent;
    
    BOOL _isShow;
}

@property (nonatomic,assign ) ShareSelectEvent shareSelectEvent;
@property (nonatomic,assign ) BOOL isShow;


-(void)layoutIcons;
-(CGFloat)getHeight;

@end


@interface WeiBoObject : NSObject
{
    
}
@property(nonatomic,assign)int      index;
@property(nonatomic,copy) NSString * picName;
@property(nonatomic,copy) NSString * disPlayName;
-(id)initWithIndex:(int)index andPicName:(NSString*)picName andDisplayName:(NSString*)disPlayName;
@end

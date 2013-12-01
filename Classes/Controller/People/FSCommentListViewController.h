//
//  FSCommentListViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-30.
//
//

#import <UIKit/UIKit.h>
#import "FSBasePeopleViewController.h"
#import "FSNewsContainerCommentListView.h"
#import "FSBaseSettingViewController.h"
#import "FSNewsCommentListView.h"
#import "LygDeepCommentListDao.h"

@class FS_GZF_CommentListDAO;

@interface FSCommentListViewController : FSBaseSettingViewController <UIGestureRecognizerDelegate,FSBaseContainerViewDelegate>{
@protected
    //FSNewsContainerCommentListView *_fsNewsContainerCommentListView;
//    FS_GZF_CommentListDAO *_fs_GZF_CommentListDAO;
//    LygDeepCommentListDao * _getCommentListDao;
    //UINavigationBar *_navTopBar;
    
    NSString *_newsid;
    
    BOOL _withnavTopBar;
    
    FSNewsCommentListView *_fsNewsCommentListView;
}

@property (nonatomic,retain) NSString *newsid;
@property (nonatomic,retain) NSString *deepid;
@property (nonatomic,assign) BOOL withnavTopBar;
@property (nonatomic,retain) FS_GZF_CommentListDAO *fs_GZF_CommentListDAO;
@property (nonatomic,retain) LygDeepCommentListDao * getCommentListDao;

@end

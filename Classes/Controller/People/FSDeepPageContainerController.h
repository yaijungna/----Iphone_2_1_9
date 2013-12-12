//
//  FSDeepPageContainerController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-1.
//
//

#import <UIKit/UIKit.h>
#import "FSPageControlViewController.h"
#import "FSDeepPageListDAO.h"
#import "FSShareIconContainView.h"
#import <MessageUI/MessageUI.h>
#import "FSNewsDitailToolBar.h"
#import "LygDeepCommentPostDao.h"
#import "LygDeepCommentListDao.h"
#import "FSTopicObject.h"
@class FS_GZF_DeepPageListDAO;

@interface FSDeepPageContainerController : FSPageControlViewController<MFMailComposeViewControllerDelegate> {
@private
    //FSDeepPageListDAO *_deepPageListData;
    
    FS_GZF_DeepPageListDAO         *_fs_GZF_DeepPageListDAO;
    FSShareIconContainView         *_fsShareIconContainView;
    FSNewsDitailToolBar            *_newsDitailToolBar;
    
}

@property (nonatomic, retain) NSString *deepid;
@property (nonatomic, retain) NSString *Deep_title;
@property (nonatomic, retain) NSString *newsAbstract;
@property (nonatomic, strong) UIImage  *shareImage;
@property (nonatomic, strong) NSData   *shareData;
@property (nonatomic, strong) NSString *comment_content;

@property (nonatomic,strong)NSString  * share_img;
@property (nonatomic,strong)NSString  * share_url;
@property (nonatomic,strong)NSString  * share_text;
@property (nonatomic,strong)LygDeepCommentPostDao * postCommentDao;
@property (nonatomic,strong)LygDeepCommentListDao * getCommentDao;
@property (nonatomic,strong)FSTopicObject         * oneTopic;
@property (nonatomic,strong)NSString  * oldComment;

@end

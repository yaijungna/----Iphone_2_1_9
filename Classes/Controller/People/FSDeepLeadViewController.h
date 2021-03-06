//
//  FSDeepLeadViewController.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import <UIKit/UIKit.h>
#import "FSDeepBaseViewController.h"
#import "FSDeepLeadDAO.h"
#import "FSDeepLeadView.h"
#import "LygDeepCommentListDao.h"

@class FS_GZF_DeepLeadDAO;

@interface FSDeepLeadViewController : FSDeepBaseViewController {
@private
    //FSDeepLeadDAO *_leadData;
    
    FSDeepLeadView *_leadView;
    
    FS_GZF_DeepLeadDAO *_fs_GZF_DeepLeadDAO;
}
@property(nonatomic,strong)FS_GZF_DeepLeadDAO *fs_GZF_DeepLeadDAO;
@property(nonatomic,strong)LygDeepCommentListDao * getCommentListDao;
@end

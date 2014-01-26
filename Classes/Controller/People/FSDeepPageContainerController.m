//
//  FSDeepPageContainerController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-1.
//
//

#import "FSDeepPageContainerController.h"

#import "FS_GZF_DeepPageListDAO.h"
#import "FSDeepPageObject.h"
#import "FSMyFaverateObject.h"
#import "FSDeepLeadViewController.h"
#import "FSDeepPictureVeiwController.h"
#import "FSDeepTextViewController.h"
#import "FSDeepOuterLinkViewController.h"
#import "FSDeepInvestigateViewController.h"
#import "FSDeepEndViewController.h"
#import "FSDeepCommentViewController.h"
#import "FSDeepPriorViewController.h"
#import "FSSinaBlogShareViewController.h"
#import "FSNetEaseBlogShareViewController.h"
#import "FSPeopleBlogShareViewController.h"
#import "NTESNBSMSManager.h"
#import "LygTencentShareViewController.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"
#import "FSInformationMessageView.h"
/*
 flag:1（导语页面）深度id
 flag:2（图片页面）图片id
 flag:3（文本页面）正文id
 flag:4（外链页面）外链id
 flag:5（调查页面）调查id
 flag:6（结束语页面）深度id
 flag:7（评论页面）深度id
 flag:8（往期页面）深度id
 */
#define FSDEEP_PAGE_LEAD 1
#define FSDEEP_PAGE_PICTURE 2
#define FSDEEP_PAGE_TEXT 3
#define FSDEEP_PAGE_OUTER 4
#define FSDEEP_PAGE_INVESTIGATE 5
#define FSDEEP_PAGE_END 6
#define FSDEEP_PAGE_COMMENT 7
#define FSDEEP_PAGE_PRIOR 8


@interface FSDeepPageContainerController ()

@end

@implementation FSDeepPageContainerController
@synthesize deepid = _deepid;
@synthesize Deep_title = _Deep_title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)isDeepidInFav:(NSString*)deepid
{
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSMyFaverateObject" key:@"deepId" value:deepid];
    if (array.count > 0) {
        return YES;
    }else
    {
        return NO;
    }

}
-(id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateShareData:) name:@"updateShareData" object:nil];
    }
    return self;
}
-(void)updateShareData:(NSNotification*)sender
{
    UIImage * image = sender.object;
    NSData  * data  = UIImagePNGRepresentation(image);
    self.shareData  = UIImagePNGRepresentation(image);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _newsDitailToolBar.isInFaverate = [self  isDeepidInFav:self.deepid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)loadChildView
{
    [super loadChildView];
    self.oldComment  = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DeepComment%@",self.deepid]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareResult:) name:@"SHARE_SUCCESSFUL_NOTICE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getComMent:) name:@"getComment" object:nil];
    _fsShareIconContainView = [[FSShareIconContainView alloc] initWithFrame:CGRectZero];
    _fsShareIconContainView.parentDelegate = self;
    _newsDitailToolBar      = [[FSNewsDitailToolBar alloc] init];
    _newsDitailToolBar.parentDelegate = self;
    [self.view addSubview:_fsShareIconContainView];
    _newsDitailToolBar.comment_content = self.oldComment;

    [_fsShareIconContainView release];
    [self.view addSubview:_newsDitailToolBar];
    [_newsDitailToolBar release];
}
-(NSObject *)ObjIsInFaverate{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSMyFaverateObject" key:@"deepId" value:self.deepid];
    if ([array count]>0) {
        return [array objectAtIndex:0];
    }
    else{
        return nil;
    }
}
-(void)fav{
    if (self.deepid) {
        
        FSMyFaverateObject *o = (FSMyFaverateObject *)[self ObjIsInFaverate];
        if (o!= nil) {
            [[FSBaseDB sharedFSBaseDB].managedObjectContext deleteObject:o];
        }
        else{
            FSMyFaverateObject *o = (FSMyFaverateObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSMyFaverateObject"];
            o.isDeep = [NSNumber numberWithInt:1];
            o.deepId = self.deepid;
            o.deepNews_abstract = self.newsAbstract;
            o.deepTitle         = self.Deep_title;
            

            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0f];
            NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
            NSString *string = [NSString stringWithFormat:@"%f",currentTimeInterval];
            o.UPDATE_DATE = string;
            [date release];
        }
        

    }

    
    [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
    
}





-(void)getComMent:(NSNotification*)sender
{
    
    NSObject * ject = sender.object;
    if ([ject isKindOfClass:[FSNewsDitailToolBar class]]) {
        FSNewsDitailToolBar * xxx =  (FSNewsDitailToolBar*)ject;
        xxx.comment_content       =  self.oldComment;
        xxx.growingText.text      =  self.oldComment;
    }
}


- (void)dealloc {
    NSString * string = _newsDitailToolBar.growingText.text;
    [[NSUserDefaults standardUserDefaults]setValue:string forKey:[NSString stringWithFormat:@"DeepComment%@",self.deepid]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.shareData = nil;
    self.shareImage= nil;
    [_deepid release];
    _fs_GZF_DeepPageListDAO.parentDelegate = NULL;
    [_fs_GZF_DeepPageListDAO release];
    _newsDitailToolBar.parentDelegate = nil;
    
    _postCommentDao.parentDelegate = nil;
    self.postCommentDao            = nil;

    
    _getCommentDao.parentDelegate = nil;
    self.getCommentDao            = nil;
    
    [super dealloc];
}

- (void)initDataModel {
    _fs_GZF_DeepPageListDAO = [[FS_GZF_DeepPageListDAO alloc] init];
    _fs_GZF_DeepPageListDAO.parentDelegate = self;
    _postCommentDao         = [[LygDeepCommentPostDao alloc]init];
    _postCommentDao.parentDelegate = self;
    
    _getCommentDao          = [[LygDeepCommentListDao alloc] init];
    _getCommentDao.parentDelegate  = self;
    _getCommentDao.deepid = self.oneTopic.deepid;
    _getCommentDao.count  = @"6";
}


-(void)downLOadShareImage:(NSString*)string
{
    self.shareData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
    //self.shareImage = [UIImage imageWithData:self.shareData];
}
- (void)doSomethingForViewFirstTimeShow {
    _fs_GZF_DeepPageListDAO.deepid = self.deepid;
    [_fs_GZF_DeepPageListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
    if (status == FSBaseDAOCallBack_WorkingStatus) {
        FSIndicatorMessageView *indicatorMessageView = [[FSIndicatorMessageView alloc] initWithFrame:self.view.frame andBool:YES];
        [indicatorMessageView showIndicatorMessageViewInView:_svContainer withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status]];
        [indicatorMessageView release];
    }
    if ([sender isEqual:_fs_GZF_DeepPageListDAO]) {
        
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
            NSLog(@"_fs_GZF_DeepPageListDAO:%d",[_fs_GZF_DeepPageListDAO.objectList count]);
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_DeepPageListDAO operateOldBufferData];
                [self setPageControllerCount:[_fs_GZF_DeepPageListDAO.objectList count]];
            }
        }
        if (self.shareData || _fs_GZF_DeepPageListDAO.objectList.count == 0) {
            return;
        }
        FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:0];
        if (pageObj.share_img == nil || pageObj.share_img.length == 0) {
            NSString * string = [[NSBundle mainBundle]pathForResource:@"icon@2x" ofType:@"png"];
            self.shareData = [NSData dataWithContentsOfFile:string];
        }else
        {
            [self performSelectorInBackground:@selector(downLOadShareImage:) withObject:pageObj.share_img];
        }
        
        //[_getCommentDao HTTPGetDataWithKind:GET_DataKind_Refresh];
    }
    if ([sender isEqual:_postCommentDao]) {
        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus || status == FSBaseDAOCallBack_SuccessfulStatus) {
             [self displayPostResult];
        }
    }

    
}

-(void)displayPostResult
{
    //NSLog(@"%@",_postCommentDao.result);
    NSString * string = nil;
    if ([_postCommentDao.result isEqualToString:@"0"]) {
        string = @"评论成功";
        _newsDitailToolBar.growingText.text = @"";
    }else
    {
        string = @"请稍后再试";
    }
    FSInformationMessageView * info = [[FSInformationMessageView alloc]init];
    [info showInformationMessageViewInView:self.view withMessage:string withDelaySeconds:0.8 withPositionKind:PositionKind_Vertical_Horizontal_Center withOffset:0];
    [info release];
}

- (Class)pageControllerClassWithPageNum:(NSInteger)pageNum {
    //NSIndexPath *indexPath = [self indexPathWithPageNum:pageNum];
    //FSDeepPageObject *pageObj = [_deepPageListData.fetchedResultsController objectAtIndexPath:indexPath];
    if (_fs_GZF_DeepPageListDAO.objectList.count == 0 || _fs_GZF_DeepPageListDAO.objectList == nil) {
        return NULL;
    }
    FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:pageNum];
    if (pageObj) {
        Class controllerClass = nil;
        NSInteger flag = [pageObj.flag intValue];
        
        switch (flag) {
            case FSDEEP_PAGE_LEAD:
                controllerClass = [FSDeepLeadViewController class];
                break;
            case FSDEEP_PAGE_PICTURE:
                controllerClass = [FSDeepPictureVeiwController class];
                break;
            case FSDEEP_PAGE_TEXT:
                controllerClass = [FSDeepTextViewController class];
                break;
            case FSDEEP_PAGE_OUTER:
                controllerClass = [FSDeepOuterLinkViewController class];
                break;
            case FSDEEP_PAGE_INVESTIGATE:
                controllerClass = [FSDeepInvestigateViewController class];
                break;
            case FSDEEP_PAGE_END:
                controllerClass = [FSDeepEndViewController class];
                break;
            case FSDEEP_PAGE_COMMENT:
                controllerClass = [FSDeepCommentViewController class];
                break;
            case FSDEEP_PAGE_PRIOR:
                controllerClass = [FSDeepPriorViewController class];
                break;
            default:
                break;
        }
        return controllerClass;

    }
    return nil;
}

- (void)initializePageController:(UIViewController *)viewController withPageNum:(NSInteger)pageNum {
    NSIndexPath  *indexPath = [self indexPathWithPageNum:pageNum];
    if (indexPath) {
        //FSDeepPageObject *pageObj = [_deepPageListData.fetchedResultsController objectAtIndexPath:indexPath];
        if (_fs_GZF_DeepPageListDAO.objectList == NULL || _fs_GZF_DeepPageListDAO.objectList.count == 0) {
            return;
        }
        FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:pageNum];
        NSInteger flag = [pageObj.flag intValue];
        FSLog(@"deepPage.flag:%d[%@]", flag, pageObj.pageid);
        switch (flag) {
            case FSDEEP_PAGE_LEAD:
                //controllerClass = [FSDeepLeadViewController class];
                if ([viewController isKindOfClass:[FSDeepLeadViewController class]]) {
                    FSDeepLeadViewController *deepLeadCtrl = (FSDeepLeadViewController *)viewController;
                    deepLeadCtrl.bottomControlHeight = [self pageControlHeight];
                    deepLeadCtrl.deepid = pageObj.pageid;
                    //deepLeadCtrl.getCommentListDao = self.getCommentDao;
                    //self.share_img      = deepLeadCtrl.fs_GZF_DeepLeadDAO.
                }
                break;
            case FSDEEP_PAGE_PICTURE:
                //controllerClass = [FSDeepPictureVeiwController class];
                if ([viewController isKindOfClass:[FSDeepPictureVeiwController class]]) {
                    FSDeepPictureVeiwController *deepPictureCtrl = (FSDeepPictureVeiwController *)viewController;
                    deepPictureCtrl.bottomControlHeight = [self pageControlHeight];
                    deepPictureCtrl.pictureid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_TEXT:
                if ([viewController isKindOfClass:[FSDeepTextViewController class]]) {
                    FSDeepTextViewController *deepTextCtrl = (FSDeepTextViewController *)viewController;
                    deepTextCtrl.contentid                 = pageObj.pageid;
                    deepTextCtrl.Deep_title                = self.Deep_title;
                    deepTextCtrl.getCommentListDao         = self.getCommentDao;
                    self.getCommentDao.parentDelegate      = deepTextCtrl;
                }
                //controllerClass = [FSDeepTextViewController class];
                break;
            case FSDEEP_PAGE_OUTER:
                //controllerClass = [FSDeepOuterLinkViewController class];
                if ([viewController isKindOfClass:[FSDeepOuterLinkViewController class]]) {
                    FSDeepOuterLinkViewController *outerLinkCtrl = (FSDeepOuterLinkViewController *)viewController;
                    outerLinkCtrl.outerid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_INVESTIGATE:
                //controllerClass = [FSDeepInvestigateViewController class];
                break;
            case FSDEEP_PAGE_END:
                //controllerClass = [FSDeepEndViewController class];
                if ([viewController isKindOfClass:[FSDeepEndViewController class]]) {
                    FSDeepEndViewController *deepEndCtrl = (FSDeepEndViewController *)viewController;
                    deepEndCtrl.deepid = pageObj.pageid;
                }
                break;
            case FSDEEP_PAGE_COMMENT:
                //controllerClass = [FSDeepCommentViewController class];
                break;
            case FSDEEP_PAGE_PRIOR:
                //controllerClass = [FSDeepPriorViewController class];
                if ([viewController isKindOfClass:[FSDeepPriorViewController class]]) {
                    FSDeepPriorViewController *deepPriorCtrl = (FSDeepPriorViewController *)viewController;
                    deepPriorCtrl.deepid = pageObj.pageid;
                }
                break;
            default:
                break;
        }
    }
}
-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    if ([sender isEqual:_newsDitailToolBar]) {
        //self.touchEvenKind = _newsDitailToolBar.touchEvenKind;
        switch (_newsDitailToolBar.touchEvenKind) {
            case TouchEvenKind_FaverateSelect:
               [self fav];
                break;
            case TouchEvenKind_FontSelect:
                ;
                break;
            case TouchEvenKind_CommentSelect:
                ;
                break;
            case TouchEvenKind_Commentsend:
            {
                self.comment_content = _newsDitailToolBar.comment_content;
                [self sendComment];
            }
                
                break;
            case TouchEvenKind_ShareSelect:
                [self share];
                break;
            case TouchEvenKind_GoBack:
            {
                if (self.navigationController) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                }
            }
            default:
                break;
        }
    }

    if ([sender isEqual:_fsShareIconContainView]) {
        switch (_fsShareIconContainView.shareSelectEvent) {
            case ShareSelectEvent_return:
                break;
            case ShareSelectEvent_sina:
                NSLog(@"分享到新浪微博");
            {
                FSSinaBlogShareViewController *fsSinaBlogShareViewController = [[FSSinaBlogShareViewController alloc] init];
                
                fsSinaBlogShareViewController.withnavTopBar                  = YES;
                fsSinaBlogShareViewController.title                          = @"新浪微博分享";
                fsSinaBlogShareViewController.shareContent                   = [self shareContent];
                fsSinaBlogShareViewController.dataContent                    =  self.shareData;
                [self presentViewController:fsSinaBlogShareViewController animated:YES completion:nil];
                //[self.navigationController pushViewController:fsSinaBlogShareViewController animated:YES];
                [fsSinaBlogShareViewController release];
            }
                
                break;
            case ShareSelectEvent_netease:
                NSLog(@"分享到网易微博");
                FSNetEaseBlogShareViewController *fsNetEaseBlogShareViewController = [[FSNetEaseBlogShareViewController alloc] init];
                fsNetEaseBlogShareViewController.withnavTopBar                     = YES;
                fsNetEaseBlogShareViewController.shareContent                      = [self shareContent];
                fsNetEaseBlogShareViewController.dataContent                       = self.shareData;
                //[self presentViewController:fsNetEaseBlogShareViewController animated:YES completion:nil];
                [self.navigationController pushViewController:fsNetEaseBlogShareViewController animated:YES];
                [fsNetEaseBlogShareViewController release];
                //}
                
                break;
            case ShareSelectEvent_weixin:
            {
                [self sendShareWeiXin:0];
                break;
            }
               
            case ShareSelectEvent_friend:
            {
                [self sendShareWeiXin:1];
            }
                
                break;
            case ShareSelectEvent_netEaseFriend:
            {
                [self sendShareYiXin:1];
                break;
                
            }
            case ShareSelectEvent_netEaseMessaage:
            {
                [self sendShareYiXin:0];
                break;
            }
            case ShareSelectEvent_peopleBlog:
                NSLog(@"分享到人民微博");
                FSPeopleBlogShareViewController *fsPeopleBlogShareViewController = [[FSPeopleBlogShareViewController alloc] init];
                fsPeopleBlogShareViewController.withnavTopBar                    = YES;
                fsPeopleBlogShareViewController.shareContent = [self shareContent];
                fsPeopleBlogShareViewController.dataContent  = self.shareData;
                [self.navigationController pushViewController:fsPeopleBlogShareViewController animated:YES];
                [fsPeopleBlogShareViewController release];
                //}
                
                break;

            case ShareSelectEvent_tencent:
            {
                LygTencentShareViewController *fsSinaBlogShareViewController = [[LygTencentShareViewController alloc] init];
                fsSinaBlogShareViewController.withnavTopBar                  = YES;
                fsSinaBlogShareViewController.title                          = @"腾讯微博分享";
                fsSinaBlogShareViewController.shareContent                   = [self shareContent];
                fsSinaBlogShareViewController.dataContent                    = self.shareData;
                [self.navigationController pushViewController:fsSinaBlogShareViewController animated:YES];
                [fsSinaBlogShareViewController release];
            }
                break;
            default:
                break;
        }
        NSLog(@"。。。。。。。。。");
        //_fsNewsContainerView.userInteractionEnabled = YES;
        _fsShareIconContainView.isShow = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.6];
        _fsShareIconContainView.frame = CGRectMake(0, self.view.frame.size.height+4, self.view.frame.size.width, [_fsShareIconContainView getHeight]);
        [UIView commitAnimations];
        
    }
}
-(void)sendComment
{
    _postCommentDao.deepid = self.deepid;
    _postCommentDao.content = self.comment_content;
    [_postCommentDao HTTPPostDataWithKind:HTTPPOSTDataKind_Normal];
}
//-(void)commentUpdata:(NSString *)content{
//    
//    if (self.obj!=nil) {
//        _fs_GZF_NewsCommentPOSTXMLDAO.newsid = self.obj.newsid;
//        _fs_GZF_NewsCommentPOSTXMLDAO.channelid = self.obj.channelid;
//        
//    }
//    if (self.FCObj!=nil) {
//        _fs_GZF_NewsCommentPOSTXMLDAO.newsid = self.FCObj.newsid;
//        _fs_GZF_NewsCommentPOSTXMLDAO.channelid = self.FCObj.channelid;
//    }
//    _fs_GZF_NewsCommentPOSTXMLDAO.username = @"人民网网友";
//    _fs_GZF_NewsCommentPOSTXMLDAO.content = content;
//    
//    if ([_fs_GZF_NewsCommentPOSTXMLDAO.newsid length]==0) {
//        ;//数据不完整
//    }
//    [_fs_GZF_NewsCommentPOSTXMLDAO HTTPPostDataWithKind:HTTPPOSTDataKind_Normal];
//}
-(void)layoutControllerViewWithRect:(CGRect)rect
{
    _newsDitailToolBar.frame = CGRectMake(0, self.view.frame.size.height - 40, 320, 40);
}
//-(UIImage*)getShareImage
//{
//    if
//}
-(void)sendShareYiXin:(int)isSendToFriend
{
    FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:0];
    PeopleNewsReaderPhoneAppDelegate*appDelegate = (PeopleNewsReaderPhoneAppDelegate *)[UIApplication sharedApplication].delegate;
    if (![appDelegate sendYXMidiaMessage:self.Deep_title content:pageObj.share_text thumbImage:[UIImage imageWithData:self.shareData] webURL:pageObj.share_url sendType:isSendToFriend]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人民新闻" message:@"不能分享到微信，请确认安装了最新版本的微信客户端" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
-(void)sendShareWeiXin:(int)isSendToFriend{
    FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:0];
    if (1) {
        PeopleNewsReaderPhoneAppDelegate*appDelegate = (PeopleNewsReaderPhoneAppDelegate *)[UIApplication sharedApplication].delegate;
        if (isSendToFriend == 0) {
            if (![appDelegate sendWXMidiaMessage:self.Deep_title content:pageObj.share_text thumbImage:[UIImage imageWithData:self.shareData] webURL:pageObj.share_url]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人民新闻" message:@"不能分享到微信，请确认安装了最新版本的微信客户端" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
        }else
        {
            if (![appDelegate sendWXMidiaMessagePYQ:self.Deep_title content:pageObj.share_text thumbImage:[UIImage imageWithData:self.shareData] webURL:pageObj.share_url]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人民新闻" message:@"不能分享到微信，请确认安装了最新版本的微信客户端" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
        }
    }
}


-(NSString *)shareContent{
    FSDeepPageObject *pageObj = [_fs_GZF_DeepPageListDAO.objectList objectAtIndex:0];
    return  [NSString stringWithFormat:@"%@ %@",pageObj.share_text,pageObj.share_url];
}
-(void)share{
    _fsShareIconContainView.frame  = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, [_fsShareIconContainView getHeight]);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    _fsShareIconContainView.frame  = CGRectMake(0, self.view.frame.size.height-[_fsShareIconContainView getHeight] - 40, self.view.frame.size.width, [_fsShareIconContainView getHeight]);
    _fsShareIconContainView.isShow = YES;
    [UIView commitAnimations];
}

-(void)shareResult:(NSNotification*)sender
{
    NSDictionary * userInfo = [sender userInfo];
    FSInformationMessageView * shareInfo = [[FSInformationMessageView alloc] init];
    if (userInfo == nil) {
        [shareInfo showInformationMessageViewInView:self.view withMessage:@"分享成功" withDelaySeconds:0.5 withPositionKind:PositionKind_Vertical_Horizontal_Center withOffset:1];
    }else
    {
        [shareInfo showInformationMessageViewInView:self.view withMessage:[userInfo valueForKey:@"NSLocalizedDescription"] withDelaySeconds:0.5 withPositionKind:PositionKind_Vertical_Horizontal_Center withOffset:1];
    }
    
    [shareInfo release];
}
@end

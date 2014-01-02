//
//  MyPageViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ark on 14-1-1.
//
//

#import "MyPageViewController.h"
#import "FSUserSelectObject.h"
#import "FSChannelObject.h"
#import "LygNewsViewController.h"
#define KIND_USERCHANNEL_SELECTED  @"YAOWENCHANNEL"
#define WIDTHOFNAME 10
#define BORDER      10
#define HeightOfChannel 30
@interface MyPageViewController ()

@end

@implementation MyPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)initChannelViewController
{
    if (self.viewControllers.count > 0) {
        return;
    }
    NSMutableArray * controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i++) {
//        UIViewController * xxx = [[UIViewController alloc]init];
//        xxx.view.backgroundColor     = [UIColor clearColor];
//        [controllers addObject:xxx];
        
        
        
        LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:i andChannel:self.fs_GZF_ChannelListDAO];
        [controllers addObject:xxx];
        [xxx release];
    }
    
    
    [self setViewControllers:controllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(id)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options
{
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        self.delegate          = self;
        self.dataSource        = self;
        _fs_GZF_ChannelListDAO = [[FS_GZF_ChannelListDAO alloc] init];
        _fs_GZF_ChannelListDAO.parentDelegate = self;
        _fs_GZF_ChannelListDAO.type = @"news";
        _fs_GZF_ChannelListDAO.isGettingList = YES;
        [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
    }
    return self;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    LygNewsViewController * temp = (LygNewsViewController*)viewController;
    if (temp.channelIndex == self.fs_GZF_ChannelListDAO.objectList.count -1) {
        return nil;
    }
    LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:temp.channelIndex+1 andChannel:self.fs_GZF_ChannelListDAO];
    return [xxx autorelease];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    LygNewsViewController * temp = (LygNewsViewController*)viewController;
    if (temp.channelIndex == 0) {
        return nil;
    }
    LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:temp.channelIndex-1 andChannel:self.fs_GZF_ChannelListDAO];
    return [xxx autorelease];
}
-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
    NSLog(@"doSomethingWithDAO：%@ :%d",sender,status);
    
    if ([sender isEqual:_fs_GZF_ChannelListDAO]) {
        NSLog(@"%d",[_fs_GZF_ChannelListDAO.objectList count]);
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                //FSLog(@"_fs_GZF_ForNewsListDAO Refresh");
                //[self getUserChannelSelectedObject];
                if ([_fs_GZF_ChannelListDAO.objectList count]>0) {
//                    FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
//                    NSArray * arry = [[FSBaseDB sharedFSBaseDB]getObjectsByKeyWithName:@"FSUserSelectObject" key:nil value:nil];
//                    [[FSBaseDB sharedFSBaseDB] deleteObjectByObjectS:arry];
//                    FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
//                    
//                    sobj.kind = @"YAOWENCHANNEL";
//                    sobj.keyValue1 = CObject.channelname;
//                    sobj.keyValue2 = CObject.channelid;
//                    [FSBaseDB saveDB];
                    
                      [self initChannelViewController];
                }
//                FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
//                
//                FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
//                
//                sobj.kind = KIND_USERCHANNEL_SELECTED;
//                sobj.keyValue1 = CObject.channelname;
//                sobj.keyValue2 = CObject.channelid;
//                sobj.keyValue3 = nil;
//                [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
//                //[self addKindsScrollView];
//                if (status == FSBaseDAOCallBack_SuccessfulStatus) {
//                    
//                    [_fs_GZF_ChannelListDAO operateOldBufferData];
//                }
                
                
                [self initChannelViewController];
            }
        }else if(status ==FSBaseDAOCallBack_NetworkErrorStatus){
            //[self getUserChannelSelectedObject];
            
            //[_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
        }
        return;
    }
}

- (void)dataAccessObjectSync:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
//	//当前的数据访问对象以及状态，用于出错时候进行处理
//    //FSLog(@"当前的数据访问对象以及状态，用于出错时候进行处理");
//	self.currentDAOData = sender;
//	self.currentDAOStatus = status;
//	
//	if (status == FSBaseDAOCallBack_WorkingStatus || status == FSBaseDAOCallBack_ListWorkingStatus ) {
//        //		if ([self canShowIndicatorMessageViewWithDAO:sender]&&status == FSBaseDAOCallBack_WorkingStatus) {
//        //			FSIndicatorMessageView *indicatorMessageView = [[FSIndicatorMessageView alloc] initWithFrame:CGRectZero];
//        //			[indicatorMessageView showIndicatorMessageViewInView:self.view withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status]];
//        //			[indicatorMessageView release];
//        //		}
//        
//        if ([self canShowIndicatorMessageViewWithDAO:sender]&&status == FSBaseDAOCallBack_ListWorkingStatus) {
//            [self doSomethingWithLoadingListDAO:sender withStatus:status];
//        }
//	} else {
//		[FSIndicatorMessageView dismissIndicatorMessageViewInView:self.view];
//		
//		switch (status) {
//			case FSBaseDAOCallBack_HostErrorStatus:
//				
//			case FSBaseDAOCallBack_NetworkErrorStatus:
//                
//			case FSBaseDAOCallBack_NetworkErrorAndNoBufferStatus:
//                
//			case FSBaseDAOCallBack_NetworkErrorAndDataIsTailStatus:
//                
//			case FSBaseDAOCallBack_DataFormatErrorStatus:
//                
//			case FSBaseDAOCallBack_URLErrorStatus:
//                
//			case FSBaseDAOCallBack_UnknowErrorStatus:
//                
//			case FSBaseDAOCallBack_POSTDataZeroErrorStatus:{
//				FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
//				informationMessageView.parentDelegate = self;
//				[informationMessageView showInformationMessageViewInView:self.view
//															 withMessage:[self indicatorMessageTextWithDAO:sender withStatus:status]
//														withDelaySeconds:2.0f
//														withPositionKind:PositionKind_Vertical_Horizontal_Center
//															  withOffset:0.0f];
//				[informationMessageView release];
//				break;
//			}
//			default:
//				break;
//		}
//		if (status == FSBaseDAOCallBack_HostErrorStatus) {
//			
//		}
//	}
    
	[self doSomethingWithDAO:sender withStatus:status];
}
//-(void)showIndacactorInView:(UIView *)aView
//{
//    
//}
//
//- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
//	
//}
//
//-(void)doSomethingWithLoadingListDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
//    
//}
//
//- (void)informationMessageViewTouchClosed:(FSInformationMessageView *)sender {
//	//子类实现
//	/*
//     if ([self.currentDAOData isEqual:xxxObj] && self.currentDAOStatus == FSBaseDAOCallBack_HostErrorStatus) {
//     //doSomething
//     }
//	 */
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

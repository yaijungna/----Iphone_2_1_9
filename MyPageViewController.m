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
#import "LygNavigationBar.h"
#import "LocalNewsViewController.h"
#import "UIViewController+changeContent.h"
#define KIND_USERCHANNEL_SELECTED  @"YAOWENCHANNEL"
#define WIDTHOFNAME 10
#define BORDER      10


#define TAGOFSCROW  2001
#define TAGOFNAV    1001
#define TAGOFTOPIMAGE 3001
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
-(void)hideBar
{
    UIWindow * window       = [UIApplication sharedApplication].windows[0];
    UIView * view           = [window viewWithTag:TAGOFSCROW];
    
    [window sendSubviewToBack:view];
    UIView * view2          = [window viewWithTag:TAGOFNAV];
    
    [window sendSubviewToBack:view2];
}


-(void)showBar
{
    UIWindow * window       = [UIApplication sharedApplication].windows[0];
    UIView * view           = [window viewWithTag:TAGOFNAV];
    UIView * view2          = [window viewWithTag:TAGOFSCROW];
    
    
    
    UIView * view3          = [window viewWithTag:3000];
    if (view3) {
        [window insertSubview:view belowSubview:view3];
        [window insertSubview:view2 belowSubview:view3];
    }else
    {
        [window bringSubviewToFront:view];
        [window bringSubviewToFront:view2];
    }
    
}
-(BOOL)isHaveKindsScrollView
{
    UIWindow * window       = [UIApplication sharedApplication].windows[0];
    UIView * view           = [window viewWithTag:TAGOFSCROW];
    if (view) {
        return YES;
    }else
    {
        return NO;
    }
}

-(void)addKindsScrollView
{
    UIWindow * window       = [UIApplication sharedApplication].windows[0];
    if ([self isHaveKindsScrollView]) {
        return;
    }
    UIScrollView * myScroview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, HeightOfChannel)];
    //myScroview.backgroundColor= [UIColor redColor];
    myScroview.showsHorizontalScrollIndicator  = NO;
    myScroview.tag            = TAGOFSCROW;
    [myScroview addObserver:self forKeyPath:@"contentoffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    myScroview.delegate       = self;
    int KK = 0;
    float lastOriginX = 0;
    for (int i = 0; i<[_fs_GZF_ChannelListDAO.objectList count]; i++) {
        KK = i;
        FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:i];
        UIButton * button        = [UIButton buttonWithType:UIButtonTypeCustom];
        //button.backgroundColor   = [UIColor redColor];
        button.tag               = i;
        //button.frame             =  CGRectMake(i*WIDTHOFNAME, 0, WIDTHOFNAME, HeightOfChannel);
        
        UILabel * label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFNAME, HeightOfChannel)];
        label.backgroundColor    = [UIColor clearColor];
        label.tag                = 100;
        label.textAlignment      = UITextAlignmentCenter;
        //string                   = [NSString stringWithFormat:@"%@%@",string,@"-"];
        label.text               = CObject.channelname;
        //label.text               = string;
        label.userInteractionEnabled = NO;
        //label.autoresizingMask   = UIViewAutoresizingFlexibleWidth;
        [label sizeToFit];
        button.frame             = CGRectMake(lastOriginX, 0, label.frame.size.width + BORDER * 2, HeightOfChannel);
        
        label.frame              = CGRectMake(BORDER, (HeightOfChannel - label.frame.size.height)/2, label.frame.size.width, label.frame.size.height);
        lastOriginX              += button.frame.size.width;
        [button addSubview:label];
        label.tag                = 100;
        [label release];
        [button addTarget:self action:@selector(buttonCliCked:) forControlEvents:UIControlEventTouchUpInside];
        [myScroview addSubview:button];
        if (i == 0) {
            label.textColor      = [UIColor redColor];
        }else
        {
            label.textColor      = [UIColor lightGrayColor];
        }
    }
    UIView * view = [myScroview viewWithTag:0];
    myScroview.contentSize    = CGSizeMake(lastOriginX, HeightOfChannel);
    //myScroview.hidden         = YES;
    
    [window addSubview:myScroview];
    [window bringSubviewToFront:myScroview];
    [myScroview release];
    
    UIView * view3          = [window viewWithTag:3000];
    if (view3) {
        [window insertSubview:myScroview belowSubview:view3];
    }else
    {
        [window bringSubviewToFront:myScroview];
    }

    
    
    UIImageView *   topRedImageView          = [[UIImageView alloc]initWithFrame:CGRectMake(0, HeightOfChannel -4, view.frame.size.width, 4)];
    topRedImageView.image                    = [UIImage imageNamed:@"topSelected.png"];
    [myScroview addSubview:topRedImageView];
    topRedImageView.tag                      = TAGOFTOPIMAGE;
    [topRedImageView release];
    
    
    
    //[self addNewsScrollView];
    float tempSet = 0;
    if (!ISIOS7) {
        tempSet = 20;
    }
    UIView * lineView           = [[UIView alloc]initWithFrame:CGRectMake(0, HeightOfChannel - 1, 320*40, 1)];
    lineView.backgroundColor    = [UIColor redColor];
    [myScroview addSubview:lineView];
    [lineView release];
    
    //[self userGuideView];
}



-(void)initNaviBar
{
    UIWindow * window       = [UIApplication sharedApplication].windows[0];
    LygNavigationBar * bar  = [[LygNavigationBar alloc] init];
    
    CGRect rect             = bar.frame;
    
    if (!ISIOS7) {
        rect.origin.y       = 20;
        bar.frame           = rect;
    }
    
    bar.tag                 = TAGOFNAV;
    bar.tintColor = [UIColor whiteColor];
    [bar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    bar.userInteractionEnabled = YES;
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    
    


    bar.items = [NSArray arrayWithObject:navItem];
    [navItem release];
    [window addSubview:bar];
    [bar release];
    
    UIImageView *ivLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"peopleLogo.png"]];
	bar.topItem.titleView = ivLogo;
	[ivLogo release];
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], UITextAttributeFont,[UIColor blackColor],UITextAttributeTextColor,[NSValue valueWithCGSize:CGSizeMake(0, 0)],UITextAttributeTextShadowOffset,nil];
    bar.titleTextAttributes = dict;
    
    
    
    
    
    [window bringSubviewToFront:bar];
    
    
    NSDictionary * dict2            = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],UITextAttributeTextColor,[NSValue valueWithCGSize:CGSizeMake(0, 0)],UITextAttributeTextShadowOffset,nil];
    UIBarButtonItem   * barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"本地" style:UIBarButtonItemStylePlain target:self action:@selector(showLocalNews)];
    barButtonItem.tintColor           = [UIColor whiteColor];
    bar.topItem.rightBarButtonItem = barButtonItem;
    [barButtonItem release];
    
    
    [barButtonItem setTitleTextAttributes:dict2 forState:UIControlStateNormal];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self  showBar];
    
    
    if (self.fpChangeTitleColor) {
        [self performSelector:@selector(xxxxxx) withObject:self afterDelay:0.15];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showBar];
    if (_fs_GZF_ChannelListDAO.objectList == nil || _fs_GZF_ChannelListDAO.objectList.count == 0) {
        [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
    }
    
}

-(void)xxxxxx
{
    if (self.fpChangeTitleColor)
    {
        self.fpChangeTitleColor();
        self.fpChangeTitleColor = nil;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideBar];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //[self  hideBar];
}



-(void)showLocalNews
{
    LocalNewsViewController * local = [[LocalNewsViewController alloc]init];
    local.canBeHaveNaviBar          = YES;
    //local
    
    [self.navigationController pushViewController:local animated:YES];
    [local release];
}



-(void)initchannelNames
{
    
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
        
        
        
        LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:i andChannel:self.fs_GZF_ChannelListDAO andNaviGationController:self.navigationController];
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
        //[_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_ForceRefresh];
    }
    NSLog(@"%@",self.navigationController);
    //self.navigationController.delegate = self;
    return self;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];

    }

}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
//    NSArray * arry = previousViewControllers;
//    
//    LygNewsViewController * news = [previousViewControllers objectAtIndex:0];
//    int   x = news.channelIndex;
    
    if (completed) {
        //[self changeTitleColorBlock(5)];
        //[self changeTitleColorBlock];
        if (self.changeTitleColorBlock) {
             self.changeTitleColorBlock(0);
        }
       
    }
    self.changeTitleColorBlock = nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{

    LygNewsViewController * news = [pendingViewControllers objectAtIndex:0];
    int   x = news.channelIndex;
    
    NSLog(@"%d",x);
    
    
    self.changeTitleColorBlock = ^(int index){
        [self changeButtonColor:x];
        [self moveTheTitleScroview:x];
    };
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (ISIOS5) {
        return nil;
    }
    LygNewsViewController * temp = (LygNewsViewController*)viewController;
    if (temp.channelIndex == self.fs_GZF_ChannelListDAO.objectList.count -1) {
        return nil;
    }
    LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:temp.channelIndex+1 andChannel:self.fs_GZF_ChannelListDAO andNaviGationController:self.navigationController];
    return [xxx autorelease];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (ISIOS5) {
        return nil;
    }
    LygNewsViewController * temp = (LygNewsViewController*)viewController;
    if (temp.channelIndex == 0) {
        return nil;
    }
    LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:temp.channelIndex-1 andChannel:self.fs_GZF_ChannelListDAO andNaviGationController:self.navigationController];
    return [xxx autorelease];
}
-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    
    NSLog(@"doSomethingWithDAO：%@ :%d",sender,status);
    
    if ([sender isEqual:_fs_GZF_ChannelListDAO]) {
        NSLog(@"%d",[_fs_GZF_ChannelListDAO.objectList count]);
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            if ([_fs_GZF_ChannelListDAO.objectList count]>0) {

                
                [self addKindsScrollView];
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
    self.view.backgroundColor  = [UIColor whiteColor];
    [self initNaviBar];
    //[self addKindsScrollView];
	
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonCliCked:(UIButton*)sender
{
    //[self manuseletctbutton:sender.tag];
    [self changeButtonColor:sender.tag];
    _currentIndex = sender.tag;
    [self changTheContent];
}
-(void)manuseletctbutton:(int)x
{
    [self changeButtonColor:x];
    _currentIndex = x;
    
}

-(void)addStatic:(NSString*)channelName
{
    NSLog(@"%@",channelName);
    [PeopleNewsStati insertNewEventLabel:channelName andAction:CHANNELSELECT];
}

-(UIWindow*)getWindow
{
    return [UIApplication sharedApplication].windows[0];
}
-(UIScrollView*)getChannelNameView
{
    return (UIScrollView*)[[self getWindow] viewWithTag:TAGOFSCROW];
}
-(UIImageView*)getTopRedImageView
{
   return  (UIImageView*)[[self getChannelNameView] viewWithTag:TAGOFTOPIMAGE];
}
-(void)changeButtonColor:(int)index
{
    FSChannelObject *aObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:index];
    CGRect           rect    = [[self getChannelNameView] viewWithTag:index].frame;
    [self performSelectorInBackground:@selector(addStatic:) withObject:aObject.channelname];
    [UIView beginAnimations:@"sdfsadfsafsa" context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView commitAnimations];
    if (index == _currentIndex) {
        return;
    }
    UILabel * Label             = (UILabel*)[[[self getChannelNameView] viewWithTag:_currentIndex] viewWithTag:100];
    Label.textColor             = [UIColor lightGrayColor];
    
    Label                       = (UILabel*)[[[self getChannelNameView] viewWithTag:index] viewWithTag:100];
    Label.textColor             = [UIColor redColor];
    
    
    [self getTopRedImageView].frame      = CGRectMake(rect.origin.x, HeightOfChannel - 4, rect.size.width, 4);
    _currentIndex               = index;
}
-(void)changTheContent
{
    //UIViewController * controller = [self.viewControllers objectAtIndex:0];
    //[controller changeContent:_currentIndex];
    
    
    
    
    NSMutableArray * controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i++) {
        //        UIViewController * xxx = [[UIViewController alloc]init];
        //        xxx.view.backgroundColor     = [UIColor clearColor];
        //        [controllers addObject:xxx];
        
        
        
        LygNewsViewController * xxx = [[LygNewsViewController alloc] initWithChannelIndex:_currentIndex andChannel:self.fs_GZF_ChannelListDAO andNaviGationController:self.navigationController];
        [controllers addObject:xxx];
        [xxx release];
    }
    
    
    [self setViewControllers:controllers direction:nil animated:nil completion:nil];
    [controller release];
}







#pragma mark -
#pragma TabBardelegate
- (UIImage *)tabBarItemNormalImage {
	return [UIImage imageNamed:@"news.png"];
}

- (NSString *)tabBarItemText {
	return NSLocalizedString(@"新闻", nil);
}

- (UIImage *)tabBarItemSelectedImage {
	return [UIImage imageNamed:@"news_sel.png"];
}


-(void)moveTheTitleScroview:(int)index2
{
    UIWindow * window        = [UIApplication sharedApplication].windows[0];
    UIScrollView * scroView  = (UIScrollView*)[window viewWithTag:TAGOFSCROW];

    UIView * view = [scroView viewWithTag:index2];
    int index = view.frame.origin.x;
    int yyy   = scroView.contentOffset.x;
    if (index + view.frame.size.width - yyy > 320) {
        scroView.contentOffset = CGPointMake(index - 320 + view.frame.size.width, 0);
    }else if(yyy > index)
    {
        scroView.contentOffset = CGPointMake(index, 0);
    }
}

#pragma mark -----左右滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    UIWindow * window        = [UIApplication sharedApplication].windows[0];
//    UIScrollView * scroView  = (UIScrollView*)[window viewWithTag:2000];
//    if (scrollView == _myScroview) {
//        
//    }else{
//        int x = scrollView.contentOffset.x/320;
//        [self manuseletctbutton:x];
//        UIView * view = [_myScroview viewWithTag:x];
//        int index = view.frame.origin.x;
//        int yyy   = _myScroview.contentOffset.x;
//        if (index + view.frame.size.width - yyy > 320) {
//            _myScroview.contentOffset = CGPointMake(index - 320 + view.frame.size.width, 0);
//        }else if(yyy > index)
//        {
//            _myScroview.contentOffset = CGPointMake(index, 0);
//        }
//        if (index == _currentIndex) {
//            return;
//        }
//        MyNewsLIstView * view2 =  (MyNewsLIstView*)[scrollView viewWithTag:(100+x)];
//        [view2 isNeedRefresh]?[view2 refreshDataSource]:1;
//    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView == _myScroview) {
//        UIView * view               = [self.view viewWithTag:20000];
//        UIView * view3               = [self.view viewWithTag:30000];
//        _myScroview.contentOffset.x      < 10?(view.alpha = 0.05):(view.alpha = 1);
//        _myScroview.contentOffset.x + 10 > (_myScroview.contentSize.width - _myScroview.frame.size.width)?(view3.alpha = 0.05):(view3.alpha = 1);
//    }
}


@end

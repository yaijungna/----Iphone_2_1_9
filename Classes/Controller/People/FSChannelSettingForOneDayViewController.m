    //
//  FSChannelSettingForOneDayViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-16.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSChannelSettingForOneDayViewController.h"
//#import "FSUpdateNetworkFlagDAO.h"
#import "FSFocusTopObject.h"
#import "FSNewsContainerViewController.h"
#import "FS_GZF_ChannelListDAO.h"

#import "FSChannelObject.h"

#import "FSOneDayChannelSelectedDAO.h"

#import "FSBaseDB.h"
#import "FSChannelSelectedObject.h"

#import "FS_GZF_ForOnedayNewsFocusTopDAO.h"

#import "FSWebViewForOpenURLViewController.h"

#import "FSNewbieGuideView.h"
#import "FSUserSelectObject.h"

#define FSCHANNEL_SETTING_FOR_ONE_DAY_DISMISS_KIND__CLIP_TO_LEFT @"FSCHANNEL_SETTING_FOR_ONE_DAY_DISMISS_KIND__CLIP_TO_LEFT_STRING"

@implementation FSChannelSettingForOneDayViewController
@synthesize parentDelegate = _parentDelegate;
@synthesize isReSetting = _isReSetting;

- (id)init {
	self = [super init];
	if (self) {
		_isReSetting = NO;
	}
	return self;
}

- (void)dealloc {
	[_navTopBar release];
	//[_updateNetworkFlagData release];
    _fs_GZF_ChannelListDAO.parentDelegate = NULL;
	[_fs_GZF_ChannelListDAO release];
	[_channelSelectedData release];
    [_fsChannelSettingForOneDayView release];
    _fs_GZF_ForOnedayNewsFocusTopDAO.parentDelegate = NULL;
    [_fs_GZF_ForOnedayNewsFocusTopDAO release];
    [super dealloc];
}

- (void)initDataModel {
//	_updateNetworkFlagData = [[FSUpdateNetworkFlagDAO alloc] init];
//	_updateNetworkFlagData.parentDelegate = self;
//	[_updateNetworkFlagData setTimestampKind:TimestampKind_Channel];
	
	_fs_GZF_ChannelListDAO = [[FS_GZF_ChannelListDAO alloc] init];
	_fs_GZF_ChannelListDAO.parentDelegate = self;
    _fs_GZF_ChannelListDAO.type = @"0";
    _fs_GZF_ChannelListDAO.isGettingList = YES;
    
    _fs_GZF_ForOnedayNewsFocusTopDAO = [[FS_GZF_ForOnedayNewsFocusTopDAO alloc] init];
    _fs_GZF_ForOnedayNewsFocusTopDAO.group = SETTING_NEWS_LIST_KIND;
    _fs_GZF_ForOnedayNewsFocusTopDAO.type = @"news";
    _fs_GZF_ForOnedayNewsFocusTopDAO.channelid = @"";
    _fs_GZF_ForOnedayNewsFocusTopDAO.count = 3;
    _fs_GZF_ForOnedayNewsFocusTopDAO.parentDelegate = self;
}

- (void)loadChildView {
    _fsChannelSettingForOneDayView = [[FSChannelSettingForOneDayView alloc] init];
    _fsChannelSettingForOneDayView.parentDelegate = self;
    [self.view addSubview:_fsChannelSettingForOneDayView];
    
    
    //if (self.isReSetting) {
        
         _navTopBar = [[LygNavigationBar alloc]init];
         _navTopBar.tintColor = [UIColor whiteColor];
         NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], UITextAttributeFont,[UIColor blackColor],UITextAttributeTextColor,nil];
         _navTopBar.titleTextAttributes = dict;
         UINavigationItem *topItem = [[UINavigationItem alloc] init];
         NSArray *items = [[NSArray alloc] initWithObjects:topItem, nil];
         _navTopBar.items = items;
         _navTopBar.topItem.title = @"订阅我的头条";//NSLocalizedString([self setTitle], nil);
         [topItem release];
         [items release];
         [self.view addSubview:_navTopBar];
         
        
        UIButton *returnBT = [[UIButton alloc] init];
        [returnBT setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
       // [returnBT setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
        returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
        [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
        [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
        returnBT.frame = CGRectMake(0, 0, 55, 30);
        returnBT.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
        
        UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
        returnButton.tintColor       = [UIColor whiteColor];
        _navTopBar.topItem.leftBarButtonItem = returnButton;
    
        if (ISIOS7) {
            returnButton.tintColor = [UIColor darkGrayColor];
        }
        _navTopBar.tintColor         = [UIColor whiteColor];
        UIBarButtonItem * buttonxxxx = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(popFinished)];
        buttonxxxx.tintColor = [UIColor whiteColor];
        NSDictionary * dict2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],UITextAttributeTextColor,[NSValue valueWithCGSize:CGSizeMake(0, 0)],UITextAttributeTextShadowOffset,nil];
        [buttonxxxx setTitleTextAttributes:dict2 forState:UIControlStateNormal];
        _navTopBar.topItem.rightBarButtonItem = buttonxxxx;
    //[rightButton setTitleTextAttributes:dict2 forState:UIControlStateNormal];
        [buttonxxxx release];
        [returnButton release];
        [returnBT release];
    //}
//    else{
//        UIButton *returnBT = [[UIButton alloc] init];
//        [returnBT setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
//       // [returnBT setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
//        returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
//        
//        [returnBT addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
//        [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
//        returnBT.frame = CGRectMake(0, 0, 55, 30);
//        returnBT.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
//        
//        UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
//        self.navigationItem.leftBarButtonItem = returnButton;
//        [returnButton release];
//        [returnBT release];
//    }
    
    _fsChannelSettingForOneDayView.isReSetting = self.isReSetting;
    if (_isReSetting == NO) {
        _fsNewbieGuideView = [[FSNewbieGuideView alloc] init];
        _fsNewbieGuideView.parentDelegate = self;
        _fsNewbieGuideView.alpha = 0.0f;
        [self.view addSubview:_fsNewbieGuideView];
        [_fsNewbieGuideView release];
    }
    [self layoutControllerViewWithRect:self.view.frame];
    
    
    
}
-(void)popFinished
{
    NSArray *array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSChannelSelectedObject" key:@"channelid" ascending:YES];
    if ([array count]==0) {
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"请选择喜好的栏目!"
                                                withDelaySeconds:2.0f
                                                withPositionKind:PositionKind_Vertical_Horizontal_Center
                                                      withOffset:0.0f];
        [informationMessageView release];
        
        return;
    }
    
    [[GlobalConfig shareConfig] setPostChannel:YES];
    
    if (self.isReSetting) {
        if (self.presentingViewController) {
            [self dismissModalViewControllerAnimated:YES];
        }else if(self.navigationController){
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
                [_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
            }
            [self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
        }
    }
    else{
        if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
            [_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
        }
        [self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
        
    }

}


-(void)returnBack:(id)sender{
    if (self.isReSetting) {
        if (self.presentingViewController) {
            [self dismissModalViewControllerAnimated:YES];
        }else if(self.navigationController){
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
                [_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
            }
            [self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
        }
    }
    else{
        if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
            [_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
        }
        [self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
        
    }

}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
//    if (self.isReSetting) {
//        NSInteger k = [self retainCount];
//        for (NSInteger i=0; i<k-1; i++) {
//            [self release];
//        }
//    }
//    else{
//        ;
//    }
    
   // NSLog(@"%@.viewDidDisappear:%d",self,[self retainCount]);
}


- (void)layoutControllerViewWithRect:(CGRect)rect {
    float xxx = (ISIOS7?64:44);
    if (self.isReSetting){
        _fsChannelSettingForOneDayView.frame = CGRectMake(0.0f, xxx, rect.size.width, rect.size.height-xxx);
    }
    else{
        _fsChannelSettingForOneDayView.layoutWithLocalData = YES;
        _fsChannelSettingForOneDayView.data = @"11";
        _fsChannelSettingForOneDayView.frame = CGRectMake(0.0f, xxx, rect.size.width, rect.size.height-xxx);
    }
    
    
    if (!self.isReSetting) {
        _fsNewbieGuideView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height+xxx);
        _fsNewbieGuideView.alpha = 1.0f;
        [self.view bringSubviewToFront:_fsNewbieGuideView];
        [_fsNewbieGuideView doSomethingAtLayoutSubviews];
        //self.navigationController.navigationBarHidden = YES;
    }
    
}

- (void)doSomethingForViewFirstTimeShow {
    //[_fs_GZF_ForOnedayNewsFocusTopDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    
    [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
}


#pragma mark - 
#pragma FSTableContainerViewDelegate mark


#pragma mark -
#pragma mark 私有动画
- (void)finishChannelSettingForOneDay:(id)sender {
	//[self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];

	
}

- (void)dismissWithKind:(FSChannelSettingForOneDayDismissKind)kind {
    
	if (kind == FSChannelSettingForOneDayDismissKind_ClipToLeft) {
		self.navigationController.view.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
		self.navigationController.view.layer.position = CGPointMake(0.0f, self.navigationController.view.layer.bounds.size.height / 2.0f);
		
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
		//self.navigationController.view.layer.position = CGPointMake(0.0f, self.navigationController.view.layer.position.y);
		animation.duration = 0.5;
		animation.repeatCount = 1;
		animation.removedOnCompletion = NO;
		animation.fillMode = kCAFillModeForwards;
		animation.delegate = self;

		
		CATransform3D sublayerTransform = self.navigationController.view.layer.transform;//CATransform3DIdentity;
		sublayerTransform.m34 = -0.001;//-0.0008;//-0.01;
		
		animation.fromValue = [NSValue valueWithCATransform3D:sublayerTransform];
		CATransform3D toTransform = CATransform3DRotate(sublayerTransform, 0.5 * M_PI, 0.0f, -1.0f, 0.0f);
		animation.toValue = [NSValue valueWithCATransform3D:toTransform];
//		animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI,0,1.0,0)];
		
		[self.navigationController.view.layer addAnimation:animation forKey:FSCHANNEL_SETTING_FOR_ONE_DAY_DISMISS_KIND__CLIP_TO_LEFT];
		
	} else if (kind == FSChannelSettingForOneDayDismissKind_DismissModalViewController) {
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (flag) {
#ifdef MYDEBUG
		NSLog(@"animation.FSChannelSettingForOneDay...");
#endif
		[self.navigationController.view.layer removeAnimationForKey:FSCHANNEL_SETTING_FOR_ONE_DAY_DISMISS_KIND__CLIP_TO_LEFT];
		if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerDidDisapper:)]) {
			[_parentDelegate fsChannelSettingForOneDayViewControllerDidDisapper:self];
		}
	}
}


-(void)fsBaseContainerViewTouchEvent:(FSBaseContainerView *)sender{
    
    if ([sender isKindOfClass:[FSNewbieGuideView class]]) {
        //self.navigationController.navigationBarHidden = NO;
        return;
    }
    
    
    FSChannelSettingForOneDayView *o = (FSChannelSettingForOneDayView *)sender;
    if (!o.isSettingFinish) {
        if (o.touchImageNewsIndex<[_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]) {
            FSFocusTopObject *obj = [_fs_GZF_ForOnedayNewsFocusTopDAO.objectList objectAtIndex:o.touchImageNewsIndex];

            
            if ([obj.flag isEqualToString:@"1"]) {
                FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
                fsNewsContainerViewController.newsSourceKind = NewsSourceKind_PuTongNews;
                fsNewsContainerViewController.obj = nil;
                fsNewsContainerViewController.FCObj = obj;
                if (self.isReSetting) {
                    fsNewsContainerViewController.isNewNavigation = YES;
                    [self presentModalViewController:fsNewsContainerViewController animated:YES];
                }
                else{
                    [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
                }
                [fsNewsContainerViewController release];
                [[FSBaseDB sharedFSBaseDB] updata_visit_message:obj.channelid];
            }
            else if ([obj.flag isEqualToString:@"2"]){
                NSURL *url = [[NSURL alloc] initWithString:obj.link];
                [[UIApplication sharedApplication] openURL:url];
                [url release];
            }
            else if ([obj.flag isEqualToString:@"3"]){
                
                FSWebViewForOpenURLViewController *fsWebViewForOpenURLViewController = [[FSWebViewForOpenURLViewController alloc] init];
                
                fsWebViewForOpenURLViewController.urlString = obj.link;
                
                if (self.isReSetting) {
                    fsWebViewForOpenURLViewController.withOutToolbar = NO;
                    [self presentModalViewController:fsWebViewForOpenURLViewController animated:YES];
                }
                else{
                    fsWebViewForOpenURLViewController.withOutToolbar = NO;
                    [self.navigationController pushViewController:fsWebViewForOpenURLViewController animated:YES];
                }
                [fsWebViewForOpenURLViewController release];
                
                
            }
        }
        return;
    }
    
    [[GlobalConfig shareConfig] setPostChannel:YES];
    if (self.isReSetting) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
        if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
            [_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
        }
        [self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
    }
    
    
    return;
    
    
    /*
    if ([sender isKindOfClass:[FSChannelSettingForOneDayView class]]) {
        FSChannelSettingForOneDayView *o = (FSChannelSettingForOneDayView *)sender;
        if (o.isSettingFinish) {
            NSLog(@"设置完成.......");//设置完成.......
            if (_channelSelectedData == nil) {
                _channelSelectedData = [[FSOneDayChannelSelectedDAO alloc] init];
                _channelSelectedData.parentDelegate = self;
            }
            NSArray *channelObject = [[FSBaseDB sharedFSBaseDB] getAllObjectWithName:@"FSChannelSelectedObject"];
            
            NSMutableArray *channelIDs = [[NSMutableArray alloc] init];
            
            for (FSChannelSelectedObject *o in channelObject) {
                [channelIDs addObject:o.channelid];
                NSLog(@":%@",o.channelid);
            }
            //NSArray *channelIDs = [[NSArray alloc] initWithObjects:@"1_6", @"1_7", @"1_8", @"1_1", nil];
            _channelSelectedData.channelIDs = channelIDs;
            [channelIDs release];
            
            [_channelSelectedData HTTPPostDataWithKind:HTTPPOSTDataKind_Normal];
            
        }
    }
	*/
	
    
//    if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
//		[_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
//	}
//	[self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
}

#pragma mark -
#pragma mark 数据回调
- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
    NSLog(@"doSomethingWithDAO:%@,%d",sender,status);
    _fsChannelSettingForOneDayView.layoutWithLocalData = NO;
    if ([sender isEqual:_fs_GZF_ForOnedayNewsFocusTopDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus ||
			status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            //NSLog(@"_fsForChannelSettingFocusTopData:%d",[_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]);
            
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                [_fs_GZF_ForOnedayNewsFocusTopDAO operateOldBufferData];
                [_fs_GZF_ChannelListDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
                
            }
            
            NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
            if ([_fs_GZF_ChannelListDAO.objectList count]>0) {
                //[array addObject:_channelListData.objectList];
                [array setValue:_fs_GZF_ChannelListDAO.objectList forKey:@"FSChannelIconsContainerView"];
            }
            
            if ([_fs_GZF_ForOnedayNewsFocusTopDAO.objectList count]>0) {
                [array setValue:_fs_GZF_ForOnedayNewsFocusTopDAO.objectList forKey:@"FSImagesScrInRowView"];
            }
            //_fsChannelSettingForOneDayView.layoutWithLocalData = YES;
            _fsChannelSettingForOneDayView.data = array;
            [array release];
            
        }
        
    }
	if ([sender isEqual:_fs_GZF_ChannelListDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus) {
            NSLog(@"_fs_GZF_ChannelListDAO:%d",[_fs_GZF_ChannelListDAO.objectList count]);
            
            ;
            //FSChannelObject * changeleobject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
            //FSChannelObject *CObject = [_fs_GZF_ChannelListDAO.objectList objectAtIndex:0];
            if ([_fs_GZF_ChannelListDAO.objectList count] > 0) {
                NSArray * arry = [[FSBaseDB sharedFSBaseDB]getObjectsByKeyWithName:@"FSUserSelectObject" key:nil value:nil];
                [[FSBaseDB sharedFSBaseDB] deleteObjectByObjectS:arry];
                for (FSChannelObject *CObject in _fs_GZF_ChannelListDAO.objectList) {
                    FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
                    
                    sobj.kind = @"YAOWENCHANNEL";
                    sobj.keyValue1 = CObject.channelname;
                    sobj.keyValue2 = CObject.channelid;

                }
                [FSBaseDB saveDB];
                [_fs_GZF_ChannelListDAO.objectList removeObjectAtIndex:0];
            }
           
            
        
            
            
 
        }
		if (status == FSBaseDAOCallBack_SuccessfulStatus ||
			status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            NSLog(@"_fs_GZF_ChannelListDAO:%d",[_fs_GZF_ChannelListDAO.objectList count]);

            if (!self.isReSetting && ![[GlobalConfig shareConfig] isPostChannel]) {
                NSArray *resultSets = _fs_GZF_ChannelListDAO.objectList;
                for (int i = 0; i < [resultSets count]; i++) {
                    FSChannelObject *obj = [resultSets objectAtIndex:i];
                    NSLog(@"channelListData.obj:%@", obj.channel_request);
                    if (i>2) {
                        break;
                    }
                    [[FSBaseDB sharedFSBaseDB] updata_oneday_selectChannel_message:obj.channelid];
                }
                //[[GlobalConfig shareConfig] setPostChannel:YES];
            }
            _fsChannelSettingForOneDayView.data = _fs_GZF_ChannelListDAO.objectList;
            if (status == FSBaseDAOCallBack_SuccessfulStatus){
                [_fs_GZF_ChannelListDAO operateOldBufferData];
            }
            
		}
	}
    
    /*else if ([sender isEqual:_channelSelectedData]) {
		if (status == FSBaseDAOCallBack_SuccessfulStatus) {
			if (_channelSelectedData.errorCode == 0) {
				if ([_parentDelegate respondsToSelector:@selector(fsChannelSettingForOneDayViewControllerWillDisapear:)]) {
                    [_parentDelegate fsChannelSettingForOneDayViewControllerWillDisapear:self];
                }
                [[GlobalConfig shareConfig] setPostChannel:YES];
                [self dismissWithKind:FSChannelSettingForOneDayDismissKind_ClipToLeft];
			} else {
				FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectZero];
				[informationMessageView showInformationMessageViewInView:self.view 
															 withMessage:_channelSelectedData.errorMessage
														withDelaySeconds:0 
														withPositionKind:PositionKind_Vertical_Horizontal_Center 
															  withOffset:0.0f];
				[informationMessageView release];
			}

		}
	}
     */
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return (interfaceOrientation == UIInterfaceOrientationPortrait ||
                interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}


@end

//
//  PeopleNewsReaderPhoneAppDelegate.h
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-7-30.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FSUINavigationController.h"
#import "FSLoadingImageView.h"
#import "WXApi.h"
#import <MapKit/MapKit.h>
#import "FS_GZF_GetWeatherMessageDAO.h"
#import "YXApi.h"
#import "YXApiObject.h"
#import "FSCheckAppStoreVersionObject.h"
//#import "MobClick.h"
NSString * getCityName();
NSString * getProvinceName();

@class FSTabBarViewCotnroller;
@class FSSlideViewController;
@class FSChannelSettingForOneDayViewController;
@class FSNewsContainerViewController;

@interface PeopleNewsReaderPhoneAppDelegate : NSObject <UIApplicationDelegate,FSLoadingImageViewDelegate,WXApiDelegate,YXApiDelegate,CLLocationManagerDelegate> {
	FSUINavigationController *_navChannelSettingController;
	FSSlideViewController *_slideViewController;
    FSTabBarViewCotnroller *_rootViewController;
    UIWindow *window;
    CLLocationManager *_locManager;
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    
    NSDictionary *pushInof;
    NSTimeInterval _TimeForeground;
    
    FSNewsContainerViewController *_fsNewsContainerViewController_forPush;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel   *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, copy)             NSString               * cityName;
@property (nonatomic, strong)           NSString               * provinceName;
@property (nonatomic, retain)           FS_GZF_GetWeatherMessageDAO * fs_GZF_localGetWeatherMessageDAO;
@property (nonatomic, retain)           FS_GZF_GetWeatherMessageDAO * fs_GZF_localGetWeatherMessageDAO2;
@property (nonatomic,retain)            FSCheckAppStoreVersionObject* checkVersionObject;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

//微信
-(void)ShareWeiXinSetting;
- (BOOL)sendWXTextMessage:(NSString *)content;
- (BOOL)sendWXMidiaMessage:(NSString *)title content:(NSString *)content thumbImage:(UIImage *)thumbImage webURL:(NSString *)webURL;
- (BOOL)sendWXMidiaMessagePYQ:(NSString *)title content:(NSString *)content thumbImage:(UIImage *)thumbImage webURL:(NSString *)webURL;
//友盟
-(NSString *)macString;

//激活统计
-(void)postStatistice;


//推送
-(void)DidRecivePushMessage:(NSDictionary *)Inof;
-(void)ShowPushMessage:(NSDictionary *)Inof;
//更新更多界面
-(void)updateMoreControllerView;
//易信
- (BOOL)sendYXMidiaMessage:(NSString *)title content:(NSString *)content thumbImage:(UIImage *)thumbImage webURL:(NSString *)webURL  sendType:(int)isPYQ;
@end


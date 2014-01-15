//
//  FSCheckAppStoreVersionObject.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-9-12.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSCheckAppStoreVersionObject.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"
static void releaseSomeThing(id a)
{
//    [a release];
//    a = nil;
    PeopleNewsReaderPhoneAppDelegate * delegate =   (PeopleNewsReaderPhoneAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.checkVersionObject release];
    
}
@implementation FSCheckAppStoreVersionObject

@synthesize isManual = _isManual;

- (id)init {
	self = [super init];
	if (self) {
		_checkData = [[FSCheckAppStoreVersionDAO alloc] init];
		_checkData.parentDelegate = self;
        _isManual = NO;
	}
	return self;
}

- (void)dealloc {
#ifdef MYDEBUG
	NSLog(@"%@.dealloc.FSCheckAppStoreVersionObject", self);
#endif
    _checkData.parentDelegate = nil;
	[_checkData release];
    _checkData  = nil;
	[super dealloc];
}

- (void)dataAccessObjectSync:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
	if ([sender isEqual:_checkData]) {
		if (status == FSBaseDAOCallBack_SuccessfulStatus) {
			if (_checkData.hasNewsAppStoreVersion) {
				//NSString *alertTile = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
                NSString * xxx = [NSString stringWithFormat:@"请更新到%@版",_checkData.appStoreVersion];
				UIAlertView *alertUpdate = [[UIAlertView alloc] initWithTitle:xxx
																	  message:_checkData.appStoreReleaseNotes 
																	 delegate:self 
															cancelButtonTitle:NSLocalizedString(@"下次再说", nil)
															otherButtonTitles:NSLocalizedString(@"前往更新", nil), nil];
				[alertUpdate show];
				[alertUpdate release];
			} else {
                if (self.isManual && _checkData.isNewsAppStoreVersion) {
                    NSString *alertTile = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
                    UIAlertView *alertUpdate = [[UIAlertView alloc] initWithTitle:alertTile
                                                                          message:@"已经是最新版本"
                                                                         delegate:NULL
                                                                cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                                otherButtonTitles:nil];
                    [alertUpdate show];
                    [alertUpdate release];
                }
			}
            [self release];
		} else {
			if (status != FSBaseDAOCallBack_WorkingStatus) {
                if (self.isManual) {
                    NSString *alertTile = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
                    UIAlertView *alertUpdate = [[UIAlertView alloc] initWithTitle:alertTile
                                                                          message:@"检测版本失败"
                                                                         delegate:NULL
                                                                cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                                otherButtonTitles:nil];
                    [alertUpdate show];
                    [alertUpdate release];
                }
				[self release];
			}
		}
	}
}

- (void)meRelease {
	[self release];

}

- (void)checkAppVersion:(NSString *)appID {
	//[self retain];
	_checkData.applicationID = appID;
	_checkData.parentDelegate = self;
	[_checkData HTTPGetDataWithKind:GETDataKind_Refresh];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		NSURL *url = [[NSURL alloc] initWithString:_checkData.appStoreTrackViewUrl];
		[[UIApplication sharedApplication] openURL:url];
		[url release];
	}
    releaseSomeThing(self);
}

@end

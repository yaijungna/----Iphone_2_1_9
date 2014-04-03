//
//  FSNetEaseBlogShareViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-7.
//
//
#import "WeiboWrapper.h"
#import "FSNetEaseBlogShareViewController.h"
#import "WeiboCommonAPI.h"
#define KEY_NETEASE @"V0skcKbagsimroli"
#define SECRETKEY_NETEASE @"lco2cORI8YVujqtoUfsC9cnkPQJuZdOh"
@interface FSNetEaseBlogShareViewController ()

@end

@implementation FSNetEaseBlogShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"网易微博分享";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)doSomethingForViewFirstTimeShow{
    _engine = [[NetEaseEngine alloc] init];
	_engine.parentDelegate = self;
}

-(void)initDataModel{

}

-(void)postShareMessage{
    
    self.shareContent = [_fsBlogShareContentView getShareContent];
    
    if ([self.shareContent length] == 0) {
        ;
		return;
	}
    if ([_engine isLogIn]) {
//        WeiboCommonAPI * weiboApi = [[WeiboCommonAPI alloc]init];
//        weiboApi.oauthKey.tokenKey    =  _engine.accessTokenKey;
//        weiboApi.oauthKey.tokenSecret =  _engine.accessTokenSecrect;
//        weiboApi.oauthKey.callbackUrl = nil;
//        weiboApi.oauthKey.consumerKey = KEY_NETEASE;
//        weiboApi.oauthKey.consumerSecret = SECRETKEY_NETEASE;
//        NSString * string = [[NSBundle mainBundle]pathForResource:@"icon" ofType:@"png"];
//        [weiboApi publishMessageWithContent:self.shareContent andBlogId:4 andImagePath:string];
        //[weiboApi publishMessageWithContent:self.shareContent andBlogId:4 andData:self.dataContent];
          [_engine  sendNetEaseContent:self.shareContent];
	} else {
        if (self.withnavTopBar) {
            FSNetEaseBlogShareLoginViewController *fsNetEaseBlogShareLoginViewController = [[FSNetEaseBlogShareLoginViewController alloc] init];
            fsNetEaseBlogShareLoginViewController.isnavTopBar = YES;
            fsNetEaseBlogShareLoginViewController.engine = _engine;
            fsNetEaseBlogShareLoginViewController.parentDelegate = self;
            [self presentModalViewController:fsNetEaseBlogShareLoginViewController animated:YES];
            [fsNetEaseBlogShareLoginViewController release];
        }
        else{
            FSNetEaseBlogShareLoginViewController *fsNetEaseBlogShareLoginViewController = [[FSNetEaseBlogShareLoginViewController alloc] init];
            fsNetEaseBlogShareLoginViewController.engine = _engine;
            fsNetEaseBlogShareLoginViewController.parentDelegate = self;
            [self.navigationController pushViewController:fsNetEaseBlogShareLoginViewController animated:YES];
            [fsNetEaseBlogShareLoginViewController release];
        }
		
	}
}

//nnetEaseEngine

- (void)loginSuccessful:(id)sender {
	//NSLog(@"1111111111");
}

-(void)loginSuccesss:(BOOL)isSuccess{
   // NSLog(@"2222222");

    if (isSuccess) {
        if ([_engine isLogIn]) {
            if (self.dataContent==nil) {
                [_engine sendNetEaseContent:self.shareContent];
            }else{
                [_engine NetEaseUpdataImage:self.dataContent];
            }
        }
    }
    else{
        
    }
}


- (void)netEaseEngineEndSending:(NetEaseEngine *)sender withSuccess:(BOOL)success {
	
	if (success) {
        /*
		FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"分享成功"
                                                withDelaySeconds:1.2
                                                withPositionKind:PositionKind_Horizontal_Center
                                                      withOffset:40.0f];
        [informationMessageView release];
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_SUCCESSFUL_NOTICE object:self userInfo:nil];
        [self performSelector:@selector(returnToParentView) withObject:nil afterDelay:0.0];
	} else {
        /*
        FSInformationMessageView *informationMessageView = [[FSInformationMessageView alloc] initWithFrame:CGRectMake(70, 70, 70, 70)];
        informationMessageView.parentDelegate = self;
        [informationMessageView showInformationMessageViewInView:self.view
                                                     withMessage:@"分享失败"
                                                withDelaySeconds:1.2
                                                withPositionKind:PositionKind_Horizontal_Center
                                                      withOffset:40.0f];
        [informationMessageView release];
         */
        _fsShareNoticView.data = @"分享失败！";
        _fsShareNoticView.backgroundColor = COLOR_CLEAR;
        _fsShareNoticView.alpha = 1.0f;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:2.0];
        _fsShareNoticView.alpha = 0.0f;
        [UIView commitAnimations];
        
	}
    
    
}


@end

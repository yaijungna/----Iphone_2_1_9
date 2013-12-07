//
//  FSDeepTextViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-10-29.
//
//

#import "FSDeepTextViewController.h"
#import "FSDeepContentObject.h"
#import "FS_GZF_DeepTextDAO.h"
#import "FSCommentListViewController.h"
//评论块
//@"<div class='comment_block_even'><div class='comment_title_row'><span class='comment_nickname'>%@</span><span class='comment_datetime'>%@</span></div><div class='comment_body'>%@</div><div class='comment_comefrom'></div></div><HR class='comment_HR' width='100'>"
//#define CONTENTWEBVIEW_COMMENT_BLOCK @"<div class='comment_block_even'>" \
"<div class='comment_title_row'>" \
"<span class='comment_nickname'>%@</span><span class='comment_datetime'>%@</span>" \
"</div>" \
"<div class='comment_body'>%@</div>" \
"<div class='comment_comefrom'>%@</div>" \
"</div>" \
"<HR class='comment_HR' width='100%'>"

//管理员回复块
#define CONTENTWEBVIEW_COMMENT_RE_BLOCK @"<div class='comment_block_even'>" \
"<div class='comment_title_row'>" \
"<a class='photo_admin'><img src='Comment_talk@2x.png' width=20 height=20 /></a> <span class='comment_admin'>%@</span><span class='comment_datetime'>%@</span>" \
"</div>" \
"<div class='comment_REbody'>%@</div>" \
"<div class='comment_comefrom'>%@</div>" \
"</div>" \
"<HR class='comment_REHR' width='100%'>"



//评论描述
#define CONTENTWEBVIEW_COMMENT_TITLE_DESC @"<div id='comment_desc'>" \
"<span id='comment_title_desc'>网友热评</span>" \
"</div>"

//#define CONTENTWEBVIEW_COMMENT_TITLE_NODESC @"<div id='comment_desc'>" \
"<span id='comment_title_desc'>暂无评论</span>" \
"</div>"

#define CONTENTWEBVIEW_COMMENT_TITLE_NODESC @"<div></div>"

//更多评论按钮
#define CONTENTWEBVIEW_COMMENT_MORE @"<div id='comment_more_list'>" \
"<a href='more://comment.list'><button class='comment_more_list' title='更多'>查看更多评论</button></a>" \
"</div>"

#define CONTENTWEBVIEW_COMMENT_MORE_LINK @"more://comment.list"

@interface FSDeepTextViewController ()

@end

@implementation FSDeepTextViewController
@synthesize contentid = _contentid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showMoreComment:) name:@"deepMoreComment" object:nil];
	// Do any additional setup after loading the view.
}

-(void)showMoreComment:(NSNotification*)sender
{
    UINavigationController * navi = (UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController);
    FSCommentListViewController *fsCommentListViewController = [[FSCommentListViewController alloc] init];
    fsCommentListViewController.deepid = sender.object;
    //        fsCommentListViewController.withnavTopBar                = YES;
    fsCommentListViewController.isnavTopBar             = YES;
    //fsCommentListViewController.newsid = _fs_GZF_CommentListDAO.newsid;
    //[self.navigationController pushViewController:fsCommentListViewController animated:YES];
    //[self presentViewController:fsCommentListViewController animated:YES completion:nil];
    [navi pushViewController:fsCommentListViewController animated:YES];
    [fsCommentListViewController release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    _textData.parentDelegate = nil;
//    [_textData release];
    [_fs_GZF_DeepTextWebView release];
    [_contentid release];
//    [_textView release];
    _fs_GZF_DeepTextDAO.parentDelegate = NULL;
    [_fs_GZF_DeepTextDAO release];
//    [_fs_GZF_DeepTextView release];
    
    [super dealloc];
}

- (void)initDataModel {
//    _textData = [[FSDeepTextDAO alloc] init];
//    _textData.parentDelegate = self;
    
    _fs_GZF_DeepTextDAO = [[FS_GZF_DeepTextDAO alloc] init];
    _fs_GZF_DeepTextDAO.parentDelegate = self;
    
}

- (void)doSomethingForViewFirstTimeShow {
    //NSLog(@"1111111 77777");
   // _textData.contentid = _contentid;
    //NSLog(@"???????");
    //[_textData GETData];
    //NSLog(@"doSomethingForViewFirstTimeShow FSDeepTextViewController");
    
    _fs_GZF_DeepTextDAO.deepid = _contentid;
    [_fs_GZF_DeepTextDAO HTTPGetDataWithKind:GET_DataKind_Refresh];
    self.canDELETE = NO;
}

- (void)loadChildView {
    self.view.backgroundColor = [UIColor whiteColor];
 
//    _textView = [[FSDeepTextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
//    _textView = [[FSDeepContentTextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
//    _textView.pictureFlag = _textData.pictureFlag;
//    _textView.textFlag = _textData.textFlag;
    
//    _textView.pictureFlag = FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
//    _textView.textFlag = FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
    
    //_textView.delegate = self;
    //[self.view addSubview:_textView];
    
    
//    _fs_GZF_DeepTextView = [[FS_GZF_DeepTextView alloc] initWithFrame:CGRectZero];
//    _fs_GZF_DeepTextView.pictureFlag = FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
//    _fs_GZF_DeepTextView.textFlag = FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
//    
//    [self.view addSubview:_fs_GZF_DeepTextView];
    
    _fs_GZF_DeepTextWebView = [[FS_GZF_DeepTextWebView alloc] initWithFrame:CGRectZero];
    _fs_GZF_DeepTextWebView.pictureFlag = FSDEEP_TEXT_CHILD_PIC_NODE_FLAG;
    _fs_GZF_DeepTextWebView.textFlag = FSDEEP_TEXT_CHILD_TXT_NODE_FLAG;
    _fs_GZF_DeepTextWebView.getCommentListDao = self.getCommentListDao;
    
    [self.view addSubview:_fs_GZF_DeepTextWebView];
}

- (void)layoutControllerViewWithRect:(CGRect)rect {
   // _textView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    //_fs_GZF_DeepTextView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
    _fs_GZF_DeepTextWebView.frame = CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}

- (void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status {
     NSLog(@"doSomethingWithDAO:%@,%d,%@",sender,status,_fs_GZF_DeepTextWebView);
//    if ([sender isEqual:_textData]) {
//        if (status == FSBaseDAOCallBack_BufferSuccessfulStatus ||
//            status == FSBaseDAOCallBack_SuccessfulStatus) {
//            FSDeepContentObject *contentObj = (FSDeepContentObject *)_textData.contentObject;
//            FSLog(@"deepContentObject:%@", contentObj);
//            FSLog(@"deepContentChildObject:%@", contentObj.childContent);
//            FSLog(@"deepContentChildObject.count:%d", [contentObj.childContent count]);
//            
//            _textView.contentObject = contentObj;
//        }
//    }
    
    if ([sender isEqual:_fs_GZF_DeepTextDAO]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
                        
            if (status == FSBaseDAOCallBack_SuccessfulStatus) {
                //[_fs_GZF_DeepTextDAO operateOldBufferData];
                FSDeepContentObject *contentObj = _fs_GZF_DeepTextDAO.fsDeepContentObject;
                if (contentObj!=nil) {
                    _fs_GZF_DeepTextWebView.title = _Deep_title;
                    _fs_GZF_DeepTextWebView.data  = contentObj;
                    _canDELETE = YES;
//                    NSMutableDictionary * tempDict = [[NSMutableDictionary alloc]init];
//                    [tempDict setValue:contentObj.share_img forKey:@"share_img"];
//                    [tempDict setValue:contentObj.share_url forKey:@"share_url"];
//                    [tempDict setValue:contentObj.share_text forKey:@"share_text"];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeShareContent" object:tempDict];
//                    [tempDict release];
//                    NSLog(@"show _fs_GZF_DeepTextWebView");
                }
                
                
            }
        }
        [self.getCommentListDao HTTPGetDataWithKind:GET_DataKind_Refresh];
    }
    else if ([sender isEqual:self.getCommentListDao])
    {
       // [self processCommentList];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCommentList" object:self.getCommentListDao userInfo:nil];
    }
}
-(void)processCommentList
{
//    FSDeepCommentObject * tmp = [self.getCommentListDao.objectList objectAtIndex:0];
//    NSLog(@"%@",tmp.commentid);
    [self reSetCommentString:Nil];
}
-(void)reSetCommentString:(NSString *)commentStr{
    commentStr = @"";
    commentStr = [self processCommentList:@""];
    [_fs_GZF_DeepTextWebView.webView  performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:[NSString stringWithFormat:@"document.getElementById('comment').innerHTML=\"%@\"", commentStr] afterDelay:0.2];
    
}

-(NSString *)processCommentList:(NSString *)templateString{
    NSString * str1 = @"<div class='comment_block_even'><div class='comment_title_row'><span class='comment_nickname'>%@</span><span class='comment_datetime'>%@</span></div><div class='comment_body'>%@</div><div class='comment_comefrom'></div></div><HR class='comment_HR' width='100'>";
    NSString * str2 = @"<div class='comment_block_even'><div class='comment_title_row'><a class='photo_admin'><img src='Comment_talk@2x.png' width=20 height=20 /></a> <span class='comment_admin'>%@</span><span class='comment_datetime'>%@</span></div><div class='comment_REbody'>%@</div><div class='comment_comefrom'>%@</div></div><HR class='comment_REHR' width='100%'>";
    
    if ([self.getCommentListDao.objectList count]==0) {
        return CONTENTWEBVIEW_COMMENT_TITLE_NODESC;
    }
    
    templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_TITLE_DESC];
    
    NSArray *array = (NSArray *)self.getCommentListDao.objectList;
    if ([array count]>5) {
        for (int i = 0; i < 5; i++) {
            FSDeepCommentObject *o = [array objectAtIndex:i];
            NSString *nickName = o.nickname;
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
            
            NSString *datetime = timeIntervalStringSinceNow(date);
            [date release];
            NSString *body = o.content;
            body = [body stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
            body = [body stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
            NSString *comefrom = @"";
            
            NSString *strCommentBlock = [NSString stringWithFormat:str1, nickName, datetime, body, comefrom];
            NSLog(@"%@",strCommentBlock);
            templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentBlock];
            
            if ([o.nickname length]>0) {
                NSString *admin = o.nickname;
                NSDate *REdate = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
                NSString *REdatetime = timeIntervalStringSinceNow(REdate);
                NSString *REbody = o.content;
                NSString *strCommentREBlock = [NSString stringWithFormat:str2, admin, REdatetime, REbody, comefrom];
                templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentREBlock];
            }
            
        }
        templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_MORE];
    }
    else{
        for (FSDeepCommentObject *o in array) {
            NSString *nickName = o.nickname;
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
            
            NSString *datetime = timeIntervalStringSinceNow(date);
            [date release];
            
            NSString *body = o.content;
            body = [body stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
            body = [body stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
            body = [body stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
            NSString *comefrom = @"";
            NSString *strCommentBlock = [NSString stringWithFormat:str1, nickName, datetime, body, comefrom];
            templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentBlock];
            
            if ([o.nickname length]>0) {
                NSString *admin = o.nickname;
                NSDate *REdate = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
                NSString *REdatetime = timeIntervalStringSinceNow(REdate);
                NSString *REbody = o.content;
                NSString *strCommentREBlock = [NSString stringWithFormat:str1, admin, REdatetime, REbody, comefrom];
                templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentREBlock];
            }
        }
        
    }
    
    
    return templateString;
}




@end

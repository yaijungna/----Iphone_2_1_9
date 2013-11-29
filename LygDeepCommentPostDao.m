//
//  LygDeepCommentPostDao.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-28.
//
//

#import "LygDeepCommentPostDao.h"
//#define COMMENT_UPDATA_URL @"http://mobile.app.people.com.cn:81/news2/news.php?&act=postcomment"
#define DEEPCOMMENT_UPDATA_URL @"http://mobile.app.people.com.cn:81/topic/topic.php?act=post_comment"
#define DEEPCOMMENT_POST_RESULT_ERROR @"errorCode"
#define DEEPCOMMENT_POST_RESULT_DEEPID @"deepid"
#define DEEPCOMMENT_POST_RESULT_COUNT @"commentCount"

@implementation LygDeepCommentPostDao

- (id)init {
	self = [super init];
	if (self) {
		self.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
		self.errorCode = 0;
	}
	return self;
}

- (NSString *)HTTPPostURLString {
	return DEEPCOMMENT_UPDATA_URL;
}

- (void)HTTPBuildPostItems:(NSMutableArray *)postItems withPostKind:(HTTPPOSTDataKind)postKind {
    UIDevice * device = [UIDevice currentDevice];
	//内容  devicetype=ios,content=@"",newsid=12346,nickname=user,columnid=channelid
    FSHTTPPOSTItem *devicetype = [[FSHTTPPOSTItem alloc] initWithName:@"os_type" withValue:device.systemName];
    [postItems addObject:devicetype];
    [devicetype release];
    
    
    FSHTTPPOSTItem *newsid = [[FSHTTPPOSTItem alloc] initWithName:@"deepid" withValue:self.deepid];
    [postItems addObject:newsid];
    [newsid release];
    
    
    
    FSHTTPPOSTItem *columnid = [[FSHTTPPOSTItem alloc] initWithName:@"os_ver" withValue:device.systemVersion];
    [postItems addObject:columnid];
    [columnid release];
    
    
    FSHTTPPOSTItem *content = [[FSHTTPPOSTItem alloc] initWithName:@"message" withValue:self.content];
    [postItems addObject:content];
    [content release];
    
    
    NSString * client_ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    FSHTTPPOSTItem *nickname = [[FSHTTPPOSTItem alloc] initWithName:@"client_ver" withValue:client_ver];
    [postItems addObject:nickname];
    [nickname release];
    
    
//    请求方式：post
//    参数：
//act:跳转url对应PHP地址，不可修改 ,该参数需get方式，即在url里带此参数
//message: 评论内容 必须
//    deepid：深度id 必须
//    os_type：客户端类型   android iphone ipad wp
//os_ver: 操作系统版本 eg. ios5.1  android4.1
//client_ver: 客户端APP版本  eg. 人民新闻2.0
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
	self.currentElementName = elementName;
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"string:%@",string);
    
    NSString *strUnion = nil;
    if ([self.currentElementName isEqualToString:DEEPCOMMENT_POST_RESULT_ERROR]) {
        strUnion = stringCat(NULL, trimString(string));
        if (strUnion.length > 0) {
            self.result = strUnion;
        }
        
    }else {
		NSLog(@"Unknow elementName Value = %@", string);
	}
    NSLog(@"%@",self.result);
}

- (void)baseXMLParserComplete:(FSBaseDAO *)sender {
    _isSuccessful = NO;
	if ([self.result isEqualToString:@"0"]) {
		_isSuccessful = YES;
        
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_SuccessfulStatus];
    }
    else{
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
    }
}


- (void) dealloc {
	;
	[super dealloc];
}
@end



//
//  FS_GZF_NewsCommentPOSTXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-13.
//
//


/*
 <root>
 <errorCode>0</errorCode>
 <newsid>1</newsid>
 <commentCount>5</commentCount>
 </root>
 
 
 errorCode :
 -1  newsid 参数错误
 -2  content 参数错误
 -3  devicetype 参数错误
 -4  系统忙
 
 */

/*#import "FS_GZF_NewsCommentPOSTXMLDAO.h"








@implementation FS_GZF_NewsCommentPOSTXMLDAO


@synthesize newsid = _newsid;
@synthesize channelid = _channelid;
@synthesize content = _content;
@synthesize username = _username;
@synthesize result = _result;






//@synthesize newsid = _newsid;
//@synthesize channelid = _channelid;
//@synthesize content = _content;
//@synthesize username = _username;
//@synthesize result = _result;




//*****************************************************************





@end*/

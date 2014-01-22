//
//  FS_GZF_DeepTextWebView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-2-5.
//
//

#import "FS_GZF_DeepTextWebView.h"
#import "FSCommonFunction.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#define FSDEEP_CONTENT_TEXT_TAG @"<div id='text_%d'>%@</div>"

#define FSDEEP_CONTENT_IMAGE_DIV_TAG @"<div id='image_%d' class='photo_section'></div>"

#define FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG @"<a href='%@'><img src='%@' width='%.0f' height='%.0f' class='pictureBorder'/></a>"

#define FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE 12.0f

#define FSDEEP_HTTP_SCHEME_PREFIX @"http"
#define FSDEEP_IMAGE_SCHEME_PREFIX @"image"
#define FSDEE_DYNAMIC_IMAGE_JS @"document.getElementById('image_%d').innerHTML=\"%@\""


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



@implementation FS_GZF_DeepTextWebView

@synthesize  title = _title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)doSomethingAtInit{
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.backgroundColor   = COLOR_NEWSLIST_TITLE_WHITE;
    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    _picURLs = [[NSMutableDictionary alloc] init];
    
    [self addSubview:_webView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCommentList:) name:@"updateCommentList" object:nil];
}
-(void)updateCommentList:(NSNotification*)sender
{
    //return;
    NSString * commentStr = [self processCommentList:@""];
    [_webView performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:[NSString stringWithFormat:@"document.getElementById('comment').innerHTML=\"%@\"", commentStr] afterDelay:0.2];
}

-(void)doSomethingAtDealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_webView setDelegate:NULL];
    if ([_webView isLoading]){
        [_webView stopLoading];
    }
	
    [_webView release];
    [_picURLs release];
}
-(NSString *)returnFontSizeName:(NSInteger)n{
    NSNumber *m = [[GlobalConfig shareConfig] readFontSize];
    n = [m integerValue];
    switch (n) {
        case 0:
            return @"font_small";
            break;
            
        case 1:
            return @"font_normal";
            break;
            
        case 2:
            return @"font_large";
            break;
            
        case 3:
            return @"font_largeb";
            break;
        default:
            return @"font_normal";
            break;
    }
}

-(void)doSomethingAtLayoutSubviews{
    
    _contentObject = (FSDeepContentObject *)self.data;
    
    if (_contentObject == nil || self.title== nil) {
        return;
    }
    
    //_backGimage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    _webView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height-30);
    
    
//title start**************************
    
    CGFloat clientWidth = self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f;
    CGSize sizeTmp = CGSizeZero;
    
    UIImageView *deep_titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_TextTitle.png"]];
    deep_titleImage.frame = CGRectMake(0.0f, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
    [_webView.scrollView addSubview:deep_titleImage];
    
    UIImageView *deep_MtitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Deep_textTitleM.png"]];
    deep_MtitleImage.frame = CGRectMake(0.0f, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
    [_webView.scrollView addSubview:deep_MtitleImage];
    
    
    
    UILabel *labDeepTitle = [[UILabel alloc] init];
    labDeepTitle.backgroundColor = COLOR_CLEAR;
    labDeepTitle.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    labDeepTitle.text = self.title;
    labDeepTitle.font = [UIFont systemFontOfSize:20];
    sizeTmp = [labDeepTitle.text sizeWithFont:labDeepTitle.font
                            constrainedToSize:CGSizeMake(clientWidth, 8192)
                                lineBreakMode:labDeepTitle.lineBreakMode];
    
    
    labDeepTitle.frame = CGRectMake(6.0f, 4.0f, sizeTmp.width, deep_titleImage.image.size.height);
    [_webView.scrollView addSubview:labDeepTitle];
    
    
    
    
    
    if (sizeTmp.width>deep_titleImage.image.size.width-4) {
        deep_titleImage.frame = CGRectMake(sizeTmp.width-deep_titleImage.image.size.width+14, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
        deep_MtitleImage.frame = CGRectMake(0.0f, 4.0f, sizeTmp.width-deep_titleImage.image.size.width+14, deep_titleImage.image.size.height);
    }
    else{
        deep_titleImage.frame = CGRectMake(0, 4.0f, deep_titleImage.image.size.width, deep_titleImage.image.size.height);
        deep_MtitleImage.frame = CGRectZero;
    }
    
    
    [labDeepTitle release];
    [deep_titleImage release];
    [deep_MtitleImage release];
    
    
//title end**************************
    
    
    
    _ChildObjects = [[_contentObject.childContent allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FSDeepContent_ChildObject *childObj1 = (FSDeepContent_ChildObject *)obj1;
        FSDeepContent_ChildObject *childObj2 = (FSDeepContent_ChildObject *)obj2;
        NSInteger obj1Index = [childObj1.orderIndex intValue];
        NSInteger obj2Index = [childObj2.orderIndex intValue];
        if (obj1Index < obj2Index) {
            return NSOrderedAscending;
        } else if (obj1Index > obj2Index) {
            return  NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    

    NSError *error;
    NSStringEncoding enc;
    
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"deep_content_template" ofType:@"html"];//新闻显示模版
    NSString *htmlTemplate = [NSString stringWithContentsOfFile:templatePath usedEncoding:&enc error:NULL];
    if ([htmlTemplate length]>0) {
        
        //STEP 1.
        NSString *contentTitle = _contentObject.title;
        //{{title}}
        NSString *htmlString = [htmlTemplate stringByReplacingOccurrencesOfString:@"{{title}}" withString:toHTMLString(contentTitle)];
        //STEP 2.
        NSString *subTitle = _contentObject.subjectTile;
        //{{subtitle}}
        if (subTitle == nil) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{subtitle}}" withString:@""];
        } else {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{subtitle}}" withString:toHTMLString(subTitle)];
        }
        
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{fontClass}}" withString:[self returnFontSizeName:0]];
         //templateString = [self replayString:templateString oldString:@"{{fontClass}}" newString:[self returnFontSizeName:0]];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_contentObject.timestamp.doubleValue];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{ptime}}" withString:[[date description] substringToIndex:20]];
        
        //STEP 3.
        NSMutableString *bodyString = [[NSMutableString alloc] init];
        [_picURLs removeAllObjects];
        int tempIndex = 0;
        for (int i = 0; i < [_ChildObjects count]; i++) {
            FSDeepContent_ChildObject *childObj = (FSDeepContent_ChildObject *)[_ChildObjects objectAtIndex:i];
            if ([childObj.flag intValue] == _pictureFlag) {
                //图片
                //[_picURLs setObject:childObj.content forKey:childObj.orderIndex];
                [_picURLs setValue:childObj.content forKey:[NSString stringWithFormat:@"%d",tempIndex]];
                
                NSString *picDivTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_IMAGE_DIV_TAG, tempIndex];
                [bodyString appendString:picDivTag];
                tempIndex++;
                [picDivTag release];
            } else if ([childObj.flag intValue] == _textFlag) {
                //文字
                NSString *textDivTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_TEXT_TAG, [childObj.orderIndex intValue], toHTMLString(childObj.content)];
                
                [bodyString appendString:textDivTag];
                [textDivTag release];
            }
        }
        
        
        //{{body}}
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{body}}" withString:bodyString];
        
        //加载字符串
        NSString *commentListStr = @"";
        if ([self.getCommentListDao.objectList count]>0) {
            commentListStr = [self processCommentList:commentListStr];
            htmlString = [self replayString:htmlString oldString:@"{{commentList}}" newString:commentListStr];
        }
        else{
            htmlString = [self replayString:htmlString oldString:@"{{commentList}}" newString:CONTENTWEBVIEW_COMMENT_TITLE_NODESC];
        }

        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        [_webView loadHTMLString:htmlString baseURL:baseURL];
        
        //                dispatch_async(dispatch_get_main_queue(), ^{
        //                    //[self startDownloadPictures];
        //                    [self performSelector:@selector(startDownloadPictures) withObject:nil afterDelay:0.5];
        //                });
        
        [bodyString release];
    } else {
        //FSLog(@"HTML Template error:%@", error);
    }
    
}
-(NSString *)replayString:(NSString *)baseString oldString:(NSString *)oldString newString:(NSString *)newString{
    baseString = [baseString stringByReplacingOccurrencesOfString:oldString withString:newString];
    return baseString;
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
            templateString = [NSString stringWithFormat:@"%@%@",templateString,strCommentBlock];
            
        }
        templateString = [NSString stringWithFormat:@"%@%@",templateString,CONTENTWEBVIEW_COMMENT_MORE];
    }
    else{
        for (FSDeepCommentObject *o in array) {
            NSString *nickName = o.nickname;
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[o.timestamp doubleValue]];
            
            NSString *datetime = timeIntervalStringSinceNow(date);
            datetime =  [NSString stringWithFormat:@"%@ ",datetime];
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark -
#pragma  mark FSNetworkDataDelegate


-(void)downloadImages{
    
    if (!_allPICkey) {
        _allPICkey = [[_picURLs allKeys] retain];
    }
    
    if (_downloaodIndex >= [_allPICkey count]) {
        return;
    }
        
    //NSString *picKey = [_allPICkey objectAtIndex:_downloaodIndex];
    NSString *picURL = [_picURLs objectForKey:[NSString stringWithFormat:@"%d",_downloaodIndex]];
    
    NSString *loaclFile = getFileNameWithURLString(picURL, getCachesPath());
    if (![[NSFileManager defaultManager] fileExistsAtPath:loaclFile]) {
        [FSNetworkData networkDataWithURLString:picURL withLocalStoreFileName:loaclFile withDelegate:self];
        //NSLog(@"loaclFile:%@",loaclFile);
    }
    else{
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:loaclFile];
        CGSize sizeTmp = scalImageSizeFixWidth(image, self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f);
        NSString *imgTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG, picURL, loaclFile, sizeTmp.width, sizeTmp.height];
        NSString *jsString = [[NSString alloc] initWithFormat:FSDEE_DYNAMIC_IMAGE_JS, _downloaodIndex, imgTag];
        
        [_webView stringByEvaluatingJavaScriptFromString:jsString];
        [imgTag release];
        [jsString release];
        [image release];
        
        _downloaodIndex++;
        if (_downloaodIndex<[_allPICkey count]) {
            [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.0];//延迟下载下一张图片
        }
    }
    
}

-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    //_allPICkey = [_picURLs allKeys];
    //NSNumber *picKey = [_allPICkey objectAtIndex:_downloaodIndex];
    
    if (_downloaodIndex >= [_allPICkey count]) {
        return;
    }
    
    //NSString *picKey = [_allPICkey objectAtIndex:_downloaodIndex];
    NSString *picURL = [_picURLs objectForKey:[NSString stringWithFormat:@"%d",_downloaodIndex]];
    NSString *loaclFile = getFileNameWithURLString(picURL, getCachesPath());
    UIImage *image = [[UIImage alloc] initWithData:data];
    CGSize sizeTmp = scalImageSizeFixWidth(image, self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f);
    NSString *imgTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG, picURL, loaclFile, sizeTmp.width, sizeTmp.height];
    NSString *jsString = [[NSString alloc] initWithFormat:FSDEE_DYNAMIC_IMAGE_JS, _downloaodIndex, imgTag];
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
    [imgTag release];
    [jsString release];
    [image release];
    _downloaodIndex++;
    if (_downloaodIndex<[_allPICkey count]) {
        [self performSelector:@selector(downloadImages) withObject:nil afterDelay:0.2];//延迟下载下一张图片
    }
}

//*********************************************************************

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [_webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML=''"];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _downloaodIndex = 0;
    
    [self downloadImages];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString* urlString = [[request URL] absoluteString];
    if ([urlString hasPrefix:@"http://"]) {
        [self tapImage:urlString];
        return NO;
    }else if ([urlString isEqualToString:@"more://comment.list"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"deepMoreComment" object:self.getCommentListDao.deepid];
        return  NO;
    }
    
    return YES;
}
- (void)tapImage:(NSString*)senderUrl
{
//    FSNewsDitailPicObject *o = [_imageList objectAtIndex:_expendImageIndex];
//    UIImageView * view = [[UIImageView alloc]initWithFrame:self.frame];
//    [self addSubview:view];
//    int count = _imageList.count;
    // 1.封装图片数据
//    FSNewsDitailPicObject *o = [_imageList objectAtIndex:_expendImageIndex];
//    UIImageView * view = [[UIImageView alloc]initWithFrame:self.frame];
//    [self addSubview:view];
 //   int count = _picURLs.allKeys.count;
    // 1.封装图片数据
    //NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray * photos = [[NSMutableArray alloc] init];
    int current = 0;
    int index   = 0;
    for (id iid in _picURLs.allKeys) {
        //NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        //FSNewsDitailPicObject *o = [_imageList objectAtIndex:i];
        photo.url = [NSURL URLWithString:[_picURLs objectForKey:[NSString stringWithFormat:@"%d",index]]]; // 图片路径
        if ([photo.url.absoluteString isEqualToString:senderUrl]) {
            current = index;
        }
        index++;
        UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        [self addSubview:view];
        photo.srcImageView = view; // 来源于哪个UIImageView
        [view release];
        [photos addObject:photo];
        
    }
//    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++) {
//        // 替换为中等尺寸图片
//       
//    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = current; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [photos release];
    [browser show];
}




@end

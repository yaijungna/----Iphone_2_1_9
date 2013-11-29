//
//  FSShareIconContainView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-12-13.
//
//

#import "FSShareIconContainView.h"
#import "FSPeopleBlogShareViewController.h"
#import "FSNetEaseBlogShareViewController.h"
#import "FSSinaBlogShareViewController.h"
#define SHAREFONT 12.0f
@implementation WeiBoObject
-(id)initWithIndex:(int)index andPicName:(NSString*)picName andDisplayName:(NSString*)disPlayName;
{
    if (self = [super init]) {
        self.index   = index;
        self.picName = picName;
        self.disPlayName = disPlayName;
    }
    return self;
}
@end
@implementation FSShareIconContainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGes:)];
        [self addGestureRecognizer:tapGes];
        [tapGes release];
    }
    return self;
}




-(void)doSomethingAtDealloc{
    [_lab_title release];
    [_bt_return release];
}

-(void)doSomethingAtInit{
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title = [[UILabel alloc] init];
    _lab_title.backgroundColor = [UIColor redColor];
    _lab_title.textColor = COLOR_NEWSLIST_TITLE_WHITE;
    _lab_title.textAlignment = UITextAlignmentCenter;
    _lab_title.font = [UIFont systemFontOfSize:18.0f];
    _lab_title.tag = 99;
    [self addSubview:_lab_title];
    
    _bt_return = [[UIButton alloc] init];
    [_bt_return setBackgroundImage:[UIImage imageNamed:@"shareCancel.png"] forState:UIControlStateNormal];
    [_bt_return setTitle:NSLocalizedString(@"取消" ,nil) forState:UIControlStateNormal];
    [_bt_return setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_bt_return addTarget:self action:@selector(returnBTselect:) forControlEvents:UIControlEventTouchUpInside];
    _bt_return.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bt_return];
    
    
    self.shareSelectEvent = ShareSelectEvent_return;
    self.isShow = NO;
    
    self.backgroundColor = COLOR_BLACK_FOR_SHAREVIEW;
}

-(void)doSomethingAtLayoutSubviews{
    
    _lab_title.text = @"分享";
    _lab_title.frame = CGRectMake(30, 10, 60, 25);
    _bt_return.frame = CGRectMake(20, self.frame.size.height - 60, self.frame.size.width - 40, 40);
    [self layoutIcons];
    
}

-(void)returnBTselect:(id)sender{
    NSLog(@"取消取消取消");
    self.shareSelectEvent = ShareSelectEvent_return;
    [self sendTouchEvent];
}

-(void)layoutIcons{
//    NSArray * arry = [NSArray arrayWithObjects:@"人民微博",@"微信好友",@"微信朋友圈",@"新浪微博",@"网易微博",@"腾讯微博",@"信息",@"邮件",@"",@"", nil];
//    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"人民微博",@"1",@"微信好友",@"2",@"微信朋友圈",@"3",@"新浪微博",@"4",@"网易微博",@"5",@"腾讯微博",@"6",@"信息",@"7",@"邮件",nil];
    CGFloat iconHeight = 60;
    CGFloat iconWidth = iconHeight;
    CGFloat labHeight = 30;
    NSInteger lineNUM = 3;
    //NSInteger i = 0;
    CGFloat leftSpase = (320 - iconHeight * 4)/5;
    CGFloat spase = (self.frame.size.width-iconWidth*lineNUM)/lineNUM;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    
    WeiBoObject * xx1 = [[WeiBoObject alloc]initWithIndex:4 andPicName:@"renmin" andDisplayName:@"人民微博"];
    [dict setValue:xx1 forKey:xx1.disPlayName];
    [xx1 release];
    
    
    WeiBoObject * xx2 = [[WeiBoObject alloc]initWithIndex:0 andPicName:@"weixin" andDisplayName:@"微信好友"];
    [dict setValue:xx2 forKey:xx2.disPlayName];
    [xx2 release];
    
    
    
    WeiBoObject * xx3 = [[WeiBoObject alloc]initWithIndex:1 andPicName:@"朋友圈" andDisplayName:@"微信朋友圈"];
    [dict setValue:xx3 forKey:xx3.disPlayName];
    [xx3 release];
    
    
    WeiBoObject * xx4 = [[WeiBoObject alloc]initWithIndex:5 andPicName:@"weibo" andDisplayName:@"新浪微博"];
    [dict setValue:xx4 forKey:xx4.disPlayName];
    [xx4 release];
    
    
    WeiBoObject * xx5 = [[WeiBoObject alloc]initWithIndex:7 andPicName:@"163" andDisplayName:@"网易微博"];
    [dict setValue:xx5 forKey:xx5.disPlayName];
    [xx5 release];
    
    
    
    WeiBoObject * xx6 = [[WeiBoObject alloc]initWithIndex:2 andPicName:@"yixin-friend" andDisplayName:@"易信好友"];
    [dict setValue:xx6 forKey:xx6.disPlayName];
    [xx6 release];
    
    
    
    WeiBoObject * xx7 = [[WeiBoObject alloc]initWithIndex:3 andPicName:@"yixin-pengyq" andDisplayName:@"易信朋友圈"];
    [dict setValue:xx7 forKey:xx7.disPlayName];
    [xx7 release];
    
    
    
    WeiBoObject * xx8 = [[WeiBoObject alloc]initWithIndex:6 andPicName:@"腾讯微博" andDisplayName:@"腾讯微博"];
    [dict setValue:xx8 forKey:xx8.disPlayName];
    [xx8 release];
    
    
    for (NSString * string in [dict allKeys]) {
        WeiBoObject * obj = [dict valueForKey:string];
        UIImageView *friendImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithNameString:obj.picName]];
        friendImageView.tag = obj.index;
        friendImageView.userInteractionEnabled = YES;
        friendImageView.frame = CGRectMake(leftSpase*(obj.index %4+1)+iconWidth *(obj.index %4), spase + (iconHeight + 50)* (obj.index/4)  , iconWidth, iconHeight);
        UILabel *friendLabel = [[UILabel alloc] init];
        friendLabel.userInteractionEnabled = YES;
        friendLabel.tag = obj.index;
        friendLabel.text = obj.disPlayName;
        friendLabel.textAlignment = UITextAlignmentCenter;
        friendLabel.backgroundColor = COLOR_CLEAR;
        friendLabel.font = [UIFont systemFontOfSize:SHAREFONT];
        friendLabel.frame = CGRectMake(leftSpase*(obj.index %4+1)+iconWidth *(obj.index %4), spase + (iconHeight + 50)* (obj.index/4) + 5 + iconHeight, iconWidth, labHeight);
        [self addSubview:friendImageView];
        [self addSubview:friendLabel];
        [friendImageView release];
        [friendLabel release];
    }
    

    
    [dict release];
    self.backgroundColor = COLOR_NEWSLIST_TITLE_WHITE;
}

-(CGFloat)getHeight{
    CGFloat height = 60.0f;
    
    height = height +98*2;
    
    height = height +60;
    
    
    return height;
}

- (void)handleGes:(UITapGestureRecognizer *)ges {
    
    if (ges.state == UIGestureRecognizerStateEnded) {
        
        CGPoint pt = [ges locationInView:self];
        UIView *hitView = [self hitTest:pt withEvent:nil];
        NSLog(@"UIGestureRecognizerStateEnded:%@",hitView);
        if ([hitView isKindOfClass:[UIImageView class]]) {
            UIImageView *asycImageView = nil;
            asycImageView = (UIImageView *)hitView;
            self.shareSelectEvent = asycImageView.tag;
            [self sendTouchEvent];
        }
        
        if ([hitView isKindOfClass:[UIButton class]]) {
            self.shareSelectEvent = ShareSelectEvent_return;
            [self sendTouchEvent];
        }
        
        if ([hitView isKindOfClass:[UILabel class]]) {
            UILabel *asycImageView = nil;
            asycImageView = (UILabel *)hitView;
            self.shareSelectEvent = asycImageView.tag;
            [self sendTouchEvent];
        }
        
    }else{
        return;
    }
}



@end

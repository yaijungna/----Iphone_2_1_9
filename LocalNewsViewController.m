//
//  LocalNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-12-16.
//
//

#import "LocalNewsViewController.h"

@interface LocalNewsViewController ()

@end

@implementation LocalNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)showLoadingView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.textColor       = [UIColor redColor];
    _titleLabel.textAlignment   = UITextAlignmentCenter;
    _titleLabel.text            = @"本地新闻";
    //_titleLabel.font            = [UIFont systemFontOfSize:25];
    //_titleLabel.font            = [UIFont fontWithName:<#(NSString *)#> size:25];
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    float xx  = (ISIOS7?64:44);
    float tmp = (!ISIOS7?20:0);
    self.myNaviBar.frame = CGRectMake(0, tmp, 320, xx);
    self.myNaviBar.topItem.title = @"本地新闻";
    self.myNaviBar.topItem.titleView = nil;
    self.myNaviBar.topItem.titleView = _titleLabel;
    [_titleLabel release];
    
    //[self initMyListView];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self initMyListView];
}

-(void)initMyListView
{
    
    CGRect xx = self.view.frame;
    //float xxx = self.view.frame.size.height;
    if (ISIOS7) {
        xx.size.height -= 64;
    }else
    {
        xx.size.height -= 44;
    }
    //_myNewsListView = [[MyNewsLIstView alloc] initWithChanel:nil currentIndex:nil parentViewController:self];
    _myNewsListView = [[MyNewsLIstView alloc] initWithZoneId:2];
    _myNewsListView.parentDelegate = _myNewsListView;
    _myNewsListView.frame = CGRectMake(0, self.view.frame.size.height - xx.size.height, 320, xx.size.height);
    [self.view addSubview:_myNewsListView];
    _myNewsListView.backgroundColor = [UIColor redColor];
    
    //[_myNewsListView refreshDataSource];
    [_myNewsListView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

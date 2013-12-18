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
    self.myNaviBar.frame = CGRectMake(0, 20, 320, 44);
    self.myNaviBar.topItem.title = @"本地新闻";
    self.myNaviBar.topItem.titleView = nil;
    self.myNaviBar.topItem.titleView = _titleLabel;
    [_titleLabel release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

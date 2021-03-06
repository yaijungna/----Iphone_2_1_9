//
//  LocalNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-12-16.
//
//

#import "LocalNewsViewController.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"
#import "LocalProvinceNewsViewControllers.h"
#import "LygCustermerBar.h"
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
-(void)initTitleLabel
{
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.textColor       = [UIColor redColor];
    _titleLabel.textAlignment   = UITextAlignmentCenter;
    
    _titleLabel.font            = [UIFont systemFontOfSize:22];
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    float xx  = (ISIOS7?64:44);
    float tmp = (!ISIOS7?20:0);
    self.myNaviBar.frame = CGRectMake(0, tmp, 320, xx);
    //self.myNaviBar.topItem.titleView = nil;
    self.myNaviBar.topItem.titleView = _titleLabel;
    _titleLabel.text            = @"未知地区";
    [_titleLabel release];
}

-(void)touchEnd
{
    LocalProvinceNewsViewControllers * localCityListController = [[LocalProvinceNewsViewControllers alloc] init];
    localCityListController.canBeHaveNaviBar = YES;
    localCityListController.cityName = self.currentAreaObject.areaName;
    localCityListController.localCity = self.currentAreaObject.areaName;
    if (self.memGetProvincesDao.objectList > 0) {
        localCityListController.provincesListDao = self.memGetProvincesDao;
    }
    if (self.navigationController) {
        [self.navigationController pushViewController:localCityListController animated:YES];
    }else
    {
        [self presentViewController:localCityListController animated:YES completion:nil];
    }
    
    [localCityListController release];
}
-(void)initAreaLabel
{
    self.myNaviBar.topItem.rightBarButtonItem = nil;
    float xx;
    if (ISIOS7) {
        xx = 50;
    }else
    {
        xx = 57;
    }
    _rightBar = [[LygCustermerBar alloc] initWithFrame:CGRectMake(0, 0, xx, 49)];
    _rightBar.delegate          = self;
    UIBarButtonItem * itme = [[UIBarButtonItem alloc]initWithCustomView:_rightBar];
    self.myNaviBar.topItem.rightBarButtonItem  = itme;
    NSDictionary * dict2            = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],UITextAttributeTextColor,[NSValue valueWithCGSize:CGSizeMake(0, 0)],UITextAttributeTextShadowOffset,nil];
    [itme setTitleTextAttributes:dict2 forState:UIControlStateNormal];
    [_rightBar release];
    [itme release];
}

-(void)getAreaIdFromProvinceName:(NSString*)proVinceName
{
    NSArray * arry = [NSArray arrayWithArray:self.memGetProvincesDao.objectList];
    for (LygAreaObject * obj in arry) {
        NSLog(@"%@",obj.areaName);
        if ([obj.areaName hasPrefix:proVinceName]) {
            self.currentAreaObject = obj;
            NSLog(@"%@",self.currentAreaObject.areaId);
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.fpChangeTitleColor) {
        [self performSelector:@selector(xxxxxx) withObject:self afterDelay:0.15];
    }

}
-(void)xxxxxx
{
    if (self.fpChangeTitleColor)
    {
        self.fpChangeTitleColor();
        self.fpChangeTitleColor = nil;
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitleLabel];
    [self initMyListView];
    
    [self initAreaLabel];
    [self initMyDataModel];
    
    CGRect rect = self.myNaviBar.frame;
    rect.origin.y = 0;
    self.myNaviBar.frame = rect;
}


-(void)initMyDataModel
{
    self.memGetProvincesDao                   = [[[LygListOfProvincesHaveAreaNewsDao alloc] init] autorelease];
    self.memGetProvincesDao.parentDelegate    = self;
    self.memGetProvincesDao.isGettingList     = YES;
    [self.memGetProvincesDao HTTPGetDataWithKind:GET_DataKind_Refresh];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haveChangedArea:) name:LOCALPROVINCESELECTED object:nil];
 
}

-(void)haveChangedArea:(NSNotification*)sender
{
    LygAreaObject * obj                             = sender.object;
    _rightBar.title                                 = obj.areaName;
    self.myNewsListView.placeId = [[obj valueForKey:@"iphone_id"] intValue];
    self.myNewsListView.areaID                      = obj.areaId.intValue;
    _titleLabel.text                                = [NSString stringWithFormat:@"%@新闻",obj.areaName];
    [PeopleNewsStati localNewsStatic:obj.areaName];
}
-(void)dosomeThing
{
    self.myNewsListView.areaID  =  0;
    
    NSString * tempString       = @"未知地区";
    _rightBar.title             = tempString;
    //self.myNaviBar.topItem.rightBarButtonItem.title = tempString;
}
-(void)afterGetLocation
{
    //self.placeID                = [[self.currentAreaObject valueForKey:@"iphone_id"] intValue];
    self.myNewsListView.placeId = [[self.currentAreaObject valueForKey:@"iphone_id"] intValue];
    self.myNewsListView.areaID  = self.currentAreaObject.areaId.intValue;
    
    
    NSString * tempString       = [NSString stringWithFormat:@"%@",self.currentAreaObject.areaName];
    //self.myNaviBar.topItem.rightBarButtonItem.title = tempString;
    _rightBar.title             = tempString;
    _titleLabel.text                                = [NSString stringWithFormat:@"%@新闻",tempString];
        [PeopleNewsStati localNewsStatic:tempString];
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status
{
    if ([sender isEqual:self.memGetProvincesDao]) {
        if (self.memGetProvincesDao.objectList.count == 0) {
            return;
        }
        if (self.currentAreaObject == nil) {
            NSString * provinceName = getProvinceName();
            [self getAreaIdFromProvinceName:provinceName];
            if (provinceName.length == 0) {
                [self dosomeThing];
            }else
            {
                [self afterGetLocation];
            }
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    CGRect xx = self.view.frame;
    if (ISIOS7) {
        xx.size.height -= 64;
    }else
    {
        xx.size.height -= 44;
    }
    _myNewsListView.frame = CGRectMake(0, self.view.frame.size.height - xx.size.height, 320, xx.size.height);
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
    _myNewsListView = [[MyNewsLIstView alloc] initWithZoneId:-1 parentViewController:self.navigationController];
    _myNewsListView.parentDelegate = _myNewsListView;
    
    
    //[_myNewsListView addObserver:self forKeyPath:@"areaID" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial  context:nil];
    
    _myNewsListView.frame = CGRectMake(0, self.view.frame.size.height - xx.size.height, 320, xx.size.height);
    [self.view addSubview:_myNewsListView];
    _myNewsListView.backgroundColor = [UIColor redColor];
    
    
    
   
    //[_myNewsListView refreshDataSource];
    [_myNewsListView release];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_myNewsListView.areaID != -1) {
        [_myNewsListView refreshDataSource];
    }
}

//NSKeyValueObservingOptionNew = 0x01,
//NSKeyValueObservingOptionOld = 0x02,
//
///* Whether a notification should be sent to the observer immediately, before the observer registration method even returns. The change dictionary in the notification will always contain an NSKeyValueChangeNewKey entry if NSKeyValueObservingOptionNew is also specified but will never contain an NSKeyValueChangeOldKey entry. (In an initial notification the current value of the observed property may be old, but it's new to the observer.) You can use this option instead of explicitly invoking, at the same time, code that is also invoked by the observer's -observeValueForKeyPath:ofObject:change:context: method. When this option is used with -addObserver:toObjectsAtIndexes:forKeyPath:options:context: a notification will be sent for each indexed object to which the observer is being added.
// */
//NSKeyValueObservingOptionInitial NS_ENUM_AVAILABLE(10_5, 2_0) = 0x04,

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

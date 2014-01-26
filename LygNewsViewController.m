//
//  LygNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ark on 14-1-1.
//
//

#import "LygNewsViewController.h"
#import "UIViewController+changeContent.h"
#import "PeopleNewsReaderPhoneAppDelegate.h"
@interface LygNewsViewController ()

@end

@implementation LygNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithChannelIndex:(int)index andChannel:(FS_GZF_ChannelListDAO*)listDao andNaviGationController:(UINavigationController*)aNavi
{
    if (self = [super init]) {
        self.changeList = listDao;
        self.channelIndex= index;
        _memNewsLIstView = [[MyNewsLIstView alloc] initWithChanel:listDao currentIndex:index parentViewController:aNavi];
        _memNewsLIstView.parentDelegate = _memNewsLIstView;
        
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
}
-(void)changMainViewSize
{
//    if (!ISIOS7) {
//        if (ISIPHONE5) {
//            self.view.frame = CGRectMake(0, 20, 320, 548);
//        }else
//        {
//            self.view.frame = CGRectMake(0, 20, 320, 460);
//        }
//    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self chageSize1];
    [self.view addSubview:_memNewsLIstView];
   
    [_memNewsLIstView refreshDataSource];
    
    [_memNewsLIstView release];
    [self chageSize1];
	// Do any additional setup after loading the view.
}

-(void)chageSize1
{
    float offset = 0;
    float height = self.view.frame.size.height;
    float xxxx = 0;
    if (ISIPHONE5) {
        xxxx = 548 - 44 - HeightOfChannel;
        offset = height - 548;
    }else
    {
        xxxx = 460 - 44 - HeightOfChannel;
        offset = height - 460;
    }
    float xxx = 0;
    PeopleNewsReaderPhoneAppDelegate * appdelgate = (PeopleNewsReaderPhoneAppDelegate*)[UIApplication sharedApplication].delegate;
    //appdelgate.globaXXXXX                         = 1;
    if (appdelgate.globaXXXXX == 0) {
        xxx = 40;
    }

    if (!ISIOS7) {
        self.memNewsLIstView.frame = CGRectMake(0, 44 + HeightOfChannel - offset - xxx, 320, xxxx - 49);
    }else
    {
        self.memNewsLIstView.frame = CGRectMake(0, 64 + HeightOfChannel, 320, xxxx - 49);
    }
    
}
-(void)chageSize2
{
     NSLog(@"%@",self.view.superclass);
    float offset = 0;
    float height = self.view.frame.size.height;
    float xxxx = 0;
    if (ISIPHONE5) {
        xxxx = 548 - 44 - HeightOfChannel;
        offset = height - 548;
    }else
    {
        xxxx = 460 - 44 - HeightOfChannel;
        offset = height - 460;
    }
    float xxx = 0;
    PeopleNewsReaderPhoneAppDelegate * appdelgate = (PeopleNewsReaderPhoneAppDelegate*)[UIApplication sharedApplication].delegate;
    //appdelgate.globaXXXXX                         = 1;
    if (appdelgate.globaXXXXX == 0) {
        xxx = 20;
    }
    static int temp = 0;
    if (temp == 0) {
        offset = 0;
    }else
    {
        offset = 20;
    }
    if (!ISIOS7) {
        self.memNewsLIstView.frame = CGRectMake(0, 44 + HeightOfChannel - offset - xxx, 320, xxxx - 49);
    }else
    {
        self.memNewsLIstView.frame = CGRectMake(0, 64 + HeightOfChannel, 320, xxxx - 49);
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    [self changMainViewSize];
    [self chageSize1];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:animated];
    [self changMainViewSize];
    [self chageSize2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeContent:(int)index
{
    self.channelIndex = index;
    _memNewsLIstView.currentIndex = index;
    [_memNewsLIstView refreshDataSource];
}

@end

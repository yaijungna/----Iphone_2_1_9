//
//  LygNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ark on 14-1-1.
//
//

#import "LygNewsViewController.h"
#import "UIViewController+changeContent.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    float xxx = (ISIOS7?64 + HeightOfChannel:44+ HeightOfChannel);
    
    
    float bbb = xxx;
    if (!ISIOS7) {
        bbb += 20;
    }
    [self.view addSubview:_memNewsLIstView];
    float xxxxx = 0;
    if (!ISIOS7) {
        //xxxxx = 20;
    }
    self.memNewsLIstView.frame = CGRectMake(0, xxx - xxxxx, 320, self.view.frame.size.height - bbb - 49);

    [_memNewsLIstView refreshDataSource];
    [_memNewsLIstView release];
	// Do any additional setup after loading the view.
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

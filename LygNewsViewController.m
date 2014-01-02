//
//  LygNewsViewController.m
//  PeopleNewsReaderPhone
//
//  Created by ark on 14-1-1.
//
//

#import "LygNewsViewController.h"

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

-(id)initWithChannelIndex:(int)index andChannel:(FS_GZF_ChannelListDAO*)listDao
{
    if (self = [super init]) {
        self.changeList = listDao;
        self.channelIndex= index;
        _memNewsLIstView = [[MyNewsLIstView alloc] initWithChanel:listDao currentIndex:index parentViewController:nil];
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
    float xxx = (ISIOS7?64 + 30:44+ 30);
    self.memNewsLIstView.frame = CGRectMake(0, xxx, 320, self.view.frame.size.height - xxx - 49);
    [self.view addSubview:_memNewsLIstView];
    
    [_memNewsLIstView refreshDataSource];
    [_memNewsLIstView release];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

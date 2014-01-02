    //
//  FSMyFavoritesViewController.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-8-20.
//  Copyright 2012 people.com.cn. All rights reserved.
//

#import "FSMyFavoritesViewController.h"
#import "FSBaseDB.h"
#import "FSMyFaverateObject.h"
#import "FSOneDayNewsObject.h"
#import "FSNewsContainerViewController.h"
#import "FSDeepPageContainerController.h"

@implementation FSMyFavoritesViewController

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

-(NSString *)setTitle{
    return @"我的收藏";
}

- (void)loadChildView {
    [super loadChildView];
    self.title = NSLocalizedString(@"我的收藏", nil);
//    UIButton *returnBT = [[UIButton alloc] init];
//    [returnBT setBackgroundImage:[UIImage imageNamed:@"returnbackBT.png"] forState:UIControlStateNormal];
//    //[returnBT setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
//    returnBT.titleLabel.font = [UIFont systemFontOfSize:12];
//    [returnBT addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
//    [returnBT setTitleColor:COLOR_NEWSLIST_TITLE_WHITE forState:UIControlStateNormal];
//    returnBT.frame = CGRectMake(0, 0, 55, 30);
//    
//	UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:returnBT];
//	self.navigationItem.leftBarButtonItem =leftBackItem;
//	[leftBackItem release];
//    [returnBT release];
	
	_fsMyFaverateContainView = [[FSMyFaverateContainView alloc] init];
    _fsMyFaverateContainView.parentDelegate = self;
    [self.view addSubview:_fsMyFaverateContainView];
    self.view.backgroundColor = COLOR_NEWSLIST_DESCRIPTION;
}

- (void)backItemAction:(id)sender {
	[self.navigationController dismissModalViewControllerAnimated:YES];
}


-(void)initDataModel{
     
}


-(void)layoutControllerViewWithRect:(CGRect)rect{
    float xxx = (ISIOS7?20:0);
    float offSet = xxx + 44;
    _fsMyFaverateContainView.frame = CGRectMake(0, offSet, 320, self.view.frame.size.height - offSet);
    
     
}


-(void)doSomethingForViewFirstTimeShow{
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_fsMyFaverateContainView loadData];
}

//*****************************************


#pragma mark -
#pragma FSTableContainerViewDelegate mark


-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return 1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    _array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSMyFaverateObject" key:@"UPDATE_DATE" ascending:NO];
    NSLog(@"[_array count]:%d",[_array count]);
    return [_array count];
}


-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = [indexPath row];
    _array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSMyFaverateObject" key:@"UPDATE_DATE" ascending:NO];
    if ([_array count]>row){
        FSMyFaverateObject *o = [_array objectAtIndex:row];
        
        return o;
    }
    
    return nil;
    
}



-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    _array = [[FSBaseDB sharedFSBaseDB] getAllObjectsSortByKey:@"FSMyFaverateObject" key:@"UPDATE_DATE" ascending:NO];
    if ([_array count]>row) {
        FSMyFaverateObject *o = (FSMyFaverateObject*)[_array objectAtIndex:row];
        
        
        if (o.isDeep== nil) {
            FSNewsContainerViewController *fsNewsContainerViewController = [[FSNewsContainerViewController alloc] init];
            fsNewsContainerViewController.FavObj = o;
            fsNewsContainerViewController.FCObj = nil;
            fsNewsContainerViewController.obj = nil;
            if ([o.group isEqualToString:SHIKE_NEWS_LIST_KIND]) {
                fsNewsContainerViewController.newsSourceKind = NewsSourceKind_ShiKeNews;
            }
            else if ([o.group isEqualToString:PUTONG_NEWS_LIST_KIND]) {
                fsNewsContainerViewController.newsSourceKind = NewsSourceKind_PuTongNews;
            }
            else{
                fsNewsContainerViewController.newsSourceKind = NewsSourceKind_PuTongNews;
            }
            
            
            [self.navigationController pushViewController:fsNewsContainerViewController animated:YES];
            //[self.fsSlideViewController pres:fsNewsContainerViewController animated:YES];
            [fsNewsContainerViewController release];

        }else
        {
            //FSTopicObject *topicObj                          = [_fs_GZF_DeepListDAO.objectList objectAtIndex:index];
            FSDeepPageContainerController *pageContainerCtrl = [[FSDeepPageContainerController alloc] init];
            //pageContainerCtrl.deepid                         = topicObj.deepid;
            pageContainerCtrl.deepid                         = o.deepId;
            pageContainerCtrl.Deep_title                     = o.deepTitle;
            pageContainerCtrl.newsAbstract                   = o.deepNews_abstract;
            //pageContainerCtrl.oneTopic                       = topicObj;
            [PeopleNewsStati deepStatideepID:pageContainerCtrl.deepid deepTitle:pageContainerCtrl.Deep_title];
            [self.navigationController pushViewController:pageContainerCtrl animated:YES];
            [pageContainerCtrl release];
        }
        
        
    }
}


-(void)tableViewTouchPicture:(FSTableContainerView *)sender index:(NSInteger)index{
    NSLog(@"channel did selected!%d",index);
}


-(void)tableViewDataSource:(FSTableContainerView *)sender withTableDataSource:(TableDataSource)dataSource{
    
}


@end

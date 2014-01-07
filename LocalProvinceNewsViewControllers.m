//
//  LocalProvinceNewsViewControllers.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 14-1-6.
//
//

#import "LocalProvinceNewsViewControllers.h"
#import "LygAreaObject.h"
#import "NSString+Additions.h"
#import "LygAreaObject.h"
@interface LocalProvinceNewsViewControllers ()

@end

@implementation LocalProvinceNewsViewControllers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


-(void)dealloc{
    [super dealloc];
}




-(void)initDataModel{
    
    
//    _fsCityListData = [[FS_GZF_CityListDAO alloc] init];
//    _fsCityListData.parentDelegate = self;
    
    
    _sectionArrary = [[NSMutableArray alloc] init];
    _sectionNumberArrary = [[NSMutableArray alloc] init];
}


-(void)layoutControllerViewWithRect:(CGRect)rect{
    _localNewsCityListView.frame = CGRectMake(0, NAVIBARHEIGHT, rect.size.width, rect.size.height-NAVIBARHEIGHT);
//    [_fsCityListData HTTPGetDataWithKind:GET_DataKind_Unlimited];
    
    
    [self getSectionsTitle];
    //NSLog(@"12112");
    _localNewsCityListView.sectionTitleArry = _sectionArrary;
    [_localNewsCityListView loadData];
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //    NSInteger k = [self retainCount];
    //    for (NSInteger i=0; i<k-1; i++) {
    //        [self release];
    //    }
    NSLog(@"%@.viewDidDisappear:%d",self,[self retainCount]);
}




#pragma mark -
#pragma FSTableContainerViewDelegate mark


-(NSInteger)tableViewSectionNumber:(FSTableContainerView *)sender{
    return [_sectionArrary count]+1;
}

-(NSInteger)tableViewNumberInSection:(FSTableContainerView *)sender section:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (section-1<[_sectionNumberArrary count]) {
        NSInteger numb = [[_sectionNumberArrary objectAtIndex:section-1] integerValue];
        return numb;
    }
    return 0;
    
}

-(NSString *)tableViewSectionTitle:(FSTableContainerView *)sender section:(NSInteger)section{
    if (section == 0) {
        return  @"您当前的位置可能是";
    }
    if (section<[_sectionArrary count]) {
        NSString *kind = [_sectionArrary objectAtIndex:section];
        return kind;
    }
    return @"";
}

-(NSObject *)tableViewCellData:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    
    if (section ==0) {
        if ([self.localCity length]==0) {
            return [NSString stringWithFormat:@"未知位置"];
        }
        return self.localCity;
    }
    
    NSInteger index = 0;
    
    for (int i=0; i<section-1; i++) {
        index = index+[[_sectionNumberArrary objectAtIndex:i] integerValue];
    }
    index = index + row;
    
    LygAreaObject * obj = [self.provincesListDao.objectList objectAtIndex:index];
    return obj.areaName;
}


-(void)tableViewDataSourceDidSelected:(FSTableContainerView *)sender withIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if (section ==0) {
        
        [self returnBack:nil];
        return;
    }
    
    NSInteger index = 0;
    
    for (int i=0; i<section-1; i++) {
        index = index+[[_sectionNumberArrary objectAtIndex:i] integerValue];
    }
    index = index + row;
    LygAreaObject   *o = [self.provincesListDao.objectList objectAtIndex:index];
    
   
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCALPROVINCESELECTED object:o userInfo:nil];
    //[self dismissModalViewControllerAnimated:YES];
    [self returnBack:nil];
}



-(void)tableViewTouchPicture:(FSTableContainerView *)sender withImageURLString:(NSString *)imageURLString withImageLocalPath:(NSString *)imageLocalPath imageID:(NSString *)imageID{
    NSLog(@"channel did selected!!");
    
}

-(void)doSomethingWithDAO:(FSBaseDAO *)sender withStatus:(FSBaseDAOCallBackStatus)status{
    if ([sender isEqual:_fsCityListData]) {
        if (status == FSBaseDAOCallBack_SuccessfulStatus || status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
            //NSLog(@"_fsCityListData count:%d",[_fsCityListData.objectList count]);
            
            [self getSectionsTitle];
            //NSLog(@"12112");
            [_localNewsCityListView loadData];
            if (status == FSBaseDAOCallBack_BufferSuccessfulStatus) {
                [_fsCityListData operateOldBufferData];
            }
        }
    }
}



//
//-(FSUserSelectObject *)insertCityselectedObject:(FSCityObject *)obj{
//    
//    NSArray *array = [[FSBaseDB sharedFSBaseDB] getObjectsByKeyWithName:@"FSUserSelectObject" key:@"kind" value:KIND_CITY_SELECTED];
//    
//    if ([array count]>0) {
//        FSUserSelectObject *sobj = [array objectAtIndex:0];
//        
//        if (obj == nil) {
//            return sobj;
//        }
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
//        NSString *nsstringdate = dateToString_YMD(date);
//        sobj.keyValue1 = obj.cityName;
//        sobj.keyValue2 = obj.cityId;
//        sobj.keyValue3 = obj.provinceId;
//        sobj.keyValue4 = nsstringdate;
//        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
//        return sobj;
//    }
//    else{
//        if (obj == nil) {
//            return nil;
//        }
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
//        NSString *nsstringdate = dateToString_YMD(date);
//        FSUserSelectObject *sobj = (FSUserSelectObject *)[[FSBaseDB sharedFSBaseDB] insertObject:@"FSUserSelectObject"];
//        sobj.kind = KIND_CITY_SELECTED;
//        sobj.keyValue1 = obj.cityName;
//        sobj.keyValue2 = obj.cityId;
//        sobj.keyValue3 = obj.provinceId;
//        sobj.keyValue4 = nsstringdate;
//        [[FSBaseDB sharedFSBaseDB].managedObjectContext save:nil];
//        return sobj;
//    }
//    
//}



-(void)getSectionsTitle{
    [_sectionArrary removeAllObjects];
    [_sectionArrary addObject:@"#"];
    NSString *kind = @"";
    NSInteger number = 0;
    for (LygAreaObject *o in  _provincesListDao.objectList) {
        //NSString *temp = [o.areaName substringToIndex:1];
        char c   =  pinyinFirstLetter([o.areaName characterAtIndex:0]);
        if (islower(c)) {
            c =  toupper(c);
        }
        NSString * temp  = [NSString stringWithFormat:@"%c",c];
        if (![kind isEqualToString:temp]) {
            [_sectionArrary addObject:temp];
            kind = temp;
            if (number!=0) {
                [_sectionNumberArrary addObject:[NSNumber numberWithInteger:number]];
                number = 0;
            }
        }
        number++;
    }
    [_sectionNumberArrary addObject:[NSNumber numberWithInteger:number]];
    [_localNewsCityListView setRightList:_sectionArrary];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[_localNewsCityListView loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end

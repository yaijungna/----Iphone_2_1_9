//
//  LygListOfProvincesHaveAreaNewsDao.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-12-30.
//
//
#define URLOFGETAREAS  @"http://mobile.app.people.com.cn:81/news2/news.php?act=dfchannellist"
#import "LygListOfProvincesHaveAreaNewsDao.h"

#define area_item   @"item"
#define area_id     @"id"
#define area_name   @"name"

//#define city_kind @"kind"
//#define city_cityId @"cityId"
//#define city_cityName @"cityName"
//#define city_provinceId @"provinceId"
//#define city_provinceName @"provinceName"



@implementation LygListOfProvincesHaveAreaNewsDao
- (id)init {
	self = [super init];
	if (self) {
        
	}
	return self;
}

-(void)dealloc{
    [super dealloc];
}

-(NSTimeInterval)bufferDataExpireTimeInterval{
    return 60*60*24*2;
}

-(NSString *)entityName{
    return @"LygAreaObject";
}


-(NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind{
    NSLog(@"FSCITYLIST_URL:%@",FSCITYLIST_URL);
    return URLOFGETAREAS;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return @"bufferFlag!='3'";
    
}



- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"id" withAscending:YES];
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:area_item]) {
        _obj = (LygAreaObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.bufferFlag = 1;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:area_item]) {
        
        //[_objectList addObject:_obj];
        //[_obj release];
        //_obj = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
    
    /*
     NSString *strUnion = nil;
     if ([self.currentElementName isEqualToString:NEWS_COMMENT_CREATE_TIME]) {
     strUnion = [CommonFuncs strCat:_obj.create_time TwoStr:[CommonFuncs trimString:string]];
     _obj.create_time = strUnion;
     }else if([self.currentElementName isEqualToString:NEWS_COMMENT_CREATE_TIMEINSECONDS]){
     strUnion = [CommonFuncs strCat:_obj.time_inSeconds TwoStr:[CommonFuncs trimString:string]];
     _obj.time_inSeconds = strUnion;
     }
     [strUnion release];
     */
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	
    if ([_currentElementName isEqualToString:area_id]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		NSString *temp = trimString(content);
        _obj.areaId  = [temp intValue];
		[content release];
	} else if ([_currentElementName isEqualToString:area_name]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.areaName = trimString(content);
		[content release];
	}
//    else if ([_currentElementName isEqualToString:city_cityName]) {
//		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
//		_obj.cityName = trimString(content);
//		[content release];
//        //NSLog(@"city_cityName:%@",_obj.cityName);
//	}
//    else if ([_currentElementName isEqualToString:city_provinceId]) {
//		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
//		_obj.provinceId = trimString(content);
//		[content release];
//	}
//    else if ([_currentElementName isEqualToString:city_provinceName]) {
//		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
//		_obj.provinceName = trimString(content);
//		[content release];
//	}
}



- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            self.objectList = (NSMutableArray *)resultSet;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
        }
	}
}

-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:area_id ascending:YES];
    
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (LygAreaObject *o in array) {
            if ([o.bufferFlag isEqualToNumber:1]) {
                o.bufferFlag = 2;
            }
        }
        [self saveCoreDataContext];
        return;
    }
    
    for (LygAreaObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToNumber:2]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToNumber:1]){
            o.bufferFlag = 2;
        }
    }
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:area_id ascending:YES];
    
    for (LygAreaObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToNumber:2]) {
            o.bufferFlag = 3;
        }
    }
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:area_id ascending:YES];
            for (LygAreaObject *o in array) {
                if ([o.bufferFlag isEqualToNumber:3]) {
                    [self.managedObjectContext deleteObject:o];
                }
            }
            [self saveCoreDataContext];
            
        }
	}
}

@end

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
    //NSLog(@"FSCITYLIST_URL:%@",FSCITYLIST_URL);
    return URLOFGETAREAS;
}



-(NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind{
    
    return @"bufferFlag!=3";
    
}



- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"areaId" withAscending:YES];
}

#pragma mark -
#pragma mark NSCMLParserDelegate


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElementName = elementName;
	if ([_currentElementName isEqualToString:area_item]) {
        _obj = (LygAreaObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.bufferFlag = [NSNumber numberWithInt:1];
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
    if ([string hasPrefix:@"\n"] || [string hasPrefix:@" "]) {
        return;
    }
    if ([_currentElementName isEqualToString:area_id]) {
		//NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		NSString *temp = trimString(string);
        _obj.areaId  = [NSNumber numberWithInt:temp.intValue];
		//[content release];
	} else if ([_currentElementName isEqualToString:area_name]) {
		//NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
		_obj.areaName = trimString(string);
		//[content release];
	}

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

}



- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
    NSArray *resultSet = nil;
    request.fetchLimit =  32;
    @try {
        resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"%@  %@",exception.name,exception.reason);
    }
    @finally {
    }
	
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
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"areaId" ascending:YES];
    
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (LygAreaObject *o in array) {
            if (o.bufferFlag.intValue == 1) {
                o.bufferFlag = [NSNumber numberWithInt:2];
            }
        }
        [self saveCoreDataContext];
        return;
    }
    
    for (LygAreaObject *o in array) {
        @try {
            if (_isRefreshToDeleteOldData == YES && o.bufferFlag.intValue == 2) {
                ;//o.bufferFlag = @"3";
            }else if (_isRefreshToDeleteOldData == YES && o.bufferFlag.intValue == 1){
                o.bufferFlag = [NSNumber numberWithInt:2];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@ %@",exception.name,exception.reason);
        }
        @finally {
            ;
        }
        
    }
}


-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"areaId" ascending:YES];
    
    for (LygAreaObject *o in array) {
        NSLog(@"%@",o.bufferFlag);
        if (_isRefreshToDeleteOldData == YES && o.bufferFlag.intValue == 2) {
            o.bufferFlag = [NSNumber numberWithInt:3];
        }
    }
}


-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getAllObjectsSortByKey:[self entityName] key:@"areaId" ascending:YES];
            for (LygAreaObject *o in array) {
                if (o.bufferFlag.intValue == 3) {
                    [self.managedObjectContext deleteObject:o];
                }
            }
            [self saveCoreDataContext];
            
        }
	}
}

@end

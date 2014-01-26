  //
//  LygDeepCommentListDao.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-28.
//
//

#import "LygDeepCommentListDao.h"
#define DEEPCOMMENT_LIST_URLX @"http://mobile.app.people.com.cn:81/news2/news.php?act=getcomment&rt=xml&newsid=%@&count=%@&//commentid=%@"
#define DEEPCOMMENT_LIST_URL   @"http://mobile.app.people.com.cn:81/topic/topic.php?act=comment_list&rt=xml&type=list&deepid=%@&count=%@&lastid=%@"


#define comment_commentsCount @"commentsCount"
#define comment_item @"ITEM"
#define comment_commentid @"commentid"
#define comment_deviceType @"deviceType"
#define comment_content @"content"
#define comment_nickname @"nickname"
#define comment_timestamp @"timestamp"

#define comment_adminContent @"adminContent"
#define comment_adminNickname @"adminNickname"
#define comment_adminTimestamp @"adminTimestamp"

@implementation LygDeepCommentListDao

- (id)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}
- (NSString *)readDataURLStringFromRemoteHostWithGETDataKind:(GET_DataKind)getDataKind {
    //self.newsid = @"1673597";
    NSString * string = [NSString stringWithFormat:DEEPCOMMENT_LIST_URL,self.deepid,self.count,@""];
    string.copy;
    if (getDataKind == GET_DataKind_Refresh) {
        return [NSString stringWithFormat:DEEPCOMMENT_LIST_URL,self.deepid,self.count,@""];
    }
    else{
        return [NSString stringWithFormat:DEEPCOMMENT_LIST_URL,self.deepid,self.count,self.lastCommentid];
    }
}

- (NSTimeInterval)bufferDataExpireTimeInterval {
	return 40;
}
- (NSString *)predicateStringWithQueryDataKind:(Query_DataKind)dataKind {
    
    return [NSString stringWithFormat:@"deepid='%@' AND bufferFlag!='3'", self.deepid];
	
}
- (NSString *)entityName {
	return @"FSDeepCommentObject";
}
- (NSString *)timestampFlag {
    return [NSString stringWithFormat:@"comment_list_%@", self.deepid];
}
- (void)initializeSortDescriptions:(NSMutableArray *)descriptions {
	[self addSortDescription:descriptions withSortFieldName:@"commentid" withAscending:NO];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    self.currentElementName = elementName;
	if ([_currentElementName isEqualToString:comment_item]) {
        _obj = (FSDeepCommentObject *)[self insertNewObjectTomanagedObjectContext];
        _obj.deepid = self.deepid;
        _obj.bufferFlag = @"1";
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	if ([elementName isEqualToString:comment_item]) {
        
        //[_objectList addObject:_obj];
        //[_obj release];
        //_obj = nil;
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"foundCharacters:%@",string);
    
    
    NSString *strUnion = nil;
    if ([self.currentElementName isEqualToString:comment_commentsCount]) {
        strUnion = stringCat(self.count, trimString(string));
        self.count = strUnion;
    }else if([self.currentElementName isEqualToString:@"COMMENTID"]){
        if(![string hasPrefix:@"\n"])
        {
            strUnion = trimString(string);
            _obj.commentid = [NSNumber numberWithDouble:strUnion.doubleValue];
        }
        if (_obj.commentid.intValue == 0) {
            [self.managedObjectContext deleteObject:_obj];
        }
    }
    else if ([_currentElementName isEqualToString:@"DATE"]) {
		strUnion = stringCat(_obj.date, trimString(string));
        _obj.date = strUnion;
    } else if ([_currentElementName isEqualToString:@"TIMESTAMP"]) {
		strUnion = stringCat(_obj.timestamp, trimString(string));
        _obj.timestamp = strUnion;
    } else if ([_currentElementName isEqualToString:@"DEVICETYPE"]) {
		strUnion = stringCat(_obj.devicetype, trimString(string));
        _obj.devicetype = strUnion;
    } else if ([_currentElementName isEqualToString:@"USERIP"]) {
        strUnion = stringCat(_obj.userip, trimString(string));
        _obj.userip = strUnion;

    } else if ([_currentElementName isEqualToString:@"FLAG"]) {
        strUnion = stringCat(_obj.flag, trimString(string));
        _obj.flag = strUnion;
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    if ([_currentElementName isEqualToString:@"CONTENT"]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.content = content;
		[content release];
    } else if ([_currentElementName isEqualToString:@"AUTHOR"]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.author = trimString(content);
        
        [content release];
	} else if ([_currentElementName isEqualToString:@"NICKNAME"]) {
		NSString *content = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        _obj.nickname = trimString(content);
            [content release];
        //}
		
	}

}

- (void)executeFetchRequest:(NSFetchRequest *)request {
	NSError *error = nil;
	NSArray *resultSet = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSMutableArray * tempArry = [[NSMutableArray alloc]init];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    for (FSDeepCommentObject * obj in resultSet) {
        if (![dict valueForKey:obj.commentid.description]) {
            [tempArry addObject:obj];
            [dict setValue:@"1" forKey:obj.commentid.description];
        }
    }
	if (!error) {
        
		if ([resultSet count]>0) {
            //NSLog(@"[resultSet count]:%d",[resultSet count]);
            self.objectList = tempArry;
            self.isRecordListTail = [self.objectList count] < [self.fetchRequest fetchLimit];
            [self setBufferFlag];
        }
	}
    [tempArry release];
    [dict release];
}
-(void)setBufferFlag{
    
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"deepid" value:self.deepid];
    
    if (self.currentGetDataKind == GET_DataKind_Next){
        for (FSDeepCommentObject *o in array) {
            if ([o.bufferFlag isEqualToString:@"1"]) {
                o.bufferFlag = @"2";
            }
        }
        [self saveCoreDataContext];
        return;
    }
    
    for (FSDeepCommentObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            ;//o.bufferFlag = @"3";
        }else if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"1"]){
            o.bufferFlag = @"2";
        }
    }
    [self saveCoreDataContext];
}

-(void)setBufferFlag3{
    NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"deepid" value:self.deepid];
    
    
    for (FSDeepCommentObject *o in array) {
        if (_isRefreshToDeleteOldData == YES && [o.bufferFlag isEqualToString:@"2"]) {
            o.bufferFlag = @"3";
        }
    }
    [self saveCoreDataContext];
}

-(void)operateOldBufferData{
    if (self.currentGetDataKind == GET_DataKind_Refresh) {
		
        if (_isRefreshToDeleteOldData == YES) {
            NSArray *array = [[FSBaseDB sharedFSBaseDBWithContext:self.managedObjectContext] getObjectsByKeyWithName:[self entityName] key:@"deepid" value:self.deepid];
            for (FSDeepCommentObject *o in array) {
                if ([o.bufferFlag isEqualToString:@"3"]) {
                    [self.managedObjectContext deleteObject:o];
                    
                }
            }
            [self saveCoreDataContext];
            
        }
	}
}
@end


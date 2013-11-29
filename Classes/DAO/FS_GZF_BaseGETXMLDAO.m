//
//  FS_GZF_BaseGETXMLDAO.m
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-10-19.
//
//

#import "FS_GZF_BaseGETXMLDAO.h"



@implementation FS_GZF_BaseGETXMLDAO

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)dealloc {
    if (_xmlParser) {
        [_xmlParser abortParsing];
        self.xmlParser = nil;
    }
	[super dealloc];
}

- (void)doSomethingInDataReceiveComplete {
    if (self.dataBuffer==nil) {
        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_UnknowErrorStatus];
        return;
    }
    
    
    if (_isRefreshToDeleteOldData==YES) {
        _isRefreshNewDataSuccess = YES;//[self setBufferFlag3];
    }
    //NSLog(@"WebContent:%@",[[[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding] autorelease]);
	//[self operateOldBufferData];
///////////////////////////////////////////////////////////////////////////////    
//#ifdef MYDEBUG
//    NSString *tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:NSUTF8StringEncoding];
//    if (tempXML == NULL) {
//        tempXML = [[NSString alloc] initWithData:self.dataBuffer encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
//    }
//    //NSLog(@"1Current XML\r\n:%@", trimString(tempXML));
//    [tempXML release];
//#endif
    
    //NSLog(@"33333");
    
    _xmlParser = [[NSXMLParser alloc] initWithData:self.dataBuffer];
    _xmlParser.delegate = self;
    NSLog(@"");
    @try {
        if ([_xmlParser parse]) {
            //NSLog(@"NSXMLParser complete:%@[%f]",[self timestampFlag],[[NSDate date] timeIntervalSince1970]);
            
//            [self updataTimestamp:[self timestampFlag]];
//            [self readDataFromBufferWithQueryDataKind:Buffer_DataKind_New];
//            [self baseXMLParserComplete:self];
            
//            if ([NSThread isMainThread]) {
//                NSLog(@"[self timestampFlag]: YES: %@",[self timestampFlag]);
//            }
//            else{
//                NSLog(@"[self timestampFlag]: NO: %@",[self timestampFlag]);
//            }
            NSLog(@"Parse XML Finished:%@",self);
            //[self saveCoreDataContext]; //moved by zhiliang to inner_CallbackScreen
            
            [self performSelectorOnMainThread:@selector(inner_CallbackScreen) withObject:nil waitUntilDone:[NSThread isMainThread]];
        } else {
            NSLog(@"%@",_xmlParser.parserError);
            
        }
    }
    @catch (NSException * e) {
//        NSLog(@"------Exception Caught-------");
//        [self executeCallBackDelegateWithStatus:FSBaseDAOCallBack_NetworkErrorStatus];
//    }
//    @finally {
//        
    }
    //NSLog(@"555555");
    _xmlParser.delegate = nil;
    [_xmlParser release];
    _xmlParser = nil;
	self.dataBuffer = nil;
}

- (void)inner_CallbackScreen {
    [self retain];
    [self saveCoreDataContext];//added by zhiliang
    if (_isRefreshToDeleteOldData==YES && _isRefreshNewDataSuccess == YES) {
        [self setBufferFlag3];
    }
    
    [self updataTimestamp:[self timestampFlag]];
    [self readDataFromBufferWithQueryDataKind:Buffer_DataKind_New];
    [self baseXMLParserComplete:self];
    [self release];
}

@end

//
//  FSDeepCommentObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepCommentObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * commentid;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * devicetype;
@property (nonatomic, retain) NSString * userip;
@property (nonatomic, retain) NSString * flag;

@end

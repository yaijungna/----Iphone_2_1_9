//
//  FSDeepPageObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-25.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepPageObject : FSBatchAbsObject

@property (nonatomic, retain) NSNumber * flag;
@property (nonatomic, retain) NSString * pageid;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, copy) NSString * share_url;
@property (nonatomic, copy) NSString * share_img;
@property (nonatomic, copy) NSString * share_text;

@end

//
//  FSDeepContentObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"

@class FSDeepContent_ChildObject;

@interface FSDeepContentObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * share_text;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSString * subjectid;
@property (nonatomic, retain) NSString * pic_title;
@property (nonatomic, retain) NSString * subjectPic;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * contentid;
@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * share_img;
@property (nonatomic, retain) NSString * share_url;
@property (nonatomic, retain) NSString * subjectTile;
@property (nonatomic, retain) NSSet *childContent;
@end

@interface FSDeepContentObject (CoreDataGeneratedAccessors)

- (void)addChildContentObject:(FSDeepContent_ChildObject *)value;
- (void)removeChildContentObject:(FSDeepContent_ChildObject *)value;
- (void)addChildContent:(NSSet *)values;
- (void)removeChildContent:(NSSet *)values;

@end

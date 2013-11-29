//
//  FSDeepOuterObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepOuterObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * subjectTile;
@property (nonatomic, retain) NSString * share_url;
@property (nonatomic, retain) NSString * leadContent;
@property (nonatomic, retain) NSString * subjectid;
@property (nonatomic, retain) NSString * leadTitle;
@property (nonatomic, retain) NSString * share_img;
@property (nonatomic, retain) NSString * subjectPic;
@property (nonatomic, retain) NSString * outerid;
@property (nonatomic, retain) NSString * share_text;

@end

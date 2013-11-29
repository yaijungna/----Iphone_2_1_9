//
//  FSDeepLeadObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepLeadObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * deepTitle;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * leadContent;
@property (nonatomic, retain) NSString * share_img;
@property (nonatomic, retain) NSString * share_url;
@property (nonatomic, retain) NSString * share_text;

@end

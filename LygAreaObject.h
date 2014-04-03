//
//  LygAreaObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 14-1-23.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LygAreaObject : NSManagedObject

@property (nonatomic, retain) NSNumber * bufferFlag;
@property (nonatomic, retain) NSNumber * areaId;
@property (nonatomic, retain) NSString * areaName;
@property (nonatomic, retain) NSString * iphone_id;
@property (nonatomic, retain) NSString * android_id;

@end

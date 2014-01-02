//
//  LygAreaObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-12-30.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LygAreaObject : NSManagedObject

@property (nonatomic, retain) NSNumber * areaId;
@property (nonatomic, retain) NSString * areaName;
@property (nonatomic, retain) NSNumber * bufferFlag;

@end

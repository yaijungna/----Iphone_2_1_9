//
//  FSDeepPictureObject.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-22.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FSBatchAbsObject.h"


@interface FSDeepPictureObject : FSBatchAbsObject

@property (nonatomic, retain) NSString * deepid;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * pictureText;
@property (nonatomic, retain) NSString * share_img;
@property (nonatomic, retain) NSString * pictureid;
@property (nonatomic, retain) NSString * share_url;
@property (nonatomic, retain) NSString * share_text;

@end

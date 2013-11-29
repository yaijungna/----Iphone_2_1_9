//
//  FS_GZF_GetWeatherMessageDAO.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-12.
//
//


#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"


@class FSWeatherObject,FSUserSelectObject;

@interface FS_GZF_GetWeatherMessageDAO : FS_GZF_BaseGETXMLDataListDAO{
@protected
//    FSWeatherObject *_obj;
//    FSUserSelectObject *_Uobj;
    
}

@property (nonatomic,retain) NSString *group;
@property (nonatomic,retain) NSString *cityID;
@property (nonatomic,retain) NSString *cityName;
@property (nonatomic,retain) NSString *UpdataDate;
@property (nonatomic,retain) FSWeatherObject *obj;
@property (nonatomic,retain) FSUserSelectObject *Uobj;
@end

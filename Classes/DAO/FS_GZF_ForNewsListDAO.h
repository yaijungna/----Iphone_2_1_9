//
//  FS_GZF_ForNewsListDAO.h
//  PeopleNewsReaderPhone
//
//  Created by Xu dandan on 12-11-5.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_ForOneDayNewsListDAO.h"
typedef enum _newTye
{
    puTong        = 0,
    importantNews = 1,
    areaNews      = 2
}NewsType;
typedef enum _ASIAuthenticationType {
	ASIStandardAuthenticationType = 0,
    ASIProxyAuthenticationType = 1
} ASIAuthenticationType;


@interface FS_GZF_ForNewsListDAO : FS_GZF_ForOneDayNewsListDAO{
@protected
    NSString *_channelid;
}

@property (nonatomic,assign) NewsType  newsType;
@property (nonatomic,retain) NSString *channelid;
@property (nonatomic,assign) BOOL     isImportNews;



@end

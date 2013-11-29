//
//  LygDeepCommentListDao.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BaseGETXMLDataListDAO.h"
#import "FSDeepCommentObject.h"
@interface LygDeepCommentListDao : FS_GZF_BaseGETXMLDataListDAO
{
    
}
@property (nonatomic,retain) NSString *count;
@property (nonatomic,retain) NSString *deepid;
@property (nonatomic,retain) NSString *lastCommentid;
@property (nonatomic,retain) FSDeepCommentObject *obj;
@end



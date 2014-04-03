//
//  FSPeopleBlogShareLoginViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-9.
//
//

#import <UIKit/UIKit.h>
#import "FSBaseLoginViewController.h"
#import "ASIHTTPRequest.h"

@class FS_GZF_PeopleBlogLoginPOSTXMLDAO;

@interface FSPeopleBlogShareLoginViewController : FSBaseLoginViewController{
@protected
    FS_GZF_PeopleBlogLoginPOSTXMLDAO *_fs_GZF_PeopleBlogLoginPOSTXMLDAO;
}
@property(nonatomic,retain)FS_GZF_PeopleBlogLoginPOSTXMLDAO *fs_GZF_PeopleBlogLoginPOSTXMLDAO;
@end

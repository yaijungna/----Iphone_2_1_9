//
//  LocalProvinceNewsViewControllers.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 14-1-6.
//
//

#import <UIKit/UIKit.h>
#import "FSLocalNewsCityListController.h"
#import "LygListOfProvincesHaveAreaNewsDao.h"

@interface LocalProvinceNewsViewControllers : FSLocalNewsCityListController
{
    
}

@property(nonatomic,strong)LygListOfProvincesHaveAreaNewsDao * provincesListDao;
@end

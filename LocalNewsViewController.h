//
//  LocalNewsViewController.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-12-16.
//
//

#import <UIKit/UIKit.h>
#import "FSBasePeopleViewController.h"
#import "MyNewsLIstView.h"
#import "LygListOfProvincesHaveAreaNewsDao.h"
#import "LygCustermerBar.h"
@interface LocalNewsViewController : FSBasePeopleViewController
@property(nonatomic,strong)MyNewsLIstView                    * myNewsListView;
@property(nonatomic,strong)UILabel                           * titleLabel;
@property(nonatomic,strong)LygListOfProvincesHaveAreaNewsDao * memGetProvincesDao;
@property(nonatomic,strong)LygAreaObject                     * currentAreaObject;
@property(nonatomic,copy)void (^fpChangeTitleColor)(void);
@property(nonatomic,retain)LygCustermerBar  * rightBar;
@property(nonatomic,assign)int                placeID;
@end

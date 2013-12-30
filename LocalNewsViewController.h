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
@interface LocalNewsViewController : FSBasePeopleViewController
@property(nonatomic,strong)MyNewsLIstView * myNewsListView;
@property(nonatomic,strong)UILabel * titleLabel;
@end

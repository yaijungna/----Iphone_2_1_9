//
//  LygNewsViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ark on 14-1-1.
//
//

#import <UIKit/UIKit.h>
#import "FSBasePeopleViewController.h"
#import "MyNewsLIstView.h"
#import "FS_GZF_ChannelListDAO.h"
@interface LygNewsViewController : FSBasePeopleViewController
@property (nonatomic,strong)MyNewsLIstView * memNewsLIstView;
@property (nonatomic,assign)int  channelIndex;
@property (nonatomic,assign)FS_GZF_ChannelListDAO * changeList;

-(void)chageSize1;
//-(id)initWithChannelIndex:(int)index andChannel:(FS_GZF_ChannelListDAO*)listDao;
-(id)initWithChannelIndex:(int)index andChannel:(FS_GZF_ChannelListDAO*)listDao andNaviGationController:(UINavigationController*)aNavi;

@end

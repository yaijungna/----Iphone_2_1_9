//
//  MyPageViewController.h
//  PeopleNewsReaderPhone
//
//  Created by ark on 14-1-1.
//
//

#import <UIKit/UIKit.h>
#import "FS_GZF_ChannelListDAO.h"
@interface MyPageViewController : UIPageViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic,strong)FS_GZF_ChannelListDAO * fs_GZF_ChannelListDAO;
@property(nonatomic,assign)int                     currentIndex;
@end

//
//  LygCustermerBar.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 14-1-21.
//
//

#import <UIKit/UIKit.h>

@interface LygCustermerBar : UIView
@property(nonatomic,retain)UIButton * nameLabel;
@property(nonatomic,retain)UIImageView * imgeView;
@property(nonatomic,retain)NSString    * title;
@property(nonatomic,retain)UIImageView * imageView;
@property(nonatomic,assign)id            delegate;
-(NSString*)getTitel;
@end
@protocol LygCustermerBarDelegate <NSObject>
-(void)touchEnd;
@end

//
//  FSDeepPageControllView.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-16.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FSNewsDitailToolBar.h"
@interface FSDeepPageControllView : UIView{
@protected
    
    NSInteger _pageCount;
    NSInteger _pageIndex;

    UIImageView *_leftArrow;
    UIImageView *_rightArrow;
    
    UIImageView *_midleImage;
    

    UILabel *_lab_pageIndex;
    UILabel *_lab_pageCount;
    FSNewsDitailToolBar * _fsNewsDitailToolBar;


}

@property (nonatomic) NSInteger pageCount;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic,assign) id delegate;
@property (nonatomic,assign) id parentDelegate;
@property (nonatomic,retain)CAGradientLayer * gradientLayer;
@property (nonatomic,assign) TouchEvenKind        touchEvenKind;
@property (nonatomic,retain) NSString            *comment_content;

-(void)layoutImages;

@end
@protocol FSDeepPageControllViewDelegate <NSObject>
-(void)pageControlViewTouchEvent:(FSDeepPageControllView*)sender;
@end

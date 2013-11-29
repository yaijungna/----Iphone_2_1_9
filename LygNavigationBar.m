//
//  LygNavigationBar.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-10-18.
//
//

#import "LygNavigationBar.h"

@implementation LygNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    float xx = (ISIOS7?64:44);
    if(self = [super init])
    {
        self.frame = CGRectMake(0, 0, 320, xx);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

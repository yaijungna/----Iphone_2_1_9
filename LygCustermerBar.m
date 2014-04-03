//
//  LygCustermerBar.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 14-1-21.
//
//

#import "LygCustermerBar.h"
@interface LygCustermerBar (private)
//@property(nonatomic,retain)UIButton  * nameLabel;
//@property(nonatomic,retain)UIImageView * imgeView;
//@property(nonatomic,retain)NSString    * title;
//@property(nonatomic,retain)UIImageView * imageView;
@end

@implementation LygCustermerBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.nameLabel = [[UIButton alloc]init];
        [self.nameLabel addTarget:self action:@selector(hasTouchEd) forControlEvents:UIControlEventTouchUpInside];
        //self.nameLabel.backgroundColor = [UIColor redColor];
        self.nameLabel.tintColor = [UIColor blackColor];
        [self.nameLabel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.nameLabel.autoresizesSubviews = YES;
        self.nameLabel.titleLabel.autoresizesSubviews = YES;
        //self.nameLabel.frame.origin = CGSizeMake(0, 0);
        
        [self addSubview:self.nameLabel];
        float xxx = 48;
        self.nameLabel.frame = CGRectMake(0, 4, xxx, 44);
        [self.nameLabel setTitle:@"切换" forState:UIControlStateNormal];
        [self.nameLabel.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        self.imageView              = [[[UIImageView alloc]init] autorelease];
        [self.nameLabel addSubview:self.imageView];
        self.imageView.image              = [UIImage imageNamed:@"layoutlistIcon.png"];
        self.imageView.frame              = CGRectMake(xxx - 5, 16, 11, 11);
        //[self.imageView sizeToFit];
        //[self sizeToFit];

    }
    return self;
}
-(void)hasTouchEd
{
    [self.delegate touchEnd];
}

//-(id)init
//{
//    self = [super init];
//    if (self) {
//        self.nameLabel = [[UIButton alloc]init];
//        [self.nameLabel setTitle:@"xxxx" forState:UIControlStateNormal];
//        self.nameLabel.backgroundColor = [UIColor redColor];
//        //self.nameLabel.autoresizesSubviews = YES;
//        //self.nameLabel.frame.origin = CGSizeMake(0, 0);
//        [self addSubview:self.nameLabel];
//        self.nameLabel.frame = CGRectMake(0, 0, 60, 44);
//        
//        
//        self.imageView              = [[[UIImageView alloc]init] autorelease];
//        [self addSubview:self.imageView];
//        self.imageView.image              = [UIImage imageNamed:@"layoutlistIcon.png"];
//        self.imageView.frame              = CGRectMake(0, 0, 11, 11);
//        //[self.imageView sizeToFit];
//        [self sizeToFit];
//    }
//    return self;
//}
-(void)setTitle:(NSString *)title
{
    return;
    [self.nameLabel setTitle:title forState:UIControlStateNormal];
    
//    [self.nameLabel  sizeToFit];
}
-(NSString*)getTitel
{
    return self.nameLabel.titleLabel.text;
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

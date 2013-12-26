//
//  FSNewsListCell.m
//  PeopleNewsReaderPhone
//
//  Created by yuan lei on 12-8-2.
//  Copyright (c) 2012年 people. All rights reserved.
//

#import "FSNewsListCell.h"
#import "GlobalConfig.h"
#import "FSAsyncImageView.h"
#import "FSCommonFunction.h"
#import "FSOneDayNewsObject.h"
#import "FSMyFaverateObject.h"
#import "UIImageView+UIImageViewCache.h"
#import "UIImageView+WebCache.h"
#define HEIGHTOFIMG      57
#define WIDTHOFNEWHASPIC 218
@implementation MyContetView
-(void)drawRect:(CGRect)rect
{
    CGRect tempRect;
    if ([self.delegateCell.data isKindOfClass:[FSOneDayNewsObject class]]) {
        FSOneDayNewsObject * obj = (FSOneDayNewsObject*)self.delegateCell.data;
        if ([obj.picture length]>0 && [self.delegateCell isDownloadPic]) {
            tempRect = CGRectMake(11, 30, WIDTHOFNEWHASPIC, self.frame.size.height - 25);
        }
        else{
            tempRect = CGRectMake(11, 30, self.frame.size.width-20, self.frame.size.height - 25);
        }
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    FSOneDayNewsObject *obj   = (FSOneDayNewsObject *)self.delegateCell.data;
    [obj.news_abstract drawInRect:tempRect withFont:[UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT] lineBreakMode:NSLineBreakByWordWrapping];
}
-(id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end

@implementation FSNewsListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.opaque = YES;
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
}

-(void)doSomethingAtDealloc{
}

-(void)doSomethingAtInit{
    _myContentView = [[MyContetView alloc]init];
    [self.contentView addSubview:_myContentView];
    [_myContentView release];
    _lab_NewsTitle = [[UILabel alloc] init];
    
    _image_Onright = [[UIImageView alloc] init];
    //_image_Onright.imageCuttingKind = ImageCuttingKind_fixrect;
    _image_Onright.contentMode = UIViewContentModeScaleAspectFill;
    _image_Onright.clipsToBounds = YES;
//    _image_Onright.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor;
//    _image_Onright.layer.borderWidth =  1;
    //_image_newsimage.contentMode = UIViewContentModeScaleAspectFill;
    [_myContentView addSubview:_lab_NewsTitle];
    [_myContentView addSubview:_lab_NewsType];
    
    [_myContentView addSubview:_image_Onright];
    [_lab_NewsTitle release];
    [_lab_NewsType release];
    [_image_Onright release];

    
    _lab_NewsTitle.backgroundColor = COLOR_CLEAR;
    _lab_NewsTitle.textColor = COLOR_NEWSLIST_TITLE;
    _lab_NewsTitle.textAlignment = UITextAlignmentLeft;
    _lab_NewsTitle.numberOfLines = 1;
    _lab_NewsTitle.font = [UIFont systemFontOfSize:TODAYNEWSLIST_TITLE_FONT];
    
    
    
    _lab_NewsType.backgroundColor = COLOR_CLEAR;
    _lab_NewsType.textColor = COLOR_NEWSLIST_DESCRIPTION;
    _lab_NewsType.textAlignment = UITextAlignmentLeft;
    _lab_NewsType.numberOfLines = 1;
    _lab_NewsType.font = [UIFont systemFontOfSize:LIST_BOTTOM_TEXT_FONT];

    //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    _leftView = [[UIView alloc] init];
    [_myContentView addSubview:_leftView];
    _leftView.backgroundColor = [UIColor lightGrayColor];
    [_leftView release];
    
}

-(void)setDayPattern:(BOOL)is_day{
    NSLog(@"setDayPattern"); 
}


-(void)doSomethingAtLayoutSubviews{
    _myContentView.frame = self.contentView.frame;
    _myContentView.delegateCell = self;
    [_myContentView setNeedsDisplay];
    _leftView.frame = CGRectMake(0, 0, 4, self.frame.size.height);
    
    NSString * temp = nil;
    if ([self.data isKindOfClass:[FSMyFaverateObject class]]) {
        FSMyFaverateObject *obj = (FSMyFaverateObject *)self.data;
        if (obj.isDeep) {
            _lab_NewsTitle.text = obj.deepTitle;
            
            temp                = obj.deepPictureLink;
        }else
        {
            _lab_NewsTitle.text = obj.title;
            //NSString * string   = obj.news_abstract;
            //_lab_NewsType.text  = obj.news_abstract;
            temp                = obj.picture;
        }
        _lab_NewsTitle.frame = CGRectMake(10, (self.frame.size.height - 25)/2, 310, 25);
        
        if ([temp length]>0 && [self isDownloadPic]) {
            _image_Onright.frame = CGRectMake(self.frame.size.width - 65, 5, HEIGHTOFIMG, HEIGHTOFIMG);
            
            [_image_Onright  setImageWithURL:[NSURL URLWithString:temp] placeholderImage:[UIImage imageWithNameString:@"AsyncImage"]];
            _image_Onright.alpha = 1.0f;
            //_lab_NewsType.frame = CGRectMake(self.frame.size.width-50,4, 40, 22);
            
        }
        else{
            _image_Onright.alpha = 0.0f;
            //_lab_NewsType.frame = CGRectMake(self.frame.size.width-50,4 , 40, 22);
        }

    }
    else{
        FSOneDayNewsObject *obj   = (FSOneDayNewsObject *)self.data;
        _lab_NewsTitle.text       = obj.title;

        temp   = obj.picture;
        _lab_NewsTitle.frame = CGRectMake(10, 4, 310, 25);
        
        if ([temp length]>0 && [self isDownloadPic]) {
            _image_Onright.frame = CGRectMake(self.frame.size.width - 65, 30, HEIGHTOFIMG, HEIGHTOFIMG);
            
            [_image_Onright  setImageWithURL:[NSURL URLWithString:temp] placeholderImage:[UIImage imageWithNameString:@"AsyncImage"]];
            _image_Onright.alpha = 1.0f;
            //_lab_NewsType.frame = CGRectMake(self.frame.size.width-50,4, 40, 22);
            
        }
        else{
            _image_Onright.alpha = 0.0f;
            //_lab_NewsType.frame = CGRectMake(self.frame.size.width-50,4 , 40, 22);
        }
    }
    
    
    

}


-(BOOL)isDownloadPic{
    
    BOOL rest = NO;
    
    if (![[GlobalConfig shareConfig] isSettingDownloadPictureUseing2G_3G]) {
        rest = YES;
        return rest;
    }
    
    if ([[GlobalConfig shareConfig] isDownloadPictureUseing2G_3G]) {
        rest = YES;
    }
    else{
        if (!checkNetworkIsOnlyMobile()) {
            rest = YES;
        }
    }
    return rest;
}

-(NSString *)timeTostring:(NSNumber *)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *hm = dateToString_HM(date);
    
    return hm;
}


+(CGFloat)getCellHeight{
    return 0;
}



//*******************************
+(CGFloat)computCellHeight:(NSObject *)cellData cellWidth:(CGFloat)cellWidth{
    if ([cellData isKindOfClass:[FSOneDayNewsObject class]]) {
        FSOneDayNewsObject *o = (FSOneDayNewsObject *)cellData;
        if (o!=nil) {
            if ([o.picture length]>0) {
                CGSize size = [o.news_abstract sizeWithFont:[UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT] constrainedToSize:CGSizeMake(WIDTHOFNEWHASPIC, 200) lineBreakMode:0];
                
                return (size.height > HEIGHTOFIMG?size.height:HEIGHTOFIMG) + 40;
            }
            else{
                CGSize size = [o.news_abstract sizeWithFont:[UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT] constrainedToSize:CGSizeMake(300, 200) lineBreakMode:0];
                
                return size.height + 40;
                
                
            }
        }
    }else if ([cellData isKindOfClass:[FSMyFaverateObject class]])
    {
        FSMyFaverateObject *obj = (FSMyFaverateObject *)cellData;
        NSLog(@"%@",obj.isDeep);
        if ([obj.isDeep isEqualToNumber:[NSNumber numberWithInt:1]])
        {
//            CGSize size = [obj.deepNews_abstract sizeWithFont:[UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT] constrainedToSize:CGSizeMake(300, 200) lineBreakMode:0];
//            return size.height + 40;
            return 44;
        }else
        {
//            CGSize size = [obj.news_abstract sizeWithFont:[UIFont systemFontOfSize:TODAYNEWSLIST_DESCRIPTION_FONT] constrainedToSize:CGSizeMake(300, 200) lineBreakMode:0];
//             return size.height + 40;
            if (obj.picture) {
                return 67;
            }else
            {
                return 44;
            }
        }

    }

    return 44;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

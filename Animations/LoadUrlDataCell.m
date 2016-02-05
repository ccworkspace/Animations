//
//  LoadUrlDataCell.m
//  Animations
//
//  Created by YouXianMing on 16/2/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoadUrlDataCell.h"
#import "UIImageView+WebCache.h"
#import "PictureModel.h"
#import "UIView+AnimationProperty.h"
#import "DataModel.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIImageView+SDWebImageAnimation.h"
#import "ScaleAnimationStrategy.h"

@interface LoadUrlDataCell ()

@property (nonatomic, strong) UIImageView  *iconImageView;
@property (nonatomic, strong) UILabel      *infoLabel;
@property (nonatomic, strong) UIView       *lineView;
@property (nonatomic, strong) UIButton     *button;

@end

@implementation LoadUrlDataCell

- (void)setupCell {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {

    self.iconImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.iconImageView];
    
    self.infoLabel               = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, Width - 80, 20)];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.font          = [UIFont HeitiSCWithFontSize:14.f];
    [self addSubview:self.infoLabel];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    self.lineView.backgroundColor = [UIColor grayColor];
    self.lineView.alpha           = 0.1f;
    [self addSubview:self.lineView];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
    [self.button addTarget:self action:@selector(showSelectedAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
}

- (void)loadContent {
    
    DataModel *model = self.dataAdapter.data;
    
    self.infoLabel.text  = model.user.infomation.text;
    self.infoLabel.width = Width - 80;
    [self.infoLabel sizeToFit];
    
    self.lineView.y    = self.dataAdapter.cellHeight - 0.5f;
    self.button.height = self.dataAdapter.cellHeight;

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_image.url]
                                   options:0
                                  progress:nil
                                 completed:nil
                         animationStrategy:nil
                                  animated:YES];
}

- (void)showSelectedAnimation {
        
    UIView *tmpView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, self.dataAdapter.cellHeight - 0.5f)];
    tmpView.alpha           = 0.f;
    tmpView.backgroundColor = [[UIColor colorWithRed:arc4random() % 256 / 255.f
                                               green:arc4random() % 256 / 255.f
                                                blue:arc4random() % 256 / 255.f
                                               alpha:1.f] colorWithAlphaComponent:0.30];
    [self addSubview:tmpView];
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tmpView.alpha = 0.8f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            tmpView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            
            [tmpView removeFromSuperview];
        }];
    }];
}

@end
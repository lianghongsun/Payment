//
//  GYZCityHeaderView.m
//  GYZChooseCityDemo
//
//  Created by wito on 15/12/29.
//  Copyright © 2015年 gouyz. All rights reserved.
//

#import "GYZCityHeaderView.h"

@implementation GYZCityHeaderView
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subtitleLabel];
    }
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(10, 0, 150, self.frame.size.height)];
    [self.subtitleLabel setFrame:CGRectMake(180, 0, self.frame.size.width-195, self.frame.size.height)];
}
#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil||_subtitleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setTextColor:[UIColor blackColor]];
        
        _subtitleLabel = [[UILabel alloc] init];
        [_subtitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
        [_subtitleLabel setTextColor:[UIColor blackColor]];
        
    }
    return _titleLabel;
}
@end

//
//  AXDrawView.h
//  AXDrawChart
//
//  Created by yangqijia on 2017/2/13.
//  Copyright © 2017年 yangqijia. All rights reserved.
//

#import <UIKit/UIKit.h>

//饼形图需要的宏定义
#define kAnimationDuration 1.0f
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kPieBackgroundColor [UIColor grayColor]
#define kPieFillColor [UIColor clearColor].CGColor
#define kPieRandColor [UIColor colorWithRed:arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.0f]
#define kLabelLoctionRatio (1.2*bgRadius)

typedef NS_ENUM(NSInteger) {
    LineChart_Type = 0,//折线图
    PieChart_Type = 1, //饼形图
    BarChart_Type = 2  //柱状图
}DrawViewType;

@interface AXDrawView : UIView<CAAnimationDelegate>

//自定义初始化方法
-(id)initWithFrame:(CGRect)frame type:(DrawViewType)type;

//绘图类型
@property(nonatomic ,assign)DrawViewType drawType;
//折线图数据数组
@property(nonatomic ,strong)NSMutableArray *arrayPoint;
//折线图开始点
@property(nonatomic ,assign)CGPoint startPint;
//折线图结束点
@property(nonatomic ,assign)CGPoint endPoint;

//饼形图颜色数据
@property(nonatomic ,strong)NSArray *colorItems;

@end


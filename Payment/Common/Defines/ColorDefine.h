//
//  ColorDefine.h
//  RuiTuEBusiness
//
//  Created by Naive on 2016/11/21.
//  Copyright © 2016年 Naive. All rights reserved.
//


/**
 *  全局主要色调
 */
#define ThemeColor [UIColor colorWithRed:0/255.0 green:174/255.0 blue:236/255.0 alpha:1]

/**
 *  十六进制颜色转UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  获得RGB颜色
 */
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

/**
 *  背景色
 */
#define ThemeBackgroundColor RGB(0, 174, 236)



//
//  UIColor+HXCategory.h
//  HXFutures
//
//  Created by HEXUN_MAC on 9/6/13.
//  Copyright (c) 2013 和讯网 和讯信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+_16ToRGB.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green: ((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


/***********************************************************************************************/
#define kColorBackground                            @"background"                           //应用背景色
#define kColorNaviTitle                             @"navi_title"                           //标题色
#define kColorEmptyInfoText                         @"emptyinfo_text"                       //无自选提示色
#define kColorTableHeaderBackground                 @"tableheader_background"               //表头色
#define kColorTableHeaderText                       @"tableheader_text"                     //表头字段
#define kColorTableListHeaderBackground             @"tablelistheader_background"          //行情表头色
#define kColorTableViewCellText                     @"tableviewcell_text"                   //表格字体
#define kColorTableViewCellTextRead                 @"tableviewcell_text_read"              //表格字体已读
#define kColorTableViewCellTextHighlighted          @"tableviewcell_text_h"                 //字体选中
#define kColorTableViewCellDetailText               @"tableviewcell_detailtext"             //表格副标题
#define kColorTableViewCellDetailTextHighlighted    @"tableviewcell_detailtext_h"           //副标题选中
#define kColorTableViewSeparatorcolor               @"tableviewcell_separatorcolor"         //表格分隔线
#define kColorTextFieldPlaceholder                  @"textfiled_placeholder"
#define KColorTableViewCellLine                     @"tableviewcell_line"
#define KColorTableViewSectionBackgroundColor       @"tableViewSectionBackgroundColor"     //table分组背景颜色
#define KColorTableViewSectionTextColor             @"tableViewSectionTextolor"            //table分组文字颜色
#define KColorHeaderBackgroundColor                 @"headerBackgroundColor"               //header背景颜色
#define KColorHeaderBtnSelectColor                  @"headerBtnSelectColor "               //header按钮选中颜色

#define kColorTradeSection                          @"tradesection_background"
#define kColorTradeSectionText                      @"tradesection_text"
#define kColorSegmentedText                         @"segmented_textLabel"
#define kColorSegmentedTextSelected                 @"segmented_textLabel_selected"
#define kColorSegmentedTextDisabled                 @"segmented_textLabel_disabled"
#define kColorSegmentedSelectedBackground           @"segmented_indicator"
#define kColorTimeSelectorSelectedBackground        @"timeselector_segmented_indicator"

/***********************************走势图***********************************************************/
#define kColorChartsBackground                      @"charts_background"                    //背景色
#define kColorChartsBorder                          @"charts_border"                        //边框色
#define kColorChartsWaterLine                       @"charts_waterline"                     //分割线
#define kColorChartsTradeTime                       @"charts_tradetime"                     //时间
#define kColorChartsPrice                           @"charts_price"                         //分时走势
#define kColorChartsAve                             @"charts_ave"                           //均价走势
#define kColorChartsVolume                          @"charts_volume"                        //分时量
#define kColorKLineAve1                             @"kline_ave1"                           //均价线1
#define kColorKLineAve2                             @"kline_ave2"                           //均价线2
#define kColorKLineAve3                             @"kline_ave3"                           //均价线3
#define kColorRise                                  @"rise"                                 //涨
#define kColorFall                                  @"fall"                                 //跌
#define kColorUnchange                              @"unchange"                             //平
#define KNormalTextColor                            @"KNormalTextColor"                     //字体颜色

/*************************************************************************************************/

@interface UIColor (HXCategory)

+ (UIColor *)colorWithHex:(NSString *)hexString;

+ (UIColor *)colorForKey:(NSString *)viewName;

+ (UIColor *)colorOfPrice:(double)price;

@end


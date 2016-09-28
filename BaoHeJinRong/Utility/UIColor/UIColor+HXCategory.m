//
//  UIColor+HXCategory.m
//  HXFutures
//
//  Created by HEXUN_MAC on 9/6/13.
//  Copyright (c) 2013 和讯网 和讯信息科技有限公司. All rights reserved.
//

#import "UIColor+HXCategory.h"
//#import "HXAppSetting.h"
@implementation UIColor (HXCategory)

+ (UIColor *)colorWithHex:(NSString *)hexString
{
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:2];//0x
    
    unsigned int hexInt;
    [scanner scanHexInt:&hexInt];
    
    return UIColorFromRGB(hexInt);
}


+ (UIColor *)colorForKey:(NSString *)viewName
{
    BOOL nightMode = NO;//[[HXAppSetting sharedInstance] isNightMode];
    
    if ([viewName isEqualToString:kColorBackground]) {
        return UIColorFromRGB((nightMode ? 0x0E0E0E : 0xF0F0F0));
    }
    else if ([viewName isEqualToString:kColorNaviTitle]) {
        return UIColorFromRGB((nightMode ? 0xD0D0D0 : 0x1176CC));
    }
    else if ([viewName isEqualToString:kColorEmptyInfoText]) {
        return UIColorFromRGB((nightMode ? 0x4B4B4B : 0x959595));
    }
    else if ([viewName isEqualToString:kColorTableHeaderBackground]) {
        return UIColorFromRGB((nightMode ? 0x1B1B1B : 0xDCDBDB));
    }
    else if ([viewName isEqualToString:kColorTableHeaderText]) {
        return UIColorFromRGB((nightMode ? 0x8A8A8A : 0x000000));
    }
    else if ([viewName isEqualToString:kColorTableViewSeparatorcolor]) {
        return UIColorFromRGB((nightMode ? 0x292929 : 0xD0D0D0));
    }
    else if ([viewName isEqualToString:@"tableviewcell_selected"]) {
        return UIColorFromRGB((nightMode ? 0x151515 : 0xE1E1E1));
    }
    else if ([viewName isEqualToString:kColorTableViewCellText]) {
        return UIColorFromRGB((nightMode ? 0x6E6E6E : 0x000000));
    }
    else if ([viewName isEqualToString:kColorTableViewCellDetailText]) {
        return UIColorFromRGB((nightMode ? 0x6E6E6E : 0x808080));
    }
    else if ([viewName isEqualToString:kColorTableViewCellTextRead]) {
        return UIColorFromRGB((nightMode ? 0x383838 : 0x808080));
    }
    else if ([viewName isEqualToString:kColorTableViewCellTextHighlighted]) {
        return UIColorFromRGB((nightMode ? 0x383838 : 0x000000));
    }
    else if ([viewName isEqualToString:kColorTableViewCellDetailTextHighlighted]) {
        return UIColorFromRGB((nightMode ? 0x383838 : 0x000000));
    }
    else if ([viewName isEqualToString:kColorSegmentedText]) {
        return UIColorFromRGB((nightMode ? 0x8A8A8A : 0x333333));
    }
    else if ([viewName isEqualToString:kColorSegmentedTextSelected]) {
        return UIColorFromRGB((nightMode ? 0xCCCCCC : 0xFFFFFF));
    }
    else if ([viewName isEqualToString:kColorSegmentedTextDisabled]) {
        return UIColorFromRGB((nightMode ? 0x333333 : 0x999999));
    }
    else if ([viewName isEqualToString:kColorSegmentedSelectedBackground]) {
        return UIColorFromRGB((nightMode ? 0x000000 : 0x1D2343));
    }
    else if ([viewName isEqualToString:kColorTimeSelectorSelectedBackground]) {
        return UIColorFromRGB((nightMode ? 0x505050 : 0x4E4E4E));
    }
    else if ([viewName isEqualToString:kColorUnchange]) {
        return UIColorFromRGB((nightMode ? 0x6E6E6E : 0x000000));
    }
    else if ([viewName isEqualToString:kColorRise]) {
        return UIColorFromRGB((nightMode ? 0xB30000 : 0xB30000));
    }
    else if ([viewName isEqualToString:kColorFall]) {
        return UIColorFromRGB((nightMode ? 0x137D01 : 0x137D01));
    }
    else if ([viewName isEqualToString:kColorChartsBackground]) {
        return nightMode? UIColorFromRGB(0x151515):[UIColor colorWithRed:.89 green:.89 blue:.89 alpha:1.0];
    }
    else if ([viewName isEqualToString:kColorChartsBorder]) {
        return UIColorFromRGB((nightMode ? 0x5B5B5B : 0x000000));
    }
    else if ([viewName isEqualToString:kColorChartsWaterLine]) {
        return UIColorFromRGB((nightMode ? 0x5B5B5B : 0x5B5B5B));
    }
    else if ([viewName isEqualToString:kColorChartsTradeTime]) {
        return UIColorFromRGB((nightMode ? 0x999999 : 0x000000));
    }
    else if ([viewName isEqualToString:kColorChartsPrice]) {
        return UIColorFromRGB((nightMode ? 0x047CC6 : 0x047CC6));
    }
    else if ([viewName isEqualToString:kColorChartsAve]) {
        return UIColorFromRGB((nightMode ? 0xE9409F : 0xE9409F));
    }
    else if ([viewName isEqualToString:kColorChartsVolume]) {
        return UIColorFromRGB((nightMode ? 0x047CC6 : 0x047CC6));
    }
    else if ([viewName isEqualToString:kColorKLineAve1]) {
        return UIColorFromRGB((nightMode ? 0x999999 : 0x000000));
    }
    else if ([viewName isEqualToString:kColorKLineAve2]) {
        return UIColorFromRGB(0x2D1DDE);
    }
    else if ([viewName isEqualToString:kColorKLineAve3]) {
        return UIColorFromRGB(0xC546B8);
    }
    else if ([viewName isEqualToString:kColorTextFieldPlaceholder]) {
        return UIColorFromRGBA((nightMode ? 0x999999 : 0x5B5B5B), 0.7);
    }
    else if ([viewName isEqualToString:kColorTradeSection]) {
        return UIColorFromRGBA((nightMode ? 0x292929 : 0xE7E3E3), 0.7);
    }
    else if ([viewName isEqualToString:kColorTradeSectionText]) {
        return UIColorFromRGB((nightMode ? 0x666666 : 0x999999));
    }
    else if ([viewName isEqualToString:kColorTradeSectionText]) {
        return UIColorFromRGB((nightMode ? 0x666666 : 0x999999));
    }
    else if ([viewName isEqualToString:kColorTableListHeaderBackground]) {
        return UIColorFromRGB((nightMode ? 0x292929 : 0xdcdbdb));
    }
    else if ([viewName isEqualToString:KColorTableViewSectionBackgroundColor]) {
        return UIColorFromRGB((nightMode ? 0x343434 : 0xF1F1F1));
    }
    else if ([viewName isEqualToString:KColorTableViewSectionTextColor]) {
        return UIColorFromRGB((nightMode ? 0xadadad : 0x999999));
    }
    else if ([viewName isEqualToString:KColorHeaderBackgroundColor]) {
        return UIColorFromRGB((nightMode ? 0xadadad : 0xEAEAEA));
    }
    else if ([viewName isEqualToString:KColorHeaderBtnSelectColor]) {
        return UIColorFromRGB((nightMode ? 0x111111 : 0x1d2343));
    }
    
    return UIColorFromRGB(0xF0F0F0) ;
}

+ (UIColor *)colorOfPrice:(double)price
{
    if (price > 0) {
        return [UIColor colorForKey:kColorRise];
    }
    else if (price < 0) {
        return [UIColor colorForKey:kColorFall];
    }
    else {
        return [UIColor colorForKey:kColorUnchange];
    }
}

@end

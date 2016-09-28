//
//  SmallBuyView.h
//  HeXunRongHeJinFu
//
//  Created by 祝敏彧 on 16/2/3.
//  Copyright © 2016年 庄小宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPayByView.h"

@interface SmallBuyView : UIButton <SelectPayByViewDelegate>

- (void)showBuyView;
@end

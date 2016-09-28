//
//  SelectPayByView.h
//  HeXunRongHeJinFu
//
//  Created by 祝敏彧 on 16/2/4.
//  Copyright © 2016年 庄小宁. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SelectPayByView;
@protocol SelectPayByViewDelegate <NSObject>
@optional
-(void)SelectBankName:(NSString *)nameStr andBankCode:(NSString *)codeStr;

@end

@interface SelectPayByView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <SelectPayByViewDelegate> selectDelegate;
@end

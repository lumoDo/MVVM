//
//  CycleScrollView.h
//  saisaipk
//
//  Created by liuchengbin on 29/4/12.
//  Copyright (c) 2012 com.linkertimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CycleScrollViewDelegate<NSObject>
@optional
-(void)pageViewClicked:(NSInteger)pageIndex;
-(void)beginScroll;
-(void)endScroll;
-(void)dismissView;
@end

@interface CycleScrollView : UIView <UIScrollViewDelegate>{
    
    UIScrollView *imgScrollView;
//    UIPageControl  *pageControl;
    NSMutableArray *imagesArray;   // 存放所有需要滚动的图片
    
    NSMutableArray *curImages; //存放当前滚动的三张图片
    
    int totalPageCount;//图片的总张数
    
    int curPageIndex;//当前图片的索引
    
    CGRect scrollFrame;
    UILabel * showNumLabel;
    BOOL needLoop;
    id <CycleScrollViewDelegate> delegate;
//    BOOL scrollLeft;
    NSInteger defaultSelectIndex;
}
@property (nonatomic)NSInteger defaultSelectIndex;
@property (nonatomic)BOOL needLoop;
@property (nonatomic,retain)UILabel * showNumLabel;

@property (nonatomic,assign)id <CycleScrollViewDelegate> delegate;

- (NSArray*) getDisplayImagesWithPageindex;

- (int) validPageValue:(NSInteger)value;

- (void) refreshScrollView;

- (id)initWithFrame:(CGRect)frame pictures:(NSArray*)pictureArray;

-(void)ButtonClicked:(UIGestureRecognizer *)gesture;

//-(void)scrollTimer;
-(void)setDataWith:(NSArray *)array;
@end

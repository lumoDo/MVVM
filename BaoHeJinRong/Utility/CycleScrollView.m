//
//  CycleScrollView.m
//  saisaipk
//
//  Created by liuchengbin on 29/4/12.
//  Copyright (c) 2012 com.linkertimes. All rights reserved.
//

#import "CycleScrollView.h"

@implementation CycleScrollView

@synthesize delegate;
@synthesize needLoop;
@synthesize showNumLabel;
@synthesize defaultSelectIndex;

-(void)setDefaultSelectIndex:(NSInteger)_defaultSelectIndex
{
    defaultSelectIndex = _defaultSelectIndex;
    [imgScrollView setContentOffset:CGPointMake(defaultSelectIndex * imgScrollView.frame.size.width, 0)];
    curPageIndex = imgScrollView.contentOffset.x / imgScrollView.frame.size.width;
    
    
    showNumLabel.text = [NSString stringWithFormat:@"%d/%d",curPageIndex + 1,totalPageCount];
}
- (id)initWithFrame:(CGRect)frame pictures:(NSArray*)pictureArray
{
    self = [super initWithFrame:frame];
    if (self) {
        needLoop = NO;
        scrollFrame=frame;
        
        
        curImages=[[NSMutableArray alloc] init];
        imagesArray=[[NSMutableArray alloc]init];
        [imagesArray addObjectsFromArray:pictureArray];
        totalPageCount=(int)[imagesArray count];
        
        curPageIndex=0;//当前显示的是图片数组里的第一张图片
        
        imgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imgScrollView.backgroundColor=[UIColor clearColor];
        imgScrollView.showsVerticalScrollIndicator=NO;
        imgScrollView.showsHorizontalScrollIndicator=NO;
        imgScrollView.bounces = NO;
        imgScrollView.pagingEnabled=YES;
        imgScrollView.delegate=self;
        
        imgScrollView.contentSize=CGSizeMake(imgScrollView.frame.size.width * totalPageCount, imgScrollView.frame.size.height);
        [self addSubview:imgScrollView];
        
        
        if (totalPageCount < 2) {
            CGRect c = imgScrollView.frame;
            c.size.height = self.frame.size.height;
            c.origin.y = 0;
            
            imgScrollView.frame = c;
            
            imgScrollView.scrollEnabled = NO;
        }
        [self refreshScrollView];
    }
    return self;
}
-(void)setDataWith:(NSArray *)array
{
    [imagesArray removeAllObjects];
    [imagesArray addObjectsFromArray:array];
    totalPageCount=(int)[imagesArray count];
    [self refreshScrollView];
    if (totalPageCount < 2) {
        
        imgScrollView.scrollEnabled = NO;
    }
}
//-(void)scrollTimer
//{
//    [scrollView setContentOffset:CGPointMake(scrollFrame.size.width + scrollFrame.size.width, 0)animated:YES];
//}

- (void) refreshScrollView
{
    NSArray *subViews=[imgScrollView subviews];
    
    if ([subViews count]>0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //    [self getDisplayImagesWithPageindex];
    for (int i = 0 ; i < [imagesArray count];  i++)
    {
        
        UIView  * imageview = [imagesArray objectAtIndex:i];
        imageview.tag = i;
        imageview.userInteractionEnabled = YES;
        if (i == imagesArray.count - 1) {
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ButtonClicked:)];
            [imageview addGestureRecognizer:gesture];
            [gesture release];
        }
        
        imageview.backgroundColor = [UIColor clearColor];
        imageview.frame = CGRectMake(scrollFrame.size.width*i, 0, self.frame.size.width, self.frame.size.height);
        
        [imgScrollView addSubview:imageview];
    }
    //    if (totalPageCount > 1) {
    //        [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0)];
    //    }
    if (showNumLabel == nil) {
        showNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, self.frame.size.height - 100, self.frame.size.width - 600, 100)];
        showNumLabel.backgroundColor = [UIColor clearColor];
        showNumLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        showNumLabel.textAlignment = NSTextAlignmentCenter;
        showNumLabel.textColor = [UIColor whiteColor];
        [self addSubview:showNumLabel];
    }
    showNumLabel.text = [NSString stringWithFormat:@"%d/%d",curPageIndex,totalPageCount];
    [self bringSubviewToFront:showNumLabel];
}

- (NSArray*) getDisplayImagesWithPageindex
{
    if (totalPageCount ==0) {
        return [NSArray array];
    }
    int pre = [self validPageValue:curPageIndex - 1];
    int last = [self validPageValue:curPageIndex + 1];
    
    
    [curImages removeAllObjects];
    
    [curImages addObject:[imagesArray objectAtIndex:pre]];
    [curImages addObject:[imagesArray objectAtIndex:curPageIndex]];
    [curImages addObject:[imagesArray objectAtIndex:last]];
    
    
    return curImages;
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = totalPageCount - 1;
    if (needLoop) {
        if(value == totalPageCount) value = 0;
    }
    
    
    return (int)value;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    curPageIndex = imgScrollView.contentOffset.x / imgScrollView.frame.size.width;
    showNumLabel.text = [NSString stringWithFormat:@"%d/%d",curPageIndex + 1,totalPageCount];
    if (curPageIndex >= 4) {
        if (delegate != nil && [delegate respondsToSelector:@selector(pageViewClicked:)]) {
            [delegate pageViewClicked:curPageIndex];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)ButtonClicked:(UIGestureRecognizer *)gesture
{
    if (delegate != nil && [delegate respondsToSelector:@selector(pageViewClicked:)]) {
        [delegate pageViewClicked:curPageIndex];
    }
}


- (void)dealloc
{
    [showNumLabel release];
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [imgScrollView release];
    [imagesArray release];
    
    [curImages release];
    
    [super dealloc];
}

@end
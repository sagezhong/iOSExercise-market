//
//  HeaderView.h
//  Secondary_Market
//
//  Created by Maktub on 27/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView<UIScrollViewDelegate>

@property(nonatomic, strong) UIView *view;

@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

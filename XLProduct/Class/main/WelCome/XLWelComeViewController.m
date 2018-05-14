//
//  XLWelComeViewController.m
//  XLProduct
//
//  Created by Mac on 2018/1/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLWelComeViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
@interface XLWelComeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *array;

@end

@implementation XLWelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestWelcomData];
    [self.view addSubview:self.scrollView];
//    [self.view addSubview:self.pageControl];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSInteger current = (int)scrollView.contentOffset.x/WIDTH(self.view);
//    _pageControl.currentPage = current;
}

#pragma mark - private methods

- (void)handleStartButton
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setupRootViewController];
}

- (void)setupImageView
{
    self.scrollView.contentSize = CGSizeMake(_array.count*WIDTH(self.view), HEIGHT(self.view));
    for (NSInteger i = 0; i < _array.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH(self.view)*i, 0, WIDTH(self.view), HEIGHT(self.view))];
        NSURL *url = [NSURL URLWithString:_array[i]];
        
        NSString *palceImageName = [NSString stringWithFormat:@"welcome%@", @(i)];
        DLog(@"imagename---%@", palceImageName);
        [imageView sd_setImageWithURL:url placeholderImage:OrigIMG(palceImageName)];
        if (i == _array.count - 1)
        {
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            startBtn.frame = CGRectMake(0, HEIGHT(self.view)-130, WIDTH(self.view)*0.4, 40);
            startBtn.center = CGPointMake(self.view.center.x, startBtn.center.y);
            [startBtn setTitle:@"马上开始" forState:UIControlStateNormal];
            startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            ViewRadius(startBtn, 4);
            [startBtn addTarget:self action:@selector(handleStartButton) forControlEvents:UIControlEventTouchUpInside];
            startBtn.backgroundColor = kHCNavBarColor;
            imageView.userInteractionEnabled = YES;
            
            [imageView addSubview:startBtn];
        }
        [self.scrollView addSubview:imageView];
    }
}

#pragma mark - setter or getter

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

//- (UIPageControl *)pageControl
//{
//    if (!_pageControl)
//    {
//        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT(self.view)-50, WIDTH(self.view)*0.3, 25)];
//        _pageControl.center = CGPointMake(self.view.center.x, _pageControl.center.y);
//        _pageControl.currentPage = 0;
//        _pageControl.pageIndicatorTintColor = UIColorFromRGB(0xcccccc);
//        _pageControl.currentPageIndicatorTintColor = kHCNavBarColor;
//    }
//    return _pageControl;
//}


#pragma mark - network

- (void)requestWelcomData
{
    XLPubicRequsetApi *api=[[XLPubicRequsetApi alloc]init];
    api.dicBody=@{};
    api.requestStr=@"home/slides/guide";
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus==HCRequestStatusSuccess) {
            void(^block)(void)=^{
                [self parseWelcomData:responseObject];
            };
            MAIN(block);
        }else{
            [self showHUDError:message];
            //
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app setupRootViewController];
        }
    }];
}

- (void)parseWelcomData:(NSDictionary *)dic
{
    NSInteger code = [dic[@"code"] integerValue];
    if (code == 1)
    {
        [self hideHUDView];
        NSArray *dataArr=dic[@"data"];
        NSMutableArray *imageArr=@[].mutableCopy;
        for (NSDictionary *dic in dataArr) {
            [imageArr addObject:dic[@"image"]];
        }
        
        _array = imageArr;
//        _pageControl.numberOfPages = _array.count;
        [self setupImageView];
    }else
    {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app setupRootViewController];
    }
}

@end

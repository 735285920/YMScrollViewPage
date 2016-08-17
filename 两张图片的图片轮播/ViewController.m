//
//  ViewController.m
//  两张图片的图片轮播
//
//  Created by shumei on 16/8/1.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UITableView * table_view;
    
    UIScrollView * scroll_view;
    NSArray * images;
    float currentPage;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    images = @[@"4.jpg",
               @"7.png",
               @"6.png",
               @"8.png"];
    
    scroll_view                                = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
    scroll_view.delegate                       = self;
    scroll_view.pagingEnabled                  = YES;
    scroll_view.showsHorizontalScrollIndicator = NO;
    scroll_view.showsVerticalScrollIndicator   = NO;
    scroll_view.backgroundColor                = [UIColor whiteColor];
    scroll_view.contentSize                    = CGSizeMake(images.count*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:scroll_view];
    
    
    for (int x = 0; x < 2; x ++) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imageView.tag           = x + 1;
        imageView.image         = [UIImage imageNamed:images[x]];
        imageView.contentMode   = UIViewContentModeScaleAspectFit;
        [scroll_view addSubview:imageView];
    }

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //因为是通过判断当前的位置，来设置下一个imageview的位置及图片，所以要判断当前的位置，在第一张图片和最后一张图片时，滑动不进行计算，避免数组越界
    if (scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width < images.count - 1 &&
        scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width > 0){
        
        //通过记录上次滑动的位置和当前滑动位置对比，判断滑动方向
        NSInteger currentTag;
        
        //开始滚动将要显示的imageview的图片
        NSInteger ImagesTag;
        
        //向左滑动
        if (currentPage < scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width) {
            
            //向上取整
            ImagesTag = ceilf(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
            
            //默认图片位置已经设置好了，不需要重新设置，避免资源浪费
            if (ImagesTag == 1) {
                return;
            }
        }
        //向右滑动
        else{
            
            ImagesTag = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
            
            if (ImagesTag == images.count - 2) {
                return;
            }
            
        }
        //获取当前显示的位置
        currentPage         = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        //根据当前的位置，确定下个将要显示的imageview
        if (ImagesTag % 2 == 0){
            
            currentTag = 1;
        }
        else{
            
            currentTag = 2;
        }
        
        UIImageView * image = (UIImageView *)[scrollView viewWithTag:currentTag];

        image.image         = [UIImage imageNamed:images[ImagesTag]];

        image.frame         = CGRectMake(ImagesTag * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

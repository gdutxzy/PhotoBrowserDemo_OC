//
//  ViewController.m
//  PhotoBrowserDemo
//
//  Created by XZY on 2018/9/12.
//  Copyright © 2018年 xiezongyuan. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import "XYPhotoBrowserVC.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (strong,nonatomic) NSArray<NSString *> *urlArray;
@end

@implementation ViewController
- (IBAction)imageViewTap:(UITapGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView *)sender.view;
    
    NSArray *urlArray = self.urlArray;
    NSArray *imageArray = @[self.imageView1,self.imageView2];
    NSInteger index = [imageArray indexOfObject:imageView];
    index = index == NSNotFound ? 0:index;
    
    XYPhotoBrowserVC *vc = [XYPhotoBrowserVC photoBrowserWithImageURLs:urlArray images:nil imageViews:imageArray currentIndex:index];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlArray = @[@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2064500517,3561753544&fm=26&gp=0.jpg",@"http://img5.imgtn.bdimg.com/it/u=1505624731,3616873916&fm=27&gp=0.jpg"];
    
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
        [[SDWebImageDownloader sharedDownloader] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.urlArray[1]]];
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.urlArray[0]]];

    [self registerForPreviewingWithDelegate:self sourceView:self.imageView1];
    [self registerForPreviewingWithDelegate:self sourceView:self.imageView2];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSArray *urlArray = self.urlArray;
    NSArray *imageArray = @[self.imageView1,self.imageView2];
    NSInteger index = [imageArray indexOfObject:previewingContext.sourceView];
    index = index == NSNotFound ? 0:index;

    XYPhotoBrowserVC *vc = [XYPhotoBrowserVC photoBrowserWithImageURLs:urlArray images:nil imageViews:imageArray currentIndex:index];
    

    return vc;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self presentViewController:viewControllerToCommit animated:YES completion:^{
        
    }];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end

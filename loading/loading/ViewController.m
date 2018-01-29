//
//  ViewController.m
//  loading
//
//  Created by 薛佳妮 on 2018/1/29.
//  Copyright © 2018年 jiani. All rights reserved.
//

#import "ViewController.h"
#import "SmileLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showSmileView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showSmileView {
    
    SmileLoadingView *loadingView = [[SmileLoadingView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    loadingView.center = self.view.center;
    loadingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loadingView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

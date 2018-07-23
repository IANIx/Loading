//
//  ViewController.m
//  loading
//
//  Created by 薛佳妮 on 2018/1/29.
//  Copyright © 2018年 jiani. All rights reserved.
//

#import "ViewController.h"
#import "SmileLoadingView.h"
#import "NVLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showSmileView];
    [self showNVLoadingWithSucess:YES];
    [self showNVLoadingWithSucess:NO];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showSmileView {
    
    SmileLoadingView *loadingView = [[SmileLoadingView alloc]initWithFrame:CGRectMake(20, 50, 30, 30)];
    [self.view addSubview:loadingView];
    
}

- (void)showNVLoadingWithSucess:(BOOL)sucess {
    NVLoadingView *loadingView = [[NVLoadingView alloc]initWithFrame:CGRectMake(70, 50, 300, 300)];
    [self.view addSubview:loadingView];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

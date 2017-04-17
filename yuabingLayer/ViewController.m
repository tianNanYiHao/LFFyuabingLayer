//
//  ViewController.m
//  yuabingLayer
//
//  Created by tianNanYiHao on 2017/3/16.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

#import "SDCircleView.h"

@interface ViewController ()

{
    SDCircleView *vi;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(sliding) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 80, 100, 30);
    [btn setTitle:@"创建圆饼" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
}
-(void)sliding{
    
    //偏移量
    CGFloat offset = 10;
    vi  = [[SDCircleView alloc] initWithFrame:CGRectMake(0, 100, 300, 150+offset*2) offset:offset numberArray:@[@"0",@"0"] colorArray:@[[UIColor colorWithRed:240/255.0 green:72/255.0 blue:85/225.0 alpha:1],[UIColor colorWithRed:35/255.0 green:218/255.0 blue:254/225.0 alpha:1]]];
    vi.allMonenyStr = @"128000";
    
    
    [self.view addSubview:vi];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [vi sdCircleViewSetNumberArrayDate:@[@"111",@"222"]];
}



@end

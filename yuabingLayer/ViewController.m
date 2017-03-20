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



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //偏移量
    CGFloat offset = 10;
    SDCircleView *vi  = [[SDCircleView alloc] initWithFrame:CGRectMake(0, 100, 300, 150+offset*2) offset:offset numberArray:@[@"2000",@"10800"] colorArray:@[[UIColor colorWithRed:240/255.0 green:72/255.0 blue:85/225.0 alpha:1],[UIColor colorWithRed:35/255.0 green:218/255.0 blue:254/225.0 alpha:1]]];
    vi.allMonenyStr = @"128000";
    [self.view addSubview:vi];
    

}

@end

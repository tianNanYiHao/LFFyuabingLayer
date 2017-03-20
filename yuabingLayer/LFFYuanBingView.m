//
//  LFFYuanBingView.m
//  yuabingLayer
//
//  Created by tianNanYiHao on 2017/3/16.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "LFFYuanBingView.h"

@implementation LFFYuanBingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)drawRect:(CGRect)rect{
    
    CGFloat w = self.bounds.size.width;
    
    CGFloat h = self.bounds.size.height;
    
    
    
    //数据数组
    
    NSArray *array = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    
    //颜色数组
    
    NSArray *colorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor],[UIColor cyanColor],[UIColor blueColor],[UIColor lightGrayColor],[UIColor grayColor],[UIColor darkGrayColor],[UIColor magentaColor],[UIColor orangeColor]];
    
    //下面这个循环是为了假如只有几种颜色 ，但是数据非常多的情况下 ，循环使用颜色的算法
    
    //新建的颜色数组
    
    NSMutableArray * colorArr=[NSMutableArray new];
    
    //这个循环是 只显示颜色数组中前三个的颜色，%后面的数 是根据你的颜色数组中有多少颜色
    
    for (int i=0; i<array.count; i++) {
        
        [colorArr addObject:colorArray[i%10]];
        
    }
    
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    
    
    //中心点
    
    CGPoint center = CGPointMake(w * 0.5, h * 0.5);
    
    //半径
    
    CGFloat radius = w * 0.3 - 5;
    
    
    
    //起点角度
    
    CGFloat startA = 0;
    
    //终点角度
    
    CGFloat endA =M_PI;
    
    //扫过角度范围
    
    CGFloat angle = 0;
    
    
    
    for (int i = 0; i < array.count; i ++) {
        
        //这句话是为了画完其中一个之后第二个的起点就是第一个的终点，这里面M_PI代表的是180度 55这个数值是数据源的总和
        
        startA = endA;
        
        angle = [array[i] integerValue] / 55 * M_PI * 2;
        
        endA = startA + angle;
        
        
        
        //弧形路径
        
        //clockwise: 是否是按照时钟的方向旋转(是否顺时针)
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        
        //连接中心, 构成扇形
        
        [path addLineToPoint:center];
        
        
        
        //填充颜色
        
        [(UIColor *)colorArr[i] set];
        
        
        
        CGContextAddPath(ctx, path.CGPath);
        
        
        
        // 将上下文渲染到视图
        
        CGContextFillPath(ctx);
        
    }
    
}



@end

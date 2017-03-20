//
//  viewLLL.m
//  yuabingLayer
//
//  Created by tianNanYiHao on 2017/3/16.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDCircleView.h"
@interface SDCircleView(){
    
    
    CALayer *baseLayer;
    CAShapeLayer *circleLayer; //圆形
    CGFloat offsetF;            //偏移量
    
    
    NSArray *numberArray;  //数据数组
    NSArray *colorArray;   //颜色数组
    CGPoint centerCircle;  //圆心
    CGFloat circleRadius;  //圆半径
    
    CGFloat startAngle;    //起始夹角
    CGFloat endAngle;      //结束夹角
    CGFloat tempAngle;     //扫过对应的夹角
    BOOL isclockWisk;      //是否顺时针
    CGFloat space;         //间距
    
    UIView *bGView;        //总金额bgview
    UILabel *titleOne;     //总金额显示
    
    UILabel *showOne;      //
    UILabel *showTwo;
    
    
}@end
@implementation SDCircleView



-(instancetype)initWithFrame:(CGRect)frame offset:(CGFloat)offset numberArray:(NSArray*)numberArr colorArray:(NSArray*)colorArr{
    
    if (self = [super initWithFrame:frame]) {
        numberArray = [NSArray arrayWithArray:numberArr];
        colorArray = [NSArray arrayWithArray:colorArr];
        offsetF = offset;
        baseLayer = [CALayer layer];
        baseLayer.backgroundColor = [UIColor grayColor].CGColor;
        baseLayer.frame = self.bounds;
        [self.layer addSublayer:baseLayer];;
        space = 15;
        
        //创建圆
        [self createCircleLayer];
        
        //创建圆心文字
        [self createCircleInView];
        
        //创建左侧文字view
        [self createTextShowView];
        
    }
    return self;
}


-(void)createCircleLayer{
    
    //初始圆饼的动画位置 大概12点钟位置
    startAngle = 0;
    endAngle = M_PI*3/2;
    
    //初始圆心
    centerCircle = CGPointMake(self.bounds.size.width/4+space,self.bounds.size.height/2);
    circleRadius = self.frame.size.width/4 - space;
    tempAngle = 0;
    
    //顺时针or逆时针
    isclockWisk = YES;
    
    //获取总sum
    CGFloat sum = [self getAllDataSum:numberArray];
    
    for (int i = 0; i<numberArray.count; i++) {
        
        //这里是让上一个圆环的 结束夹角 成为 下一个圆环的 起始夹角
        startAngle = endAngle;
        tempAngle = [self getPresentWithCurrent:[numberArray[i] floatValue] totalValue:sum];
        endAngle = startAngle+tempAngle;
        
        //初始化
        circleLayer = [CAShapeLayer layer];
        
        
        //调整第一块 饼的 位置
        if (i == 0) {
            //center 往外围移动一点 使用cosf跟sinf函数计算
            centerCircle = CGPointMake(centerCircle.x + cosf((startAngle + endAngle) / 2) * offsetF, centerCircle.y + sinf((startAngle + endAngle) / 2) * offsetF);
            
        }else{
            centerCircle = CGPointMake(self.bounds.size.width/4+space,self.bounds.size.height/2);
        }
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerCircle radius:circleRadius startAngle:startAngle endAngle:endAngle clockwise:isclockWisk];
        circleLayer.path = path.CGPath;
        circleLayer.strokeColor = [colorArray[i] CGColor];
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.lineWidth = circleRadius/2;
        circleLayer.strokeStart = 0.0f;
        circleLayer.strokeEnd = 1.0f;
        [baseLayer addSublayer:circleLayer];
        [self animationShow];
    }
    
}

//获取所有数据总和sum
-(CGFloat)getAllDataSum:(NSArray*)numberArr{
    CGFloat sum = 0 ;
    for (NSString *c in numberArr) {
        CGFloat cf = [c floatValue];
        sum += cf;
    }
    return sum;
}

//获取每个数据对应的endAngle
-(CGFloat)getPresentWithCurrent:(CGFloat)value totalValue:(CGFloat)totalValue{
   CGFloat presetn =  value/totalValue;
    return presetn*M_PI*2;
    
}

//动画执行
-(void)animationShow{
    CABasicAnimation *aimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    aimation.duration = 1.0f;
    aimation.fromValue = @(0.0f);
    aimation.toValue = @(1.0f);;
    aimation.autoreverses = NO;
    [circleLayer addAnimation:aimation forKey:@"strokeEnd"];
    
}

-(void)createCircleInView{
    
    CGFloat centerX = centerCircle.x;
    CGFloat centerY = centerCircle.y;
    CGFloat WH = circleRadius*2;
    
    bGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WH, WH)];
    bGView.center = CGPointMake(centerX, centerY);
    [self addSubview:bGView];
    
    //titleOne
    titleOne = [[UILabel alloc] init];
    titleOne.textAlignment = NSTextAlignmentCenter;
    titleOne.textColor = [UIColor blackColor];
    [bGView addSubview:titleOne];
    
    
    
    
}


-(void)createTextShowView{
    CGFloat x = self.bounds.size.width/2 + space*2;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width/2 - space;
    CGFloat h = self.bounds.size.height;
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    bgview.backgroundColor = [UIColor blueColor];
    [self addSubview:bgview];
    
    NSString *kindlabStr = @"类型";
    UILabel *kindLab = [[UILabel alloc] initWithFrame:CGRectMake(0, h/3, w, 10)];
    kindLab.text  = kindlabStr;
    kindLab.textColor = [UIColor blackColor];
    kindLab.font = [UIFont systemFontOfSize:10];
    [bgview addSubview:kindLab];
    
    
    //one
    NSString *textOne = @"现金余额";
    CGSize textsize = [SDCircleView labelAutoCalculateRectWith:textOne Font:[UIFont systemFontOfSize:12] MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    UIView *viewOne = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(kindLab.frame)+space, bgview.frame.size.width-2*space, textsize.height)];
    [bgview addSubview:viewOne];
    
    UIView *colorOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textsize.height, textsize.height)];
    colorOne.backgroundColor = colorArray[0];
    colorOne.layer.cornerRadius = colorOne.frame.size.height/2;
    colorOne.layer.masksToBounds = YES;
    [viewOne addSubview:colorOne];
    
    
    UILabel *labOne = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorOne.frame)+space/2, 0, textsize.width, textsize.height)];
    labOne.textColor = [UIColor blackColor];
    labOne.font = [UIFont systemFontOfSize:12];
    labOne.text = textOne;
    [viewOne addSubview:labOne];
    
    
    showOne = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labOne.frame), 0, bgview.frame.size.width -colorOne.frame.size.width-space-labOne.frame.size.width, textsize.height)];
    showOne.textColor = [UIColor blackColor];
    showOne.font = [UIFont systemFontOfSize:12];
    showOne.textAlignment = NSTextAlignmentRight;
    showOne.text = @"12222222";
    [viewOne addSubview:showOne];
    
    
    //two
    NSString *textTwo = @"消费余额";
    UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(viewOne.frame)+space, bgview.frame.size.width-2*space, textsize.height)];
    [bgview addSubview:viewTwo];
    
    UIView *colorTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textsize.height, textsize.height)];
    colorTwo.backgroundColor = colorArray[1];
    colorTwo.layer.cornerRadius = colorTwo.frame.size.height/2;
    colorTwo.layer.masksToBounds = YES;
    [viewTwo addSubview:colorTwo];
    
    
    UILabel *labTwo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorTwo.frame)+space/2, 0, textsize.width, textsize.height)];
    labTwo.textColor = [UIColor blackColor];
    labTwo.font = [UIFont systemFontOfSize:12];
    labTwo.text = textTwo;
    [viewTwo addSubview:labTwo];
    
    
    showTwo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labTwo.frame), 0, bgview.frame.size.width -colorTwo.frame.size.width-space-labTwo.frame.size.width, textsize.height)];
    showTwo.textColor = [UIColor blackColor];
    showTwo.font = [UIFont systemFontOfSize:12];
    showTwo.textAlignment = NSTextAlignmentRight;
    showTwo.text = @"12222222";
    [viewTwo addSubview:showTwo];
    
    
}


+ (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont*)font MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context: nil ].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
     return  labelSize;
}


-(void)setAllMonenyStr:(NSString *)allMonenyStr{
    _allMonenyStr = allMonenyStr;
    titleOne.text = allMonenyStr;
    
    CGSize size = [SDCircleView labelAutoCalculateRectWith:allMonenyStr Font:[UIFont systemFontOfSize:16] MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat y = (bGView.frame.size.width - size.height)/2;
    titleOne.frame = CGRectMake(0, y, bGView.frame.size.width, size.height);
    
    //再创建tip文字
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleOne.frame), titleOne.frame.size.width, size.height/2)];
    tipLab.textColor = [UIColor lightGrayColor];
    tipLab.font = [UIFont systemFontOfSize:13];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.text = @"总金额";
    [bGView addSubview:tipLab];
    
    
}


@end

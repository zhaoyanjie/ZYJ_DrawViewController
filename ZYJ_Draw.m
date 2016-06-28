//
//  ZYJ_Draw.m
//  BloodSugar
//
//  Created by 赵彦杰 on 16/5/5.
//  Copyright © 2016年 赵彦杰. All rights reserved.
//

#import "ZYJ_Draw.h"
#define POINT_CIRCLE  6.0f
@interface ZYJ_Draw()
{
@private
    NSArray * KLevelDataArray;//横坐标数据
    NSMutableArray *KdrawDataCountArry;
    NSMutableArray *kdrawDataArray;
    float _width;
    float _height;
    NSMutableArray *SeconArry; //计算时间的数据
}
@property(nonatomic)float width;
@property(nonatomic)float height;
@end

@implementation ZYJ_Draw
- (void)drawRect:(CGRect)rect {
    // 获取上下文,进行绘制
    CGContextRef ContextRef = UIGraphicsGetCurrentContext();
    // 开始绘制
    //CGContextBeginPath(ContextRef);
    // 设置画笔
    //CGContextSetLineWidth(ContextRef, 1);
    // 画线端点的样式
    //CGContextSetLineCap(ContextRef, kCGLineCapSquare);
    // 线的颜色 横线
    CGContextSetStrokeColorWithColor(ContextRef, [UIColor lightGrayColor].CGColor);
    for (int i =0 ; i<12; i++) {
        if (i!=0||i!=11) {
             CGContextSetLineWidth(ContextRef, 0.9);
        }

        CGContextMoveToPoint(ContextRef, 0,i*self.frame.size.height/11);
        CGContextAddLineToPoint(ContextRef,self.frame.size.width,(self.frame.size.height/11)*i);
        CGContextStrokePath(ContextRef);
    }
    //NSLog(@"===:%f",self.frame.size.height/11);
    // 设置线的宽度 竖线
    for (int i= 0; i< 7; i++) {
        if (i==0||i==6) {
            CGFloat lengths[] = {1,1};
            CGContextSetLineDash(ContextRef, 0, lengths, 0);
        }
        else
        {
            CGFloat lengths[] = {3,3};
            CGContextSetLineDash(ContextRef, 0, lengths, 2);
        }
        
        CGContextMoveToPoint(ContextRef, i*self.frame.size.width/6, self.frame.size.height);
        CGContextAddLineToPoint(ContextRef, i*self.frame.size.width/6,0);
        CGContextStrokePath(ContextRef);
    }
    // 水平坐标的数据
    for (int i = 0 ; i<KLevelDataArray.count; i++) {
        float x=self.bounds.size.width/(KLevelDataArray.count-1);
        UILabel * LevelLabel= [[UILabel alloc]initWithFrame:CGRectMake(i*x-20, self.bounds.size.height+5, 40, 10)];
        LevelLabel.textAlignment=NSTextAlignmentCenter;
        LevelLabel.text = KLevelDataArray[i];
        //LevelLabel.backgroundColor=[UIColor redColor];
        LevelLabel.textColor = UIColorFromRGB(0x333333);
        LevelLabel.font = [UIFont systemFontOfSize:12];
        [ self addSubview:LevelLabel];
    }
    /**
     *  self.datatimeArray=[NSMutableArray arrayWithObjects:@"06:30", @"09:20",@"11.20",@"13.00",@"14:00",@"19:45",nil];
     */
    //把测量时间转化为分钟
    SeconArry=[[NSMutableArray alloc]init];
    for (NSString *strtime in kdrawDataArray) {
        NSArray *time=[strtime componentsSeparatedByString:@":"];
        int timeSecond=[time[0] intValue]*60+[time[1] intValue];
        NSLog(@"%@",time);
        NSLog(@"%d",timeSecond);
        [SeconArry addObject:[NSString stringWithFormat:@"%d",timeSecond]];
    }
    float star=self.frame.size.height/11;
    //画折线
    CGContextSetStrokeColorWithColor(ContextRef, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ContextRef, 0.6f);
    NSLog(@"%@",KdrawDataCountArry);
    //CGContextMoveToPoint(ContextRef, 20, 200);
    for (NSInteger i=0; i<KdrawDataCountArry.count; i++) {
        CGContextSetLineDash(ContextRef, 0, 0, 0);
        NSString *strtime=SeconArry[i];
        int  j=[strtime intValue];
        float width=j*self.frame.size.width/6/4/60+1.5;
        NSString *str=KdrawDataCountArry[i];
        float count=[str floatValue];
        
        if (count>=4.0&&count<=9.0) {
            float height=self.frame.size.height-star-2*star-(count-4)*star;
            self.height=height;
        }
        else if (count<4)
        {
            float height=self.frame.size.height-star-count*star/2;
            self.height=height;
        }
        else if(count>9.0&&count<=11.0)
        {
            float height=self.frame.size.height-star-7*star-(count-9)*star/2;
            self.height=height;
            
            
        }
        else if (count>11.0&&count<15.0)
        {
            float height=self.frame.size.height-star-8*star-(count-11.0)*star/4;
            self.height=height;
        }
        else
        {
            float height=self.frame.size.height-star-9*star-(count-15.0)*star/18;
            self.height=height;
        }
        //开始画线
        if (i==0) {
            CGContextMoveToPoint(ContextRef, width, self.height);
        }
        else
        {
            CGContextAddLineToPoint(ContextRef, width, self.height);
        }
        
    }
    CGContextStrokePath(ContextRef);
    
    // 进行绘图 画点
    
    for (NSInteger i=0; i<KdrawDataCountArry.count; i++) {
        NSString *strtime=SeconArry[i];
        int  j=[strtime intValue];
        float width=j*self.frame.size.width/6/4/60-1.5;
        NSString *str=KdrawDataCountArry[i];
        float count=[str floatValue];
        if (count>=4.0&&count<=9.0) {
            float height=self.frame.size.height-star-2*star-(count-4)*star-3;
            self.height=height;
            CGContextSetFillColor(ContextRef,  CGColorGetComponents(UIColorFromRGB(0x24b3fa).CGColor));
            
        }
        else if (count>9.0&&count<=11.0)
        {
            float height=self.frame.size.height-star-7*star-(count-9)*star/2;
            self.height=height;
            CGContextSetFillColor(ContextRef,  CGColorGetComponents([UIColor redColor].CGColor));
            
        }
        else if (count>11.0&&count<=15.0)
        {
            float height=self.frame.size.height-star-8*star-(count-11.0)*star/4;
            self.height=height;
            CGContextSetFillColor(ContextRef,  CGColorGetComponents([UIColor redColor].CGColor));
        }
        else if (count>15.0&&count<=33.0)
        {
            float height=self.frame.size.height-star-9*star-(count-15.0)*star/18;
            self.height=height;
            CGContextSetFillColor(ContextRef,  CGColorGetComponents([UIColor redColor].CGColor));
        }
        else
        {
            float height=self.frame.size.height-star-count*star/2;
            self.height=height;
            CGContextSetFillColor(ContextRef,  CGColorGetComponents([UIColor redColor].CGColor));
        }
        
        
       
        CGContextFillEllipseInRect(ContextRef, CGRectMake(width, self.height, 6.0, 6.0));
        
    }
    
    switch ((int)self.LineType) {
        case PointType:{
            // 点
        }
            break;
        case BezierType:{
            // 贝塞尔
        }
            break;
        case BrokenType:{
            // 折线
        }
            break;
        default:
            break;
    }
    
}
-(void)setData:(NSMutableArray*)LevelDataArray{
    KLevelDataArray = LevelDataArray;
    NSLog(@"我的数据：%@",LevelDataArray);
}
-(void)drawDatacount:(NSMutableArray *)drawDataCountArry
{
    KdrawDataCountArry=drawDataCountArry;
    NSLog(@"%@",drawDataCountArry);
}
-(void)drawData:(NSMutableArray *)drawDataArray
{
    kdrawDataArray=drawDataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

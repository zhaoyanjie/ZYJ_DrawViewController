//
//  ZYJ_Draw.h
//  BloodSugar
//
//  Created by 赵彦杰 on 16/5/5.
//  Copyright © 2016年 赵彦杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum DrowLineType{
    PointType = 0,
    BrokenType ,
    BezierType,
}DrowLineType;
@interface ZYJ_Draw : UIView
// 数据
-(void)setData:(NSMutableArray*)LevelDataArray;
// 获取绘制类型
@property(assign,nonatomic) DrowLineType * LineType;
//点数据的日期
-(void)drawData:(NSMutableArray *)drawDataArray;
//画点的数据
-(void)drawDatacount:(NSMutableArray *)drawDataCountArry;

@end

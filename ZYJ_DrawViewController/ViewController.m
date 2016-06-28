//
//  ViewController.m
//  ZYJ_DrawViewController
//
//  Created by 赵彦杰 on 16/6/24.
//  Copyright © 2016年 光巨力. All rights reserved.
//

#import "ViewController.h"
#import "ZYJ_Draw.h"
#import "Masonry.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()
@property(nonatomic,strong)NSArray *VerticalDataArray;
@property(nonatomic,strong)NSMutableArray *LevelDataArray;
@property(nonatomic,strong)NSMutableArray *arry;
@property(nonatomic,strong)NSMutableArray *datatimeArray;
@property(nonatomic,strong)NSMutableArray *timeAry;//测量时间
@property(nonatomic,strong)NSMutableArray * sugarArycount;//测量时间对应的血糖数据


@property(nonatomic,strong)ZYJ_Draw *zyj_draw;
@property(nonatomic,copy)NSString *timeStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createDrawData];

}
-(void)createDrawData
{
    // 初始化数据（竖直）
    self.VerticalDataArray = @[@"1.1",@"2.5",@"4.0",@"5.0",@"6.0",@"7.0",@"8.0",@"9.0",@"11.0",@"15.0",@"33.3"];
     self.LevelDataArray =[NSMutableArray arrayWithObjects:@"00:00",@"04:00",@"08:00",@"12:00",@"16:00",@"20:00",@"24:00", nil];
    self.sugarArycount=[NSMutableArray arrayWithObjects:@"9.8",@"11.2",@"5.8", nil];
    self.timeAry=[NSMutableArray arrayWithObjects:@"08:23",@"12:00",@"14:15", nil];
    //画图的背景
    UIView *drwaBG=[[UIView alloc]init];
    drwaBG.backgroundColor=[UIColor whiteColor];
    drwaBG.layer.masksToBounds=YES;
    drwaBG.layer.borderWidth=0.5;
    drwaBG.layer.cornerRadius=10;
    drwaBG.layer.borderColor=UIColorFromRGB(0x666666).CGColor;
    [self.view addSubview:drwaBG];
    [drwaBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@( 355));
        make.height.equalTo(@(490));
    }];
    UILabel *titleLable=[[UILabel alloc]init];
    titleLable.text=@"全天血糖";
    titleLable.textColor=UIColorFromRGB(0x23b2fa);
    titleLable.font=[UIFont systemFontOfSize:18];
    [drwaBG addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(drwaBG).offset(20);
        make.left.equalTo(drwaBG).offset(30);
        make.width.equalTo(@(100));
        make.height.equalTo(@(20));
    }];

    //画竖直的坐标
    for (int i =(int)self.VerticalDataArray.count -1 ; i>=0; i--) {
        UILabel * VerticalDataArrayLabel = [[UILabel alloc]init];
        [drwaBG addSubview:VerticalDataArrayLabel];
        
        float y=i*(430/(self.VerticalDataArray.count+1));
        VerticalDataArrayLabel.textAlignment=NSTextAlignmentCenter;
        [VerticalDataArrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLable.mas_bottom).offset((20+y));
            make.left.equalTo(drwaBG).offset(0);
            make.height.equalTo(@(10));
            make.width.equalTo(@(30));
        }];
        VerticalDataArrayLabel.font = [UIFont systemFontOfSize:12];
        VerticalDataArrayLabel.text = self.VerticalDataArray[self.VerticalDataArray.count-i-1];
        
    }
    //画图
    self.zyj_draw=[[ZYJ_Draw alloc]init];
    [drwaBG addSubview:self.zyj_draw];
    self.zyj_draw.backgroundColor=[UIColor whiteColor];
    [self.zyj_draw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(20);
        make.left.equalTo(drwaBG).offset(30);
        make.width.equalTo(@(307));
        make.height.equalTo(@(390));
        make.right.equalTo(drwaBG.mas_right).offset(-20);
    }];
    
    self.zyj_draw.LineType=PointType;
    [self.zyj_draw setData:self.LevelDataArray];
    [self.zyj_draw drawDatacount:self.sugarArycount];
    [self.zyj_draw drawData:self.timeAry];
    [self.zyj_draw setNeedsDisplay];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

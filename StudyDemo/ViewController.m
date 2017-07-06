//
//  ViewController.m
//  StudyDemo
//
//  Created by pengjiaxin on 2017/7/4.
//  Copyright © 2017年 pengjiaxin. All rights reserved.
//

#import "ViewController.h"
#import "AppListModel.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *appListArray;
@end

@implementation ViewController

//懒加载

-(NSMutableArray *)appListArray{
    if (!_appListArray) {
        
//        _appListArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"]];
        
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"]];
        self.appListArray = [NSMutableArray array];
        
        //遍历数组,将数组中的字典依次转化成模型,添加到数组中
        for (NSDictionary *item in array) {
            AppListModel *model = [[AppListModel alloc]init];
            model.name = item[@"name"];
            model.icon = item[@"icon"];
            //**代码优化
//
            //initWithDict
//            AppListModel *model = [[AppListModel alloc]initWithDict:item];
            [_appListArray addObject:model];
        }
    }
    return _appListArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //总列数
    int totalCount = 3;
    
    CGFloat viewW = 80;
    CGFloat viewH = 90;
    
    CGFloat marginX = (self.view.bounds.size.width - totalCount*viewW)/(totalCount + 1);
    CGFloat marginY= 10;
    CGFloat startY = 20;
    
    for (int i = 0; i<self.appListArray.count; i++) {
        //行数
        int row = i / totalCount;
        //列数
        int col = i % totalCount;
        
        CGFloat x = marginX +(viewW +marginX)*col;
        CGFloat y = startY + marginY +(viewH +marginY)*row;
        
        UIView *appView = [[UIView alloc]initWithFrame:CGRectMake(x, y, viewW, viewH)];
        [self.view addSubview:appView];
        
        //读取数组中的model
        AppListModel *model = self.appListArray[i];
        
        //UIImageView
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, 50)];
//        imageView.image = [UIImage imageNamed:[self.appListArray[i] valueForKey:@"icon"]];
        
        
        imageView.image = [UIImage imageNamed:model.icon];
        //按照比例显示图片
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [appView addSubview:imageView];
        
        //UILabel
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bounds.size.height, viewW, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:12];
        [appView addSubview:label];
        
        //UIButton
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 70, viewW-40, 20);
        [button setTitle:@"下载" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
         [button setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        [appView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttonAction:(UIButton *)button{
    //实例化一个UILabel,提示用户下载完成
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 160)/2.0, 400, 160, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
//    label.text = [NSString stringWithFormat:@"下载%@完成",[self.appListArray[button.tag] valueForKey:@"name"]];
    AppListModel *model = self.appListArray[button.tag];
    label.text = [NSString stringWithFormat:@"下载%@完成",model.name];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.0;
    
    
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

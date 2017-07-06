//
//  appListModel.h
//  StudyDemo
//
//  Created by pengjiaxin on 2017/7/5.
//  Copyright © 2017年 pengjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
//字典转模型
@interface AppListModel : NSObject
//应用程序名称
@property (nonatomic, copy) NSString *name;
//应用程序图标名称
@property (nonatomic, copy) NSString *icon;

-(id)initWithDict:(NSDictionary *)dict;

@end

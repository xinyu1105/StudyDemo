//
//  appListModel.m
//  StudyDemo
//
//  Created by pengjiaxin on 2017/7/5.
//  Copyright © 2017年 pengjiaxin. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}
@end

//
//  OCHelper.m
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

#import "OCHelper.h"

@implementation OCHelper

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end

//
//  LaunchCommand.m
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//

#import "LaunchCommand.h"
#import "NSString+File.h"

@implementation LaunchCommand

- (void)execute:(NSError **)error
{
    NSString *appPath =  [self.arguments[1] expandPath];
    [self.sim launch:appPath args:@[] error:error];
}

@end

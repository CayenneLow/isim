//
//  LaunchSafariCommand.m
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//

#import "LaunchSafariCommand.h"

@implementation LaunchSafariCommand

- (void)execute:(NSError **)error
{
    NSString *appPath = [@[ [self.sim.sdkRoot sdkRootPath], @"Applications", @"MobileSafari.app"] componentsJoinedByString : @"/"];
    NSString *url = @"";
    if (self.arguments.count > 2 && self.arguments[2] != nil) {
        url     =  self.arguments[2];
    }
    [self.sim launch:appPath args:@[@"-u", url] error:error];
}

@end

//
//  iPhoneSimulator.h
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "iPhoneSimulatorRemoteClient.h"

@interface iPhoneSimulator : NSObject <DTiPhoneSimulatorSessionDelegate>

@property (strong, nonatomic) DTiPhoneSimulatorSystemRoot *sdkRoot;

- (int)start:(NSArray *)arguments;
- (void)launch:(NSString *)appPath args:(NSArray *)args error:(NSError **)error;

@end

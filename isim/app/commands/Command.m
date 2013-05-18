//
//  SafariOpenCommand.m
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//

#import "Command.h"
@implementation Command

- (id)initWithSimulator:(iPhoneSimulator *)sim arguments:(NSArray *)arguments
{
    self = [super init];
    if (self) {
        _sim = sim;
        _arguments = arguments;
    }
    return self;
}

- (void)setup {}

- (void)execute:(NSError **)error {}

@end
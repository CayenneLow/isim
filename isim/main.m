//
//  main.m
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iPhoneSimulator.h"

int main(int argc, const char *argv[])
{
    @autoreleasepool {
        iPhoneSimulator *sim = [iPhoneSimulator new];
        [sim start:[[NSProcessInfo processInfo] arguments]];
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}

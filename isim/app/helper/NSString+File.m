//
//  NSString+File.m
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

- (NSString *)expandPath
{
    if ([self isAbsolutePath]) {
        return [self stringByStandardizingPath];
    } else {
        NSString *cwd = [[NSFileManager defaultManager] currentDirectoryPath];
        
        return [[cwd stringByAppendingPathComponent:self] stringByStandardizingPath];
    }
}


@end

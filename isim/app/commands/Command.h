//
//  Command.h
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iPhoneSimulator.h"

@protocol CommandDelegate <NSObject>
@end

@interface Command : NSObject <CommandDelegate>

@property (weak, nonatomic, readonly) iPhoneSimulator *sim;
@property (strong, nonatomic, readonly) NSArray *arguments;

- (id)initWithSimulator:(iPhoneSimulator *)sim arguments:(NSArray *)arguments;

- (void)execute:(NSError **)error;

@end
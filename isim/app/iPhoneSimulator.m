//
//  iPhoneSimulator.m
//  isim
//
//  Created by Seiji on 5/18/13.
//  Copyright (c) 2013 Seiji Toyama. All rights reserved.
//
#import "iPhoneSimulator.h"
#import "Command.h"

#define ERROR_DOMAIN @"isim"

@implementation iPhoneSimulator

+ (NSError *)errorWithErrorCode:(NSInteger)code localizedDescription:(NSString *)localizedDescription
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:localizedDescription forKey:NSLocalizedDescriptionKey];
    NSError      *error    = [NSError errorWithDomain:ERROR_DOMAIN code:code userInfo:userInfo];
    
    return error;
}

- (void)showUsage
{
    NSString *s = @"Usage\n"
    "- isim <app_path>\n"
    "- isim safari <url>\n";
    NSLog(@"%@", s);
}

- (int)start:(NSArray *)arguments
{
    NSError *error;
    
    Command *command = [self createCommand:arguments error:&error];
    if (error != nil) {
        NSLog(@"error: %@", error);
        
        exit(EXIT_FAILURE);
    }
    
    [command execute:&error];
    if (error != nil) {
        NSLog(@"error: %@", error);
        
        exit(EXIT_FAILURE);
    }
    
    return EXIT_SUCCESS;
}

- (Command *)createCommand:(NSArray *)arguments error:(NSError **)error
{
    if (arguments.count < 2) {
        *error = [[self class] errorWithErrorCode:0 localizedDescription:@"u need command"];
        [self showUsage];
        
        return nil;
    }
    
    NSString *appPath = arguments[1];
    if (appPath == nil) {
        *error = [[self class] errorWithErrorCode:0 localizedDescription:@"u need appPath"];
        
        return nil;
    }
    
    DTiPhoneSimulatorSystemRoot *sdkRoot = [DTiPhoneSimulatorSystemRoot defaultRoot];
    self.sdkRoot = sdkRoot;
    
    Class cls = NSClassFromString(@"LaunchCommand");
    if ([appPath caseInsensitiveCompare:@"safari"] == NSOrderedSame) {
        cls = NSClassFromString(@"LaunchSafariCommand");
    }
    
    Command *command = nil;
    if (cls != nil) {
        command = [[cls alloc] initWithSimulator:self arguments:arguments];
    } else {
        *error = [[self class] errorWithErrorCode:0 localizedDescription:@"unavailable command"];
        
        return nil;
    }
    
    return command;
}

- (void)launch:(NSString *)appPath args:(NSArray *)args error:(NSError **)error
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager fileExistsAtPath:appPath]) {
        *error = [[self class] errorWithErrorCode:0 localizedDescription:[NSString stringWithFormat:@"pplication path %@ doesn't exist", appPath]];
        
        return;
    }
    
    DTiPhoneSimulatorApplicationSpecifier *appSpec;
    DTiPhoneSimulatorSessionConfig        *config;
    DTiPhoneSimulatorSession              *session;
    
    appSpec = [DTiPhoneSimulatorApplicationSpecifier specifierWithApplicationPath:appPath];
    
    config = [[DTiPhoneSimulatorSessionConfig alloc] init];
    [config setApplicationToSimulateOnStart:appSpec];
    [config setSimulatedSystemRoot:self.sdkRoot];
    [config setSimulatedApplicationShouldWaitForDebugger:NO];
    [config setSimulatedApplicationLaunchArgs:args];
    [config setSimulatedApplicationLaunchEnvironment:nil];
    [config setLocalizedClientName:@"isim"];
    
    if ([config respondsToSelector:@selector(setSimulatedDeviceFamily:)]) {
        [config setSimulatedDeviceFamily:[NSNumber numberWithInt:1]]; // iPhone
    }
    session = [[DTiPhoneSimulatorSession alloc] init];
    [session setDelegate:self];
    
    if (![session requestStartWithConfig:config timeout:30 error:error]) {
        NSLog(@"Could not start simulator session");
        
        return;
    }
}

#pragma mark - DTiPhoneSimulatorSessionDelegate
- (void)session:(DTiPhoneSimulatorSession *)session didStart:(BOOL)started withError:(NSError *)error
{
    if (started) {
        exit(EXIT_SUCCESS);
    } else {
        NSLog(@"Session could not be started: %@", error);
        exit(EXIT_FAILURE);
    }
}

- (void)session:(DTiPhoneSimulatorSession *)session didEndWithError:(NSError *)error
{
    NSLog(@"Session did end with error %@", error);
    if (error != nil) {
        exit(EXIT_FAILURE);
    }
    exit(EXIT_SUCCESS);
}

- (void)sessionWillEnd:(id)arg1
{
}

@end

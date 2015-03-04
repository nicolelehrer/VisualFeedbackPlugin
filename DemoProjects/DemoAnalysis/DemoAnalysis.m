//
//  DemoAnalysis.m
//  DemoAnalysis
//
//  Created by Loren Olson on 11/2/11.
//  Copyright 2011 AME. All rights reserved.
//
//  This class implements a general purpose, non-descript Dash plugin named DemoAnalysis.

#import "DemoAnalysis.h"
#import "Log.h"
#import "DAAnalyzer.h"
#import "DAController.h"



static DemoAnalysis * gDemoAnalysis = nil;


@interface DemoAnalysis(private)

- (void)analysisLoop;

@end



@implementation DemoAnalysis



@synthesize analyzer = _analyzer;
@synthesize controller = _controller;



#pragma mark ---- class methods ----


+ (DemoAnalysis *)sharedDemoAnalysis
{
    static dispatch_once_t onceQueue;    
    
    dispatch_once(&onceQueue, ^{
        gDemoAnalysis = [[super allocWithZone:NULL] init];
    });
    
    return gDemoAnalysis;
}


// This class method is called one time, after the plugin bundle is loaded by Dash.
// Dash loads plugins as the last step of its startup procedure. It will look thru a 
// user configurable list of folder paths, and load any bundles that implement the 
// DashPluginProtocol.
+ (BOOL)initializePlugin:(NSBundle *)bundle
{
	logInfo( @"initializePlugin DemoAnalysis" );
	[DemoAnalysis sharedDemoAnalysis];
	return YES;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceQueue;    
    
    dispatch_once(&onceQueue, ^{
        gDemoAnalysis = [super allocWithZone:zone];
    });
    
    return gDemoAnalysis;
}



#pragma mark ---- initializers  ----

//
// designated initializer
// If you have any instance variables you want to initialze, or anything you want done when an instance is created,
// you put that here.
//
- (id)init
{
    static int count = 0;
    @synchronized(self) {
        if (count == 0) {
            count++;
            self = [super init];
            if (self) {
                self.analyzer = [[DAAnalyzer alloc] init];
                self.controller = [[DAController alloc] init];
                self.controller.analysis = self.analyzer;
            }
        }
    }
	
    return self;
}









#pragma mark ---- NSObject  ----


- (NSString *)description
{
    return( [NSString stringWithFormat:@"DemoAnalysis" ] );
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


//
// if you alloc any objects, you should release them here
//
- (void)dealloc
{
	[super dealloc];
}




@end

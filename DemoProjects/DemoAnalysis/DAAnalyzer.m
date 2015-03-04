//
//  DAAnalyzer.m
//  DemoAnalysis
//
//  Created by Loren Olson on 11/22/11.
//  Copyright (c) 2011 AME. All rights reserved.
//

#import "DAAnalyzer.h"
#import "DashHeaders.h"
#import "PlugController.h"
#import "DAAnalysisFrame.h"
#import "Log.h"
#import "math.h"

@implementation DAAnalyzer


@synthesize currentFrame = _currentFrame;
@synthesize active = _active;
@synthesize fluxScale = _fluxScale;


#pragma mark ---- instance methods  ----


- (id)init
{
    self = [super init];
    if (self) {
        self.currentFrame = [[DAAnalysisFrame alloc] init];
        self.currentFrame.fluxCapacity = 1.0;
        waitTimeInMicroseconds = 1000 * 100;
        tick = 0.0;
        self.active = YES;
        self.fluxScale = 1.0;
        
        [NSThread detachNewThreadSelector: @selector(analysisLoop) toTarget:self withObject:nil];
        [[PlugController plugController] addObject:self.currentFrame name:@"DemoAnalysisFrame" attribute:@"fluxCapacity"];
    }
    return self;
}

- (void)analysisLoop
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	logInfo( @"analysisLoop" );
	
	float tickIncrement = 1000000.0 / waitTimeInMicroseconds;
	
    while (1) {
		
        if (self.active) {
            float fluxCapacity = sinf(tick * DTOR) * self.fluxScale;
            self.currentFrame.fluxCapacity = fluxCapacity;
            tick += tickIncrement;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DemoAnalysisNewFrame" object:self.currentFrame];
        }
		
		
		usleep(waitTimeInMicroseconds);
	}
	
	[pool release];
}

- (void)demoAnalyisActive:(BOOL)status
{
    self.active = status;
}


- (void)demoAnalyisSensitivity:(float)value
{
    self.fluxScale = value;
}


@end

//
//  ScenarioTransitionController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScenarioTransitionController.h"

@implementation ScenarioTransitionController

@synthesize opacityTransitionAnimation = _opacityTransitionAnimation;
@synthesize opacity = _opacity;
@synthesize durationInSeconds = _durationInSeconds;
@synthesize startValue = _startValue;
@synthesize endValue = _endValue;


- (id)initWithStartValue:(float)startValueInput andEndValue:(float)endValueInput andDurationInSec:(float)durationInput
{
	self = [super init];
    
    if (self != nil) {
        
        self.opacity = 0.0;
        self.startValue = startValueInput;
        self.endValue = endValueInput;
        self.durationInSeconds = durationInput;
        
        self.opacityTransitionAnimation = [[DAnimateFloat alloc] initWithObject:self path:@"opacity" from:self.startValue to:self.endValue duration:self.durationInSeconds];
		self.opacityTransitionAnimation.mode = DANIMATE_INTERP_LINEAR;
    }
	return self;
}


- (id) init
{
	return [self initWithStartValue:0 andEndValue:1 andDurationInSec:1];
}



- (float) calcOpacity 
{
    if(self.opacity == self.startValue)
    { 
        [self.opacityTransitionAnimation resetFrom:self.opacity to:self.endValue duration:self.durationInSeconds];
        [DAnimation animate:self.opacityTransitionAnimation];	
    } 
    
    return self.opacity;
}


-(void) resetOpacity
{
    [self.opacityTransitionAnimation resetFrom:self.opacity to:self.startValue duration:self.durationInSeconds];
    [DAnimation animate:self.opacityTransitionAnimation];	
}


- (void) dealloc
{
    [super dealloc];
    [self.opacityTransitionAnimation release];
    
}


@end

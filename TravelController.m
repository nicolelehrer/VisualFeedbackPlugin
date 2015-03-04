//
//  TravelController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TravelController.h"


@implementation TravelController

@synthesize travelTimeAnimation =_travelTimeAnimation;
@synthesize displacement = _displacement;
@synthesize durationInSeconds = _durationInSeconds;
@synthesize startValue = _startValue;
@synthesize endValue = _endValue;
@synthesize realTimeSpeed = _realTimeSpeed;
@synthesize travelDidStart = _travelDidStart;
@synthesize travelDidFinish = _travelDidFinish;
@synthesize stopDisplacement = _stopDisplacement;

- (id)initWithStartValue:(float)startValueInput andEndValue:(float)endValueInput andDurationInSec:(float)durationInput
{
	self = [super init];
    
    if (self != nil) {
		        
        self.realTimeSpeed = 1.0;
        self.displacement = 0.0;
        self.startValue = startValueInput;
        self.endValue = endValueInput;
        self.durationInSeconds = durationInput;
        
        self.travelDidFinish = NO;
        self.travelDidStart = NO;
        
        self.travelTimeAnimation = [[DAnimateFloat alloc] initWithObject:self path:@"displacement" from:self.startValue to:self.endValue duration:self.durationInSeconds];
		self.travelTimeAnimation.mode = DANIMATE_INTERP_EASE_IN;
    }
	return self;
}


- (id) init
{
	return [self initWithStartValue:0 andEndValue:1 andDurationInSec:1];
}


- (float) calcDisplacement 
{
    if (self.stopDisplacement) {
        self.displacement = 0.0;
    }
    
    else {
        
        if(self.displacement == self.startValue)
        { 
            self.travelDidStart = YES;
            self.travelDidFinish = NO;
            [self.travelTimeAnimation resetFrom:self.displacement to:self.endValue duration:self.durationInSeconds];
            [DAnimation animate:self.travelTimeAnimation];	
        } 
        
        
        if (self.travelDidStart && self.displacement == self.endValue) {
            self.travelDidFinish = YES;
            self.travelDidStart = NO;
        }
    }
    
    return self.displacement*self.realTimeSpeed;
}


-(float) resetDisplacementFast
{
    [self.travelTimeAnimation resetFrom:self.displacement to:self.startValue duration:.1];
    [DAnimation animate:self.travelTimeAnimation];	
    
    self.travelDidFinish = NO;
    self.travelDidStart = NO;
    
    return self.displacement;


}


- (void) dealloc
{
    [super dealloc];
    [self.travelTimeAnimation release];
    
}

@end

//
//  TravelController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"

@interface TravelController : NSObject

- (id)initWithStartValue:(float)startValueInput andEndValue:(float)endValueInput andDurationInSec:(float)durationInput;
- (float) calcDisplacement; 
- (float) resetDisplacementFast;

@property(retain) DAnimateFloat * travelTimeAnimation;
@property(assign) float displacement;
@property(assign) float durationInSeconds;
@property(assign) float startValue;
@property(assign) float endValue;
@property(assign) float realTimeSpeed;
@property(assign) BOOL stopDisplacement;

@property(assign) BOOL travelDidStart;
@property(assign) BOOL travelDidFinish;

@end


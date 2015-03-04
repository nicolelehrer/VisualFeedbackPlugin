//
//  ScenarioTransitionController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"

@interface ScenarioTransitionController : NSObject

- (id)initWithStartValue:(float)startValueInput andEndValue:(float)endValueInput andDurationInSec:(float)durationInput;
- (float) calcOpacity; 
- (void) resetOpacity;

@property(retain) DAnimateFloat * opacityTransitionAnimation;
@property(assign) float opacity;
@property(assign) float durationInSeconds;
@property(assign) float startValue;
@property(assign) float endValue;

@end
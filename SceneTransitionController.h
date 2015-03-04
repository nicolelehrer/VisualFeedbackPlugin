//
//  SceneTransitionController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"

@interface SceneTransitionController : NSObject

- (id)initWithStartValue:(float)startValueInput andEndValue:(float)endValueInput andDurationInSec:(float)durationInput;
- (float) boolAnimateOpacityForScene;
- (void) shutDownAnimation;

@property(assign) BOOL gTriggerLevelDisplay;
 
@property(assign) float durationInSeconds;
@property(assign) float startValue;
@property(assign) float endValue;

@property(assign) int previousSceneID;
@property(assign) int currentSceneID;
@property(assign) int nextSceneID;
@property(assign) BOOL sceneDidChange;

@property(assign) BOOL fadeDownDidStart;
@property(assign) BOOL fadeDownDidFinish;
@property(assign) BOOL fadeUpDidStart;
@property(assign) BOOL fadeUpDidFinish;

@property(assign) BOOL shouldDrawScene;

@property(assign) BOOL resetAnimationValues;

@property(assign) float sceneOpacity;
@property(assign) float delayTimer;

@property(retain) DAnimateFloat * sceneOpacityAnimation;
@property(retain) DAnimateFloat * delayTimerAnimation;

@property(assign) float delayDurationInSeconds;
@property(assign) BOOL delayDidFinish;
@property(assign) BOOL delayDidStart;

@property(assign) BOOL fadeDownReadyToStart;

@property(retain) DTime * timekeeper;
@property(assign) float timedOutInSeconds;
@property(assign) BOOL useTimeOut;

@property(assign) BOOL oneTimeResetAfterFadeDown;

@property(assign) int prevState;

@property(assign) int currentState;
@property(assign) int nextState;
@property(assign) BOOL levelTurnedOff;
@property(assign) BOOL previousState;




 
@end
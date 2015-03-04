//
//  SceneTransitionController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneTransitionController.h"

@implementation SceneTransitionController

@synthesize prevState;

@synthesize gTriggerLevelDisplay = _gTriggerLevelDisplay;
@synthesize delayDidFinish = _delayDidFinish;
@synthesize delayDidStart = _delayDidStart;
@synthesize durationInSeconds = _durationInSeconds;
@synthesize startValue = _startValue;
@synthesize endValue = _endValue;

@synthesize currentSceneID = _currentSceneID;
@synthesize nextSceneID = _nextSceneID;
@synthesize sceneDidChange = _sceneDidChange;
@synthesize previousSceneID = _previousSceneID;

@synthesize sceneOpacity = _sceneOpacity;
@synthesize sceneOpacityAnimation = _sceneOpacityAnimation;

@synthesize delayTimerAnimation = _delayTimerAnimation;
@synthesize delayTimer = _delayTimer;
@synthesize delayDurationInSeconds = _delayDurationInSeconds;

@synthesize fadeDownDidStart = _fadeDownDidStart;
@synthesize fadeUpDidStart = _fadeUpDidStart;
@synthesize fadeDownDidFinish = _fadeDownDidFinish;
@synthesize fadeUpDidFinish = _fadeUpDidFinish;

@synthesize fadeDownReadyToStart = _fadeDownReadyToStart;

@synthesize resetAnimationValues = _resetAnimationValues;
@synthesize shouldDrawScene = _shouldDrawScene;

@synthesize timekeeper = _timekeeper;
@synthesize timedOutInSeconds = _timedOutInSeconds;
@synthesize useTimeOut = _useTimeOut;

@synthesize oneTimeResetAfterFadeDown = _oneTimeResetAfterFadeDown;

@synthesize currentState = _currentState;
@synthesize nextState = _nextState;
@synthesize previousState = _previousState;
@synthesize levelTurnedOff = _levelTurnedOff;

- (id)initWithStartValue:(float)startValueInput andEndValue:(float)endValueInput andDurationInSec:(float)durationInput
{
	self = [super init];
    
    if (self != nil) {
        
        [self createTimer];

        self.sceneDidChange = NO;
        self.sceneOpacity = 0.0;
        self.startValue = startValueInput;
        self.endValue = endValueInput;
        self.durationInSeconds = durationInput;
        
        //temp
        self.delayDurationInSeconds = 1.0;
//        self.timedOutInSeconds = 5.0;
        
        self.sceneOpacityAnimation = [[DAnimateFloat alloc] initWithObject:self path:@"sceneOpacity" from:self.startValue to:self.endValue duration:self.durationInSeconds];
//        self.sceneOpacityAnimation.mode = DANIMATE_INTERP_LINEAR;
        self.sceneOpacityAnimation.mode = DANIMATE_INTERP_EASE_OUT;

        self.fadeUpDidStart = NO;
        self.fadeUpDidFinish = NO;
        self.fadeDownDidFinish = NO;
        self.fadeDownDidStart = NO;
        self.useTimeOut = NO;
        self.oneTimeResetAfterFadeDown = NO;
        
    }
	return self;
}


- (id) init
{
	return [self initWithStartValue:0 andEndValue:1 andDurationInSec:1];
}


-(void) createTimer
{
    self.timekeeper = [TimeController timekeeper];			
}


-(float) boolAnimateOpacityForScene
{
    if (self.gTriggerLevelDisplay) {
        
        
        //if trigger gets called during animation or,
        //in the case of drawDemo, while the opacity stays at 1
        //shutDownAnimation is called to bring the opacity back to 0
        [self shutDownAnimation];
        
        self.delayDidStart = YES;
        self.delayDidFinish = NO;
        self.shouldDrawScene = NO;
        
        self.timekeeper.frame = 0;
        [self.timekeeper start: 0];
        self.timekeeper.playbackState = kPlaybackStateForward;
        
        self.gTriggerLevelDisplay = NO;

//        NSLog(@"delay timer did START");
//        NSLog(@"gTriggerLevelDisplay is %@", self.gTriggerLevelDisplay ? @"YES" : @"NO");

    
    }
    
    if (self.delayDidStart && self.timekeeper.frame > self.delayDurationInSeconds*100) {
        
        self.delayDidStart = NO;
        self.delayDidFinish = YES;
    }
    
    if (self.delayDidFinish && self.sceneOpacity == 0) {
        
        self.shouldDrawScene = YES;
        self.fadeUpDidStart = YES;
        
        self.fadeDownDidStart  = NO;
        self.fadeDownDidFinish  = NO;
        self.delayDidFinish = NO;
        
        [self.sceneOpacityAnimation resetFrom:self.sceneOpacity to:self.endValue duration:self.durationInSeconds];
        [DAnimation animate:self.sceneOpacityAnimation ];
        
//        NSLog(@"fade UP did START");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TriggerVisuals" object:nil];
        
        
    }
    
    float totalTimeIncludingDelay = self.timedOutInSeconds+self.delayDurationInSeconds;
    
    //was animation up for at least timedOutInSeconds and fadeDown has not yet started
    if(self.useTimeOut){
        
        if (self.timekeeper.frame > totalTimeIncludingDelay*100 && !self.fadeDownDidStart) {
            
            self.fadeDownReadyToStart = YES;
        }
    }
    
    // fadeDown is ready, reset flags
    if (self.fadeDownReadyToStart) {
        
        self.fadeDownDidStart = YES;
        self.shouldDrawScene = YES;
        
        self.fadeDownReadyToStart = NO;
        self.fadeUpDidStart = NO;
        
        [self.sceneOpacityAnimation  resetFrom:self.sceneOpacity to:self.startValue duration:self.durationInSeconds];
        [DAnimation animate:self.sceneOpacityAnimation ];
        
//        NSLog(@"fade DOWN did START");
    }
    
    //check if animation is finished
    if (self.fadeDownDidStart && self.sceneOpacity == 0 && self.shouldDrawScene) {
        
        self.fadeDownDidFinish = YES;
        self.shouldDrawScene = NO;
        self.oneTimeResetAfterFadeDown = YES;
        
        NSLog(@" fade DOWN did END");
    }
    else {
        self.oneTimeResetAfterFadeDown = NO;
    }
    
    return self.sceneOpacity ;
}

-(void)shutDownAnimation
{
    if (self.sceneOpacity > 0.0) {   
        [self.sceneOpacityAnimation resetFrom:self.sceneOpacity to:0 duration:.05];
        [DAnimation animate:self.sceneOpacityAnimation ];	
//        NSLog(@"Animation shut down");
    }
}


- (void) dealloc
{
    [super dealloc];
    [self.sceneOpacityAnimation release];
}


@end

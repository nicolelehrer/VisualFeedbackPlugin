//
//  DemoDrawer.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "SceneTransitionController.h"
#import "VisualFeedback.h"
#import "TextController.h"
#import "ImageController.h"
#import "SoundController.h"
#import "FeedbackDemo.h"


@interface DemoDrawer : Transform

-(void) setVisualFeedback:(VisualFeedback *) f;
-(void) tangibleConnectionDemo:(ADScenarioData *)adScen;
-(void) tangibleSetup:(NSNotification *) notification;
-(void) markersLostDemo;
-(void) startUpDemo:(NSString*)demo;
-(void) taskDemo:(ADScenarioData*)adScen;
-(void) feedbackDemo:(ADScenarioData*)adScen withSelection:(NSString*)demo;


@property(retain) SceneTransitionController * taskSceneTransitionController;
@property(retain) SceneTransitionController * feedbackSceneTransitionController;
@property(retain) SceneTransitionController * sceneTransitionController;

@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) VFAnalysisFrame * currentFrame;

@property(retain) TextController * taskTextController;
@property(retain) ImageController * taskImageController;
@property(retain) TextController * feedbackTextController;
@property(retain) ImageController * feedbackImageController;
@property(retain) TextController * setUpTextController;
@property(retain) ImageController * setUpImageController;

@property(assign) float taskDemoOpacity;
@property(assign) float feedbackDemoOpacity;
@property(assign) float setUpDemoOpacity;


@property(assign) BOOL enableSpeak;
@property(assign) BOOL enableFeedback;

@end

//
//  Level2SceneDrawer.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "BoatController.h"
#import "Level2WaterController.h"
#import "SceneTransitionController.h"
#import "VisualFeedback.h"
#import "SceneTransitionController.h"

#import "VFAnalysisFrame.h"

@interface Level2SceneDrawer : Transform

-(void) setVisualFeedback:(VisualFeedback *) f;

@property(retain) SceneTransitionController * sceneTransitionController;
@property(retain) BoatController * boatController;
@property(retain) Level2WaterController * level2WaterController;
@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) VFAnalysisFrame * currentFrame;
@property(retain) NSMutableDictionary * sceneTransitionDictionary;

@property(assign) float sceneCamTransX;
@property(assign) float sceneCamTransY;
@property(assign) float sceneCamTransZ;

@property(assign) float sceneCamRotX;
@property(assign) float sceneCamRotY;
@property(assign) float sceneCamRotZ;

@end
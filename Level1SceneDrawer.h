//
//  Level1SceneDrawer.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Transform.h"
#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "BoatController.h"
#import "Level1WaterController.h"
#import "SceneTransitionController.h"
#import "VisualFeedback.h"
#import "SceneTransitionController.h"
#import "Path.h"
#import "PathFeatures.h"

@interface Level1SceneDrawer : Transform

-(void) setVisualFeedback:(VisualFeedback *) f;

@property(retain) SceneTransitionController * sceneTransitionController;
@property(retain) Level1WaterController * level1WaterController;
@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) AnalysisFeatures * analysisFeatures;
@property(retain) VFAnalysisFrame * currentFrame;
@property(retain) NSMutableDictionary * sceneTransitionDictionary;

@property(retain) Path * pathObject; 
@property(retain) Path * pathObject2; 

@property(retain) DTime *	timekeeper;

@property(assign) float fogOpacity;

@property(retain) PathFeatures * pathFeaturesFromAnalysis;

@property(assign)  float testErrorValue;
@property(assign) BOOL drawPlotOnly;
@property(assign) BOOL readyToUpdate;
@property(assign) BOOL showWithAudioPlayback;
@property(assign) BOOL showFogClear;

//for testing thru interface
@property(assign) float positiveHorizontalMagnitude;
@property(assign) float negativeHorizontalMagnitude;
@property(assign) float positiveVerticalMagnitude;
@property(assign) float negativeVerticalMagnitude;
@property(assign) float positiveHorizontalCategory;
@property(assign) float negativeHorizontalCategory;
@property(assign) float positiveVerticalCategory;
@property(assign) float negativeVerticalCategory;
@property(assign) float horizontalComponentForPositiveVertical;
@property(assign) float horizontalComponentForNegativeVertical;


@property(assign) float apositiveHorizontalMagnitude;
@property(assign) float anegativeHorizontalMagnitude;
@property(assign) float apositiveVerticalMagnitude;
@property(assign) float anegativeVerticalMagnitude;
@property(assign) float apositiveHorizontalCategory;
@property(assign) float anegativeHorizontalCategory;
@property(assign) float apositiveVerticalCategory;
@property(assign) float anegativeVerticalCategory;
@property(assign) float ahorizontalComponentForPositiveVertical;
@property(assign) float ahorizontalComponentForNegativeVertical;

@property(assign) float bpositiveHorizontalMagnitude;
@property(assign) float bnegativeHorizontalMagnitude;
@property(assign) float bpositiveVerticalMagnitude;
@property(assign) float bnegativeVerticalMagnitude;
@property(assign) float bpositiveHorizontalCategory;
@property(assign) float bnegativeHorizontalCategory;
@property(assign) float bpositiveVerticalCategory;
@property(assign) float bnegativeVerticalCategory;
@property(assign) float bhorizontalComponentForPositiveVertical;
@property(assign) float bhorizontalComponentForNegativeVertical;


@end




//
//  Level3SceneDrawer.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "VisualFeedback.h"
#import "Level3WaterController.h"
#import "SkyController.h"
#import "IslandController.h"
#import "BirdsController.h"
#import "SceneTransitionController.h"
#import "WeatherController.h"

//why do i have to add this here?
@class SceneTransitionController;

@interface Level3SceneDrawer : Transform





-(void) setVisualFeedback:(VisualFeedback *) f;

@property(assign) TargetSelection gFirstTarget;
@property(assign) TargetSelection gSecondTarget;

@property(retain) VFAnalysisFrame * currentFrame;

@property(assign)   float fogControl;

@property(retain) Texture2d * dayBoatTexture;
@property(retain) Texture2d * cloudyBoatTexture;
@property(retain) Texture2d * mildBoatTexture;


@property(retain) Texture2d * blackFrame;
@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) Level3WaterController * level3WaterController;
@property(retain) SkyController * skyController;

@property(retain) IslandController * islandController;
@property(retain) IslandController * islandControllerFirst;
@property(retain) IslandController * islandControllerSecond;

@property(retain) IslandController * islandController3;
@property(retain) IslandController * islandController4;


@property(retain) BirdsController * birdsController;
@property(retain) SceneTransitionController * sceneTransitionController;
@property(retain) WeatherController * weatherController;
@property(retain) Level3SceneController * sceneController;


@property(assign) BOOL drawFirstIsland;
@property(assign) BOOL drawSecondIsland;
@property(assign) BOOL drawBirds; 


@property(retain) DTime * dTimer;

@property(assign) float transportQuality;

@property(assign) float manipQualityThird;
@property(assign) float manipQualityFourth;


@property(assign) float manipQualityFirst;
@property(assign) float manipQualitySecond;
@property(assign) float manipTypeFirst;
@property(assign) float manipTypeSecond;

@property(assign) float sceneTransZ;
@property(assign) float sceneTransY;

@property(assign) float boatTransX;
@property(assign) float boatTransY;
@property(assign) float boatTransZ;
@property(assign) float boatRotX;
@property(assign) float boatRotY;
@property(assign) float boatRotZ;
@property(assign) float boatOpacity;

@property(assign) float boatScaleX;
@property(assign) float boatScaleY;
@property(assign) float boatScaleZ;


@property(assign) float blackBlockerTransX;
@property(assign) float blackBlockerTransY;
@property(assign) float blackBlockerTransZ;

@property(assign) float blackBlockerScaleX;
@property(assign) float blackBlockerScaleY;
@property(assign) float blackBlockerScaleZ;

@property(assign) float blackCoverOpacity;
@property(retain) Texture2d * blackSquareTexture;

//
@property(assign) BOOL showWind;

@property(assign) BOOL showRainFadeIn;
@property(assign) BOOL showRainConstantHeavy;
@property(assign) BOOL showRainConstantLight;



@property(assign) BOOL showCloudsConstant;
@property(assign) BOOL showCloudsFadeIn;

@property(assign) BOOL showSnowFadeIn;
@property(assign) BOOL showSnowConstant;

@property(assign) BOOL showRockyRide;

@property(assign) BOOL showDayWater;
@property(assign) BOOL showDaySkyConstant;

@property(assign) BOOL showNightToDay;
@property(assign) BOOL showDayToGrey;

@property(assign) BOOL showRoughWater;

@property(assign) BOOL showVeryRoughWater;

@property(assign) BOOL showBlueToWhiteClouds;
@property(assign) BOOL showWhiteCloudsConstant;

@property(assign) BOOL showGreySky;

@property(assign) float secondIslandRatio;


@property(assign) int travelQuality;


@property(assign) BOOL showEfficientSimpleTask;
@property(assign) BOOL showMildSimpleTask;
@property(assign) BOOL showInEfficientSimpleTask;

@property(assign) BOOL showEfficientComplexTask;
@property(assign) BOOL showMildComplexTask;
@property(assign) BOOL showInEfficientComplexTask;


@property(assign) BOOL drawDayBoat;
@property(assign) BOOL drawCloudyBoat;
@property(assign) BOOL drawMildBoat;

@property(assign) float testX;
@property(assign) float testY;
@property(assign) float testrotX;
@property(assign) float testrotY;


@property(assign) BOOL isOrderRightToLeft;

@property(retain) NSMutableDictionary * sceneTransitionDictionary;

@end

//
//  SkyController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "Level3SceneController.h"
#import "WeatherController.h"

@interface SkyController : NSObject


-(void) resetVals;
-(void) drawCloud;
-(void) drawClearSky;
-(void) drawClearSkyWithCloudsFadeIn:(BOOL) doFadeIn;
-(void) drawStormySkyWithLightening:(BOOL)doLightening;

-(void) drawGreySky;

@property(retain) Texture2d * lightening;
@property(retain) Texture2d * lighteningReflection;

@property(retain) Texture2d * greyCloudySkyTexture;

@property(retain) Texture2d * daySkyTexture;
@property(retain) Texture2d * stormySkyTexture;
@property(retain) Texture2d * clearSkyTexture;
@property(retain) Texture2d * cloudTexture;
@property(retain) WeatherController * weatherController;
@property(retain) Texture2d * flatGreyTexture;
@property(retain) Texture2d * whiteCloudySkyTexture;
@property(retain) Texture2d * blueSkyNoCloudsTexture;


@property(retain) DTime * dTimer;

@property(assign) float skyRotX;
@property(assign) float skyRotY;
@property(assign) float skyRotZ;

@property(assign) float skyTransX;
@property(assign) float skyTransY;
@property(assign) float skyTransZ;

@property(assign) float skyScaleX;
@property(assign) float skyScaleY;
@property(assign) float skyScaleZ;

@property(assign) float skyOpacity;
@property(retain) Texture2d * goodSky;
@property(retain) Level3SceneController * level3SceneController;


@property(assign) float fractionTraveled;
@property(assign) BOOL clearToCloudy;
@property(assign) BOOL cloudyToRainy;
@property(assign) BOOL clearSky;
@property(assign) BOOL rainy;
@property(assign) BOOL cloudy;
@property(assign) BOOL clearToSunrise;
@property(assign)     float randOpac;


@property(assign) float transitionFactor;







@end

//
//  BirdsController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "Level3SceneController.h"

@interface BirdsController : NSObject

-(void) drawBirdWithRandomStart:(float)randomStart;
-(void) resetDisplacement;
-(void) drawFakeFlock;

@property(retain) Level3SceneController * sceneController;
@property(retain) Texture2d * wingTexture;
@property(retain) Texture2d * bodyTexture;
@property(retain) DTime * dTimer;

@property(assign) float birdScaleX;
@property(assign) float birdScaleY;
@property(assign) float birdOpacity;
@property(assign) float birdPositionX;
@property(assign) float birdPositionY;
@property(assign) float birdPositionZ;

@property(assign) float displacement;
@property(assign) float yComponent;
@property(assign) float zComponent;
@property(assign) float transitionFactor;

@property(assign) float initialPositionY;
@property(assign) float initialPositionZ;

@property(assign) float cutOffPositionX;
@property(assign) float opacitySubtractor;

@end

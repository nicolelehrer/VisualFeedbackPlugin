//
//  Level3WaterController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "WaterSheet.h"
#import "TravelController.h"
#import "Level3SceneController.h"
@class Level3SceneController;

@interface Level3WaterController : NSObject

-(id) init;

-(void) drawDayWater; 
-(void) drawGreyWater; 
-(void) drawStormyWater;

-(void) resetDisplacement;


@property(retain) DTime * dTimer;

@property(retain) Texture2d * waterTexture;
@property(retain) WaterSheet * waterSheet;

@property(retain) Level3SceneController * level3SceneController;

@property(assign) float waterSheetDepthOverlap;
@property(assign) float waterSheetHeightOverlap;
@property(assign) float waterOpacity;
@property(assign) float initialWaterDepth;
@property(assign) float displacementDepth;

//for setting drawing bounds - should switch to gl method
@property(assign) float cropMinY;
@property(assign) float cropMaxY;
@property(assign) float cropMinTopY;
@property(assign) float cropMaxTopY;

@property(assign) int numSheets;
@property(assign) int numTopSheets;
@end

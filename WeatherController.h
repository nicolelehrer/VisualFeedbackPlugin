//
//  WeatherController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"

@interface WeatherController : NSObject

-(void) drawRainWithIntensity:(float)levelIntensity;

@property(retain) Texture2d * rainSheet;
@property(retain) Texture2d * snowSheet;
@property(retain) DTime * dTimer;
@property(assign) float rainSheetSizeX;
@property(assign) float rainSheetSizeY;
@property(assign) float rainSheetTransX;
@property(assign) float rainSheetTransY;
@property(assign) float rainSheetTransZ;
@property(assign) float rainSheetDepthOverlap;
@property(assign) float rainOpacity;

@property(assign) BOOL cloudyToRainy;
@property(assign) BOOL rainy;
@property(assign) float modOpacity;


@end

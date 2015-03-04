//
//  WaterController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "WaterScape.h"
#import "TravelController.h"

@interface WaterController : NSObject

-(id) init;
-(void) drawWater;
-(void) resetDisplacement;

@property(retain) Texture2d * waterTexture;
@property(retain) WaterScape * waterSheet;
@property(retain) TravelController * travelController;
@property(assign) float waterSheetDepthOverlap;
@property(assign) float waterSheetHeightOverlap;
@property(assign) float waterOpacity;

@end

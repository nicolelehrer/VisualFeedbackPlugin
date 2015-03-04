//
//  TestScenario.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
//#import "VisualFeedback.h"
#import "Transform.h"
#import "WaterScape.h"
#import "ScenarioDrawer.h"

@class VisualFeedback;
@class Texture2d;
@class TravelController;


@interface TestScenario : Transform {
    
    
    VisualFeedback * gVisualFeedback;
    WaterScape * gWaterScape;
    Texture2d * waterTexture;
    Texture2d * waterTextureUp;
    DTime * timer;
    
    DAnimateFloat * displacementAnimation;
    float animation;
    
    BOOL resetDisplacementAnimation;

    TravelController * testControl;
    
    ScenarioDrawer * scenarioDrawer;
}

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent;
- (void) setVisualFeedback:(VisualFeedback *)f;
-(void) resetDisplacement;


@property(retain) VisualFeedback* gVisualFeedback;
@property(retain) WaterScape * gWaterScape;
@property(retain) TravelController * testControl;

@property(retain) DTime * timer;
@property(assign) float displacement;
@property(assign) BOOL resetDisplacementAnimation;
@property(retain) ScenarioDrawer * scenarioDrawer;


@end

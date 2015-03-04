//
//  ScenarioDrawer.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "WaterController.h"
#import "SkyController.h"
#import "IslandController.h"
#import "BirdsController.h"
#import "ScenarioTransitionController.h"

@interface ScenarioDrawer : Transform

@property(retain) WaterController * waterController;
@property(retain) SkyController * skyController;
@property(retain) IslandController * islandControllerFirst;
@property(retain) IslandController * islandControllerSecond;
@property(retain) BirdsController * birdsController;
@property(retain) ScenarioTransitionController * scenarioTransitionController;
@end

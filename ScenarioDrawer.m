//
//  ScenarioDrawer.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScenarioDrawer.h"

@implementation ScenarioDrawer
@synthesize waterController = _waterController;
@synthesize skyController = _skyController;
@synthesize islandControllerFirst = _islandControllerFirst;
@synthesize islandControllerSecond = _islandControllerSecond;
@synthesize birdsController = _birdsController;
@synthesize scenarioTransitionController = _scenarioTransitionController;

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"ScenarioDrawer.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	ScenarioDrawer * node = [[ScenarioDrawer alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}

#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
    
        [self createSceneObjects];
    }
    
	return self;
}

-(void) createSceneObjects
{
    self.waterController =  [[WaterController alloc] init];
    self.skyController = [[SkyController alloc] init];
    self.islandControllerFirst = [[IslandController alloc] initWithPositionX:500 andPositionY:0 andPositionZ:0];
    self.islandControllerSecond = [[IslandController alloc] initWithPositionX:-500 andPositionY:0 andPositionZ:-5000];
    self.birdsController = [[BirdsController alloc] init];
    [self.scenarioTransitionController = [ScenarioTransitionController alloc] initWithStartValue:0 andEndValue:1 andDurationInSec:1];    
}



-(void) manageOpacityTransitions
{
    float sceneOpacity = [self.scenarioTransitionController calcOpacity];
    
    self.waterController.waterOpacity = sceneOpacity;
    self.skyController.skyOpacity = sceneOpacity;
    self.islandControllerFirst.islandOpacity = sceneOpacity;
    self.islandControllerSecond.islandOpacity = sceneOpacity;
    self.birdsController.birdOpacity = sceneOpacity;
}


- (void) drawShape:(GraphicsState *)state
{
     
    [self manageOpacityTransitions];
    
    [self.waterController drawWater];
    [self.skyController drawSky];
    
    [self.islandControllerSecond drawIsland];
    [self.islandControllerFirst drawIsland];
    
    [self.birdsController drawBird];
    
}

-(void) dealloc
{
    [super dealloc];
    [self.skyController release];
    [self.waterController release];
    [self.islandControllerFirst release];
    [self.islandControllerSecond release];
    [self.birdsController release];
}

@end

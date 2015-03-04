//
//  Level2SceneDrawer.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level2SceneDrawer.h"

@implementation Level2SceneDrawer

@synthesize boatController = _boatController;
@synthesize level2WaterController = _level2WaterController;
@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize currentFrame = _currentFrame;
@synthesize sceneTransitionController = _sceneTransitionController;
@synthesize sceneTransitionDictionary = _sceneTransitionDictionary;

@synthesize sceneCamTransX = _sceneCamTransX;
@synthesize sceneCamTransY = _sceneCamTransY;
@synthesize sceneCamTransZ = _sceneCamTransZ;

@synthesize sceneCamRotX = _sceneCamRotX;
@synthesize sceneCamRotY = _sceneCamRotY;
@synthesize sceneCamRotZ = _sceneCamRotZ;

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"VFPostSetScenario.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	Level2SceneDrawer * node = [[Level2SceneDrawer alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}



#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
        [self createSceneObjects];
        [self createDictionary];
        [self connectAnalysis];
        
        self.sceneTransitionController.useTimeOut = YES;
        self.sceneTransitionController.timedOutInSeconds = 6.5;
        self.sceneTransitionController.delayDurationInSeconds = 0.0;
        
        self.sceneCamTransZ = 486.9643;
        self.sceneCamTransY = -200;
           
    }
	
	return self;
}


-(void) createSceneObjects
{
    self.sceneTransitionController = [[SceneTransitionController alloc] initWithStartValue:0 andEndValue:1 andDurationInSec:1];    
    
    self.boatController = [[BoatController alloc] init];
    self.level2WaterController = [[Level2WaterController alloc] init];
    
}

-(void) createDictionary
{    
    self.sceneTransitionDictionary = [[NSMutableDictionary alloc] init];
}

-(void) connectAnalysis
{
    self.boatController.analysisFrame = self.currentFrame;
}

-(void) sendNotificationOfSceneTransitions 
{
    [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:self.sceneTransitionController.shouldDrawScene] forKey:@"shouldDrawScene"];

    
//    [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:self.sceneTransitionController.fadeUpDidStart] forKey:@"fadeUpDidStart"]; 
//    [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:self.sceneTransitionController.fadeDownDidFinish] forKey:@"fadeDownDidFinish"];    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Level2SceneTransition" object:self.sceneTransitionDictionary];
}



-(void) manageSceneTransition
{   
    self.sceneTransitionController.timedOutInSeconds = .01*self.gVisualFeedback.adaptationDelegate.frameCountForLevel2Display;
    
    float sceneOpacity = [self.sceneTransitionController boolAnimateOpacityForScene];

    self.boatController.boatOpacity = sceneOpacity;
    self.level2WaterController.waterSheet.opacity = sceneOpacity*self.level2WaterController.opacityAdjustForTag;
    self.boatController.fogOpacity = sceneOpacity;
    
    self.level2WaterController.waterSheet2.opacity = sceneOpacity;
        
    
    if (!self.sceneTransitionController.shouldDrawScene) {
        [self.boatController resetValues];
    }

}



-(void) updateCameraLocation
{
    [[[Dash dashView] cam] setTranslateY:(0 + self.sceneCamTransY)];
    
    /*
    if (!self.sceneTransitionController.fadeDownDidStart) {
        [[[Dash dashView] cam] setTranslateZ:(7590.096 + 382.9464+ self.sceneCamTransZ) + 200 - self.boatController.boatOpacity*200]; //last 2 components for zoom in and out with transition - how cheezy?
    }
    else{
    
     [[[Dash dashView] cam] setTranslateZ:(7590.096 + 382.9464+ self.sceneCamTransZ)]; //last 2 components for zoom in and out with transition - how cheezy?
    }
    */
    
    [[[Dash dashView] cam] setTranslateZ:(7590.096 + 382.9464+ self.sceneCamTransZ)];
    
    [[[Dash dashView] cam] setRotateY: self.sceneCamRotY];
    [[[Dash dashView] cam] setRotateZ: self.sceneCamRotZ];
    
}

-(void) drawShape:(GraphicsState *)state
{        
    if (self.gVisualFeedback.currEnabledLevel == kLevel2 || self.gVisualFeedback.currEnabledLevel == kLevelDemoLevel2) {
 
        if (self.sceneTransitionController.gTriggerLevelDisplay) {
            self.boatController.randomVariation = (rand() % 2 ? 0 : 1)+1;
            NSLog(@"self.boatController.randomVariation = %i", self.boatController.randomVariation);
        }
        
        [self manageSceneTransition];
        
        [self updateCameraLocation];

        [self sendNotificationOfSceneTransitions];
        
        if (self.sceneTransitionController.shouldDrawScene) {
            
            [self.level2WaterController drawWaterWithTag:self.currentFrame.visualTag andLiftTag:self.currentFrame.liftTag];
            [self.boatController drawBoatWithTag:self.currentFrame.visualTag];
            [self.boatController drawDepthOverlay];
            [self.boatController drawFogWithLiftTag:self.currentFrame.liftTag WithFadeUpCue:self.sceneTransitionController.fadeUpDidStart];

        }
    }
}





-(void) setVisualFeedback:(VisualFeedback *) f
{        
	self.gVisualFeedback = f;
}

-(void) dealloc
{
    [super dealloc];
    [self.level2WaterController release];
    [self.boatController release];
    
}


@end

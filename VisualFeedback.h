//
//  VisualFeedback.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  This class implements a Transform node plugin named VisualFeedback.

#import <Cocoa/Cocoa.h>
#import "DashHeaders.h"
#import "VFAnalysis.h"
#import "VFAdaptationDelegate.h"
#import "VFWindowController.h"

#import "Level1SceneDrawer.h"
#import "Level2SceneDrawer.h"
#import "Level3SceneDrawer.h"

#import "Dialogue.h"
#import "DemoDrawer.h"

#import "InstructionsDrawer.h"



@class VFAdaptationDelegate;
@class DemoDrawer;

@class Level1SceneDrawer;
@class Level2SceneDrawer;
@class Level3SceneDrawer;

@class InstructionsDrawer;



@interface VisualFeedback : Transform <DashPluginProtocol>  

typedef enum {
    kLevel1,
    kLevel1Lift,
    kLevel2,
    kLevel3Sequence,
    kLevel3Transport,
    kLevelDemo,
    kLevelOff,
    kLevelDemoLevel1,
    kLevelDemoLevel1Lift,
    kLevelDemoLevel2,
} EnabledLevel;



@property(assign) BOOL triggerLevelDisplay;

@property(retain) VFAnalysis * analysis;
@property(retain) DemoDrawer * demoDrawer;
@property(retain) VFWindowController * windowController;

@property(retain) VFAdaptationDelegate * adaptationDelegate; 
@property(retain) Level1SceneDrawer * level1SceneDrawer;
@property(retain) Level2SceneDrawer * level2SceneDrawer;
@property(retain) Level3SceneDrawer * level3SceneDrawer;

@property(retain) InstructionsDrawer * instructionDrawer;

@property(assign) float currentScenario;
@property(assign) float nextScenario;

@property(assign) int countScenarioChanges;
@property(assign) BOOL scenarioDidChange;  

@property(assign) float farClipValue;

@property(assign) EnabledLevel currEnabledLevel;

//temp needed
@property(retain) VFPostTrialScenario * postTrialScenario;
@property(retain) VFPostSetScenario * postSetScenario;
@property(retain) VFPostSequenceScenario * postSequenceScenario;

@property (assign) BOOL turnOnMasterDisableGridLightInfo;


// class methods
+ (BOOL) initializePlugin:(NSBundle *)bundle;
+ (VFAdaptationDelegate*) vfAdaptationDelegate;
+ (VisualFeedback*) sharedVisualFeedback;
+ (void) makeViewFullScreen;

 
@end

//
//  VFAdaptationDelegate.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  defines visual feedback delegation methods for adaptation module

#import <Cocoa/Cocoa.h>
#import "ADMainController.h"


//test
#import "ADScenarioData.h"

@class VisualFeedback;

@interface VFAdaptationDelegate : NSObject <ADFeedbackProtocol, ADMotionAnalysisConstantsProtocol, ADDemoProtocol, ADScenarioDataProtocol>
typedef enum {
    kAdaptationLevel1,
    kAdaptationLevel1Lift,
    kAdaptationLevel2,
    kAdaptationLevel3Sequence,
    kAdaptationLevel3Transport,
    kAdaptationLevelDemo,
    kAdaptationLevelOff,
    kAdaptationLevelDemoLevel1,
    kAdaptationLevelDemoLevel1Lift,
    kAdaptationLevelDemoLevel2,
} LevelSentByAdaptation;

@property(assign) LevelSentByAdaptation levelSentByAdaptation;

- (void) setVisualFeedback:(VisualFeedback *)f;
//for gui
-(void) updateCurrentState;



-(void) sendNotificationToPlayVideo;
- (void) runTaskDemo:(ADScenarioData*)adScen;



-(void)runTaskInstruction:(NSString*)taskInstructionID;
-(void)runFeedbackInstruction:(NSString*)feedbackInstructionID;


@property (assign) TransportStates taskID;
@property (assign) TargetSelection targetID1;
@property (assign) TargetSelection targetID2;

@property (assign) TargetTypes targetTypeLeft;
@property (assign) TargetTypes targetTypeMid;
@property (assign) TargetTypes targetTypeRight;

@property (assign) BOOL shouldEnableTransport;

@property(assign) BOOL showTargetSetup;

@property (retain) VisualFeedback * gVisualFeedback;

@property (assign) int frameCountForLevel1Display;
@property (assign) int frameCountForLevel2Display;

@property (retain) NSString * stringForDemo;

@property(retain) NSString * instructionID;
@property(retain) NSString * demoType;

@property(assign) int position;

@property(assign) int targetID1ReminderL3;
@property(assign) int targetID2ReminderL3;

@property(assign) int setID;
@property(assign) int setCount;

@property(assign) float shifter;
@property(assign) BOOL transportIsCone;

@end
//
//  VFAdaptationDelegate.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VFAdaptationDelegate.h"
#import "VisualFeedback.h"
//#import "ADSystemParameters.h"
//#import "ADMotionAnalysisParameters.h"
#import "ADMotionAnalysisConstants.h"
#import "ADMainController.h"

@interface VFAdaptationDelegate()



@end

@implementation VFAdaptationDelegate

@synthesize stringForDemo = _stringForDemo;
@synthesize taskID = _taskID;
@synthesize targetID1 = _targetID1;
@synthesize targetID2 = _targetID2;

@synthesize targetTypeLeft = _targetTypeLeft;
@synthesize targetTypeMid = _targetTypeMid;
@synthesize targetTypeRight = _targetTypeRight;

@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize frameCountForLevel1Display = _frameCountForLevel1Display;
@synthesize frameCountForLevel2Display = _frameCountForLevel2Display;

@synthesize levelSentByAdaptation = _levelSentByAdaptation;
@synthesize showTargetSetup = _showTargetSetup;

@synthesize instructionID = _instructionID;
@synthesize demoType = _demoType;
@synthesize position = _position;

@synthesize targetID1ReminderL3 = _targetID1ReminderL3;
@synthesize targetID2ReminderL3 = _targetID2ReminderL3;

@synthesize setID = _setID;
@synthesize setCount = _setCount;

@synthesize shifter =_shifter;
@synthesize transportIsCone = _transportIsCone;

- (id)init
{
    self = [super init];
    if (self) {
		NSLog(@"init VFAdaptationDelegate");
        
        self.frameCountForLevel1Display = 700;  //have to factor in delay
        self.frameCountForLevel2Display = 650;
        
        
        self.instructionID = @"from adaptation init";
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(updateSetTotal:)
													 name:@"UpdateSetTotal"
												   object:nil];
    }
    return self;
}





-(void)updateSetTotal:(NSNotification *)anotification
{
    NSNumber * numSets = (NSNumber*)[anotification object];
    self.setCount = [numSets intValue];
    NSLog(@"total number of sets is %i", self.setCount);
}
 
- (void) setVisualFeedback:(VisualFeedback *)f
{
	self.gVisualFeedback = f;
}


- (void) updatePluginsADScenarioData:(ADScenarioData*)scenData
{
    

    NSLog(@"updatePluginsADScenarioData was called from VF");
    self.taskID = [scenData taskId];
    
    if([scenData audioPlayback] == 1) {
        self.gVisualFeedback.level1SceneDrawer.showWithAudioPlayback = YES;
    }
    else{
        self.gVisualFeedback.level1SceneDrawer.showWithAudioPlayback = NO;
    }
        
        
    if([scenData feedbackLevel1] == fl1Visual) {
        
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.useTimeOut = YES;
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.delayDurationInSeconds = 1.0;
        self.levelSentByAdaptation = kAdaptationLevel1;
    }
    else if([scenData feedbackLevel1] == fl1VisualWithLift) {
        
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.useTimeOut = YES;
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.delayDurationInSeconds = 1.0;
        self.levelSentByAdaptation = kAdaptationLevel1Lift;
    }
    else if([scenData feedbackLevel2] == fl2Visual
         || [scenData feedbackLevel2] == fl2AudioAndVisual) {
        
        self.gVisualFeedback.level2SceneDrawer.sceneTransitionController.useTimeOut = YES;
        self.gVisualFeedback.level2SceneDrawer.sceneTransitionController.delayDurationInSeconds = 0;
        self.levelSentByAdaptation = kAdaptationLevel2;
    }
    
    
    else if ([scenData taskId] == maLevel3 || [scenData taskId] == maLevel3Alt) {
        
        self.levelSentByAdaptation = kAdaptationLevel3Sequence;
    }
    else if ([scenData taskId] == maLevel3Transport) {
        
        self.levelSentByAdaptation = kAdaptationLevel3Transport;
    }
    else {
        self.levelSentByAdaptation = kAdaptationLevelOff;
    }
    
    [self updateCurrentState];

    self.targetID1 = [scenData targetId];
    self.targetID2 = [scenData targetId2];
    
    [self.gVisualFeedback.windowController updatePopUpWithEnabledLevel];
    [self.gVisualFeedback.windowController updateKillInActiveAnimation];
}

- (void) runMarkersLostDemo
{
    NSLog(@"runMarkersLostDemo was called from VF");

    [self.gVisualFeedback.demoDrawer markersLostDemo];
}
- (void) startUpDemo:(NSString*)demo
{
    NSLog(@"startUpDemo was called from VF");

    [self.gVisualFeedback.demoDrawer startUpDemo:demo];
}






- (void) runTangibleConnectionDemo:(ADScenarioData *)adScen
{
    
    NSLog(@"runTangibleConnectionDemo was called from VF");

    [self runTaskInstruction:@"targetSetup"];
    [self.gVisualFeedback.instructionDrawer tangibleConnectionDemo:adScen];
}




-(void) updateCurrentState
{
    NSLog(@"updateCurrentState was called from VF");
    
    NSLog(@"Level Sent By Adaptation: %i", self.levelSentByAdaptation);

    
    //separates control of currEnabledLevel by one layer so that enum updates in one method
    
    if (self.levelSentByAdaptation == kAdaptationLevel1){
        self.gVisualFeedback.currEnabledLevel = kLevel1;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevel1Lift) {
        self.gVisualFeedback.currEnabledLevel = kLevel1Lift;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevel2){
        self.gVisualFeedback.currEnabledLevel = kLevel2;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevel3Sequence){
        self.gVisualFeedback.currEnabledLevel = kLevel3Sequence;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevel3Transport){
        self.gVisualFeedback.currEnabledLevel = kLevel3Transport;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevelDemo){
        self.gVisualFeedback.currEnabledLevel = kLevelDemo;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevelDemoLevel1){
        self.gVisualFeedback.currEnabledLevel = kLevelDemoLevel1;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevelDemoLevel1Lift){
        self.gVisualFeedback.currEnabledLevel = kLevelDemoLevel1Lift;
    }
    else if (self.levelSentByAdaptation == kAdaptationLevelDemoLevel2){
        self.gVisualFeedback.currEnabledLevel = kLevelDemoLevel2;
    }
    else {
        self.gVisualFeedback.currEnabledLevel = kLevelOff;
    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentState" object:[NSNumber numberWithInt:self.gVisualFeedback.currEnabledLevel]];
    
    
    NSLog(@"update currentState called");
}

- (void) runTaskDemo:(ADScenarioData*)adScen
{
    
    NSLog(@"runTaskDemo was called from VF");

    NSString * tempForDemo = @"----";
        
    if (adScen.taskId == maRealTime || adScen.taskId == maLevel2) {

        if (adScen.targetId == leftVirtual ||
            adScen.targetId == middleVirtual ||
            adScen.targetId == rightVirtual) {
            
            tempForDemo = @"flatTargetID";
        }
        if (adScen.targetId == leftButton ||
            adScen.targetId == middleButton ||
            adScen.targetId == rightButton) {
            
            tempForDemo = @"buttonTargetID";
        }
        if (adScen.targetId == leftCone ||
            adScen.targetId == middleCone ||
            adScen.targetId == rightCone ||
            adScen.targetId == leftOnTransportCone ||
            adScen.targetId == rightOnTransportCone ||
            adScen.targetId == middleOnTransportCone ||
            adScen.targetId == leftOffTransportCone ||
            adScen.targetId == rightOffTransportCone ||
            adScen.targetId == middleOffTransportCone) {
            
            tempForDemo = @"coneTargetID";
        }
        if (adScen.targetId == leftOnTransport ||
            adScen.targetId == middleOnTransport ||
            adScen.targetId == rightOnTransport ||
            adScen.targetId == leftOffTransport ||
            adScen.targetId == middleOffTransport ||
            adScen.targetId == rightOffTransport) {
            
            tempForDemo = @"cylinderTargetID";
        }
    }
    
    if (adScen.taskId == maRealTimeLift || adScen.taskId == maLevel2Lift) {
    
        if (adScen.targetId == leftOnTransport ||
            adScen.targetId == middleOnTransport ||
            adScen.targetId == rightOnTransport ||
            adScen.targetId == leftOffTransport ||
            adScen.targetId == middleOffTransport ||
            adScen.targetId == rightOffTransport) {
            
            tempForDemo = @"cylinderLiftTargetID";
        }
        
        if (adScen.targetId == leftOnTransportCone ||
            adScen.targetId == middleOnTransportCone ||
            adScen.targetId == rightOnTransportCone ||
            adScen.targetId == leftOffTransportCone ||
            adScen.targetId == middleOffTransportCone ||
            adScen.targetId == rightOffTransportCone) {
            
            tempForDemo = @"coneLiftTargetID";
        }
        
    }
    
    if (adScen.taskId == maLevel3) {
        
        if ((adScen.targetId == leftVirtual ||
             adScen.targetId == middleVirtual ||
             adScen.targetId == rightVirtual)
            
            && (adScen.targetId2 == leftVirtual ||
                adScen.targetId2 == middleVirtual ||
                adScen.targetId2 == rightVirtual)) {
                
                tempForDemo = @"virtualVirtualTargetID";
                
            }
        
        if ((adScen.targetId == leftVirtual ||
               adScen.targetId == middleVirtual ||
               adScen.targetId == rightVirtual)
            
        && (adScen.targetId2 == leftButton ||
                adScen.targetId2 == middleButton ||
                adScen.targetId2 == rightButton)) {
            
                tempForDemo = @"virtualButtonTargetID";

        }
        
        if ((adScen.targetId2 == leftVirtual ||
             adScen.targetId2 == middleVirtual ||
             adScen.targetId2 == rightVirtual)
            
        && (adScen.targetId == leftButton ||
                adScen.targetId == middleButton ||
                adScen.targetId == rightButton)) {
                
                tempForDemo = @"buttonVirtualTargetID";
        }
        
        if ((adScen.targetId == leftVirtual ||
             adScen.targetId == middleVirtual ||
             adScen.targetId == rightVirtual)
            
            && ( adScen.targetId2 == leftCone ||
                 adScen.targetId2 == middleCone ||
                 adScen.targetId2 == rightCone ||
                
                 adScen.targetId2 == leftOnTransportCone ||
                 adScen.targetId2 == middleOnTransportCone ||
                 adScen.targetId2 == rightOnTransportCone ||
                
                 adScen.targetId2 == leftOffTransportCone ||
                 adScen.targetId2 == middleOffTransportCone ||
                 adScen.targetId2 == rightOffTransportCone)
                
            
            ) {
            
                tempForDemo = @"virtualConeTargetID";
                
            }
        
        if ((adScen.targetId2 == leftVirtual ||
             adScen.targetId2 == middleVirtual ||
             adScen.targetId2 == rightVirtual)
            
            && (adScen.targetId == leftCone ||
                adScen.targetId == middleCone ||
                adScen.targetId == rightCone ||
            
                adScen.targetId == leftOnTransportCone ||
                adScen.targetId == middleOnTransportCone ||
                adScen.targetId == rightOnTransportCone ||
            
                adScen.targetId == leftOffTransportCone ||
                adScen.targetId == middleOffTransportCone ||
                adScen.targetId == rightOffTransportCone)
            
            
            ) {
                
                tempForDemo = @"coneVirtualTargetID";
                
            }
        
        if ((adScen.targetId == leftVirtual ||
             adScen.targetId == middleVirtual ||
             adScen.targetId == rightVirtual)
            
            && (adScen.targetId2 == leftOnTransport ||
                adScen.targetId2 == middleOnTransport ||
                adScen.targetId2 == rightOnTransport ||
                adScen.targetId2 == leftOffTransport ||
                adScen.targetId2 == middleOffTransport ||
                adScen.targetId2 == rightOffTransport)) {
                
                tempForDemo = @"virtualCylinderTargetID";
                
            }
        
        
        if ((adScen.targetId2 == leftVirtual ||
             adScen.targetId2 == middleVirtual ||
             adScen.targetId2 == rightVirtual)
            
            && (adScen.targetId == leftOnTransport ||
                adScen.targetId == middleOnTransport ||
                adScen.targetId == rightOnTransport ||
                adScen.targetId == leftOffTransport ||
                adScen.targetId == middleOffTransport ||
                adScen.targetId == rightOffTransport)) {
                
                tempForDemo = @"cylinderVirtualTargetID";
                
            }
    }
    
    if (adScen.taskId == maLevel3Transport) {
        if (adScen.transportTarget == transportOn) {
            tempForDemo = @"cylinderTransportTargetID";
        }
        else if(adScen.transportTarget == transportConeOn){
            tempForDemo = @"coneTransportTargetID";

        }
    }
    
    
    [self runTaskInstruction:tempForDemo];
    
    
}



- (void) runFeedbackDemo:(ADScenarioData*)adScen withSelection:(NSString*)demo
{
    self.setID =  adScen.setId;
    
    if(adScen.transportTarget == transportConeOn){
        self.transportIsCone = YES;
    }
    else{
        self.transportIsCone = NO;
    }

    [self.gVisualFeedback.instructionDrawer tangibleConnectionDemo:adScen];
    
    if ([demo isEqualToString:@"NotifyTarget"]) {
        
        if (adScen.targetId == leftOffTransportCone ||
            adScen.targetId == middleOffTransportCone ||
            adScen.targetId == rightOffTransportCone ||
            adScen.targetId == leftOnTransportCone ||
            adScen.targetId == middleOnTransportCone ||
            adScen.targetId == rightOnTransportCone ||
            
            adScen.targetId2 == leftOffTransportCone ||
            adScen.targetId2 == middleOffTransportCone ||
            adScen.targetId2 == rightOffTransportCone ||
            adScen.targetId2 == leftOnTransportCone ||
            adScen.targetId2 == middleOnTransportCone ||
            adScen.targetId2 == rightOnTransportCone) {
            
            demo = @"notifyTargetWithButtonsCone";
        }
        else{
            demo = @"notifyTargetWithButtons";
        }
        
        
        
        
        if ([adScen targetId] > 9) {
            
            self.position = adScen.targetId;
            
            //is target 1 is acylinder
            //adscen targetId - look if this is left middle right
          /*  if(adScen.targetId == leftOnTransport) self.position = @"left";
            if(adScen.targetId == middleOnTransport) self.position = @"middle";
            if(adScen.targetId == rightOnTransport) self.position = @"right";
           
            if(adScen.targetId == leftOffTransport) self.position = @"left";
            if(adScen.targetId == middleOffTransport) self.position = @"middle";
            if(adScen.targetId == rightOffTransport) self.position = @"right";*/
        }
        else if ([adScen targetId] < 9 && [adScen targetId2] > 9) {
            
            self.position = adScen.targetId2;
            
            //if target 2 is a cylinder
            //adscen targetId2 - look if this is left middle right

            /*
            if(adScen.targetId2 == leftOnTransport) self.position = @"left";
            if(adScen.targetId2 == middleOnTransport) self.position = @"middle";
            if(adScen.targetId2 == rightOnTransport) self.position = @"right";
            
            if(adScen.targetId2 == leftOffTransport) self.position = @"left";
            if(adScen.targetId2 == middleOffTransport) self.position = @"middle";
            if(adScen.targetId2 == rightOffTransport) self.position = @"right";
             */

        }
    }

    
    NSLog(@"runFeedbackDemo is being called");
    
    if ([demo isEqualToString:@"realTimePathFull"]) {
        if ([adScen targetId] != leftVirtual &&
            [adScen targetId] != middleVirtual &&
            [adScen targetId] != rightVirtual) {
            
            demo = @"realTimePathFullBase";
        }
    }
    
    if ([demo isEqualToString:@"realTimePathPrompt"]) {
        if ([adScen targetId] != leftVirtual &&
            [adScen targetId] != middleVirtual &&
            [adScen targetId] != rightVirtual) {
            
            demo = @"realTimePathPromptBase";
        }
    }
    
    
    if ([demo isEqualToString:@"l2TaskCompFull"]) {
        if ([adScen targetId] == leftCone ||
            [adScen targetId] == middleCone ||
            [adScen targetId] == rightCone ||
            [adScen targetId] == leftOffTransport ||
            [adScen targetId] == leftOnTransport ||
            [adScen targetId] == middleOffTransport ||
            [adScen targetId] == middleOnTransport ||
            [adScen targetId] == rightOffTransport ||
            [adScen targetId] == rightOnTransport) {
        
            demo = @"l2TaskCompFullGrasp";
        }
        else{
            demo = @"l2TaskCompFullTouch";
        }
    }
    
    
    if ([demo isEqualToString:@"level3Reminder"]) {
        
        if ([adScen taskId] == maLevel3Transport) {
            self.gVisualFeedback.instructionDrawer.targetSetup.isTransportTask = YES;
        }
        else{
            self.gVisualFeedback.instructionDrawer.targetSetup.isTransportTask = NO;
        }
        
        
        self.gVisualFeedback.instructionDrawer.targetSetup.targetID1ForL3 = [adScen targetId];
        self.gVisualFeedback.instructionDrawer.targetSetup.targetID2ForL3 = [adScen targetId2];

        
    
    }
    
    
    [self runFeedbackInstruction:demo];
   
}


- (void) updatePluginsLevel0:(FeedbackLevelZero)fZero{}
- (void) updatePluginsLevel1:(FeedbackLevelOne)fOne{}
- (void) updatePluginsLevel2:(FeedbackLevelTwo)fTwo {}
- (void) updatePluginsTorso:(int)torsoState{}
- (void) updatePluginsWrist:(int)wristState{}
- (void) runFeedbackDemo:(ADScenarioData*)adScen{}
- (void) runL2Demo:(ADScenarioData*)adScen{}
- (void) turnOnDialogButtons:(int)selection{}
- (void) turnOffDialogButtons{}
- (void) replayCurrentDemo:(BOOL)decision{}

- (void) updatePluginsADMotionAnalysisConstants:(ADMotionAnalysisConstants *)motionConstants {
    
    //setting manually in init
    //    int stopTime = [motionConstants stopDuration];
    //    self.frameCountForLevel1Display = stopTime;
    
}

- (void) dealloc
{
	[super dealloc];

}


/////////////////////////////////////////////INSTRUCTION


-(void) determineDemoTypeFrom:(NSString*)longerString
{
   
    if ([longerString rangeOfString:@"Prompt"].location != NSNotFound ||
        [longerString isEqualToString:@"sameSet"] ) {
        
        self.demoType = @"moreDetailAndNext";
    }
    else if ([longerString rangeOfString:@"Full"].location != NSNotFound) {
        
        self.demoType = @"moreDetailAndReplay";
    }    
    else if ([longerString rangeOfString:@"TargetID"].location != NSNotFound ||
             [longerString isEqualToString:@"level3Reminder"] ||
             [longerString isEqualToString:@"notifyTargetWithButtons"] ||
             [longerString isEqualToString:@"notifyTargetWithButtonsCone"] ||
             [longerString isEqualToString:@"startSet"] ||
             [longerString isEqualToString:@"markersLost"] ||
             [longerString rangeOfString:@"turnOff"].location != NSNotFound){
       
        self.demoType = @"nextButton";
    }
    else if([longerString isEqualToString:@"target"] ) {
        
        self.demoType = @"readyButton";
    }
   
    
}

-(void)runTaskInstruction:(NSString*)taskInstructionID
{

    [self determineDemoTypeFrom:taskInstructionID];
    self.gVisualFeedback.instructionDrawer.imageController.showButtons = NO;
    
    if (![taskInstructionID isEqualToString:@"skip"]) {
        self.instructionID = taskInstructionID;
    }
    else{
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"Skip" object:[NSNumber numberWithBool:YES]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckForDemoReplay" object:[NSNumber numberWithBool:YES]];
        NSLog(@"sent notification CheckForDemoReplay");
    }
    
    [self updateVFAdaptationStateForDemo];
    [self sendNotificationToPlayVideo];
}

-(void)runFeedbackInstruction:(NSString*)feedbackInstructionID
{
    [self determineDemoTypeFrom:feedbackInstructionID];
    self.gVisualFeedback.instructionDrawer.imageController.showButtons = NO;
    
    if (![feedbackInstructionID isEqualToString:@"skip"]) {
        self.instructionID = feedbackInstructionID;
    }
    else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Skip" object:[NSNumber numberWithBool:YES]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckForDemoReplay" object:[NSNumber numberWithBool:YES]];
        NSLog(@"sent notification CheckForDemoReplay");
    }
    
    [self updateVFAdaptationStateForDemo];
    [self sendNotificationToPlayVideo];
}

-(void)sendNotificationToPlayVideo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkIfShouldPlayVideo" object:nil];
}

-(void)updateVFAdaptationStateForDemo
{
    self.levelSentByAdaptation = kAdaptationLevelDemo;
    [self updateCurrentState];
}



@end

//
//  VFAnalysis.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VFAnalysis.h"
#import "VFAnalysisFrame.h"
#import "MABinTrajFeatures.h"
#import "MATrialFrameData.h"
#import "MALevel2FeedbackData.h"
#import "MALevel3FeedbackData.h"
#import "VisualFeedback.h"
#import "MATrialAnalysis.h"
#import "TravelController.h"

#import "Level3SceneDrawer.h"
//test

@interface VFAnalysis (private)
- (void)receiveAnalysisNotification:(NSNotification *)notification;
@end

@implementation VFAnalysis

@synthesize gVisualFeedback;
@synthesize currentFrame;
@synthesize testControl;
@synthesize previousState = _previousState;
@synthesize targetUpdateID = _targetUpdateID;
@synthesize portableTargetIsInWrongPlace = _portableTargetIsInWrongPlace;
#pragma mark ---- initializers  ----

- (id)init
{
	self = [super init];
    if (self) {
        
        
                //realtime trial, per frame 
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveState:) 
													 name:@"MATrialFrame"
												   object:nil];
        //post trial 
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveAnalysisNotificationTrial:) 
													 name:@"MATrialVisualFeatures"
												   object:nil]; 
		//post set 
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveLevel2Tags:) 
													 name:@"MALevel2FeedbackData"
												   object:nil];
		
        
              
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveTangibleSetup:) 
													 name:@"CheckObjectsResult"
												   object:nil];
       
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveLevel3Results:) 
													 name:@"MALevel3FeedbackDataArchive"
												   object:nil];
     
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveNotifyMoveTarget:)
													 name:@"NotifyMoveTarget"
												   object:nil];

        
        
        
		currentFrame = [[VFAnalysisFrame alloc] init];
            
        self.currentFrame.binNumber = 20;
        
        self.currentFrame.liftTag = vBlank;

        self.portableTargetIsInWrongPlace = NO;

        
		NSLog( @"init VFAnalysis");
        
//        self.currentFrame.firstTarget = rightVirtual;
		
    }
	return self;
}


#pragma mark ---- instance methods  ----

//realtime per frame
- (void)receiveState:(NSNotification *) notification
{	
    MATrialFrameData * trialFrameObject = (MATrialFrameData *)([notification object]);
    //NSLog(@"ReachState in visuals: %d", trialFrameObject.realTimeState);
    self.currentFrame.stateFromAnalysis = trialFrameObject.realTimeState;
	
    
}

//post trial 
- (void)receiveAnalysisNotificationTrial:(NSNotification *) notification
{	
 	if ([[notification name] isEqualToString:@"MATrialVisualFeatures"]) {
        
        self.gVisualFeedback.adaptationDelegate.frameCountForLevel1Display = [(MATrialAnalysis *)[notification object] reachTime] +100;
        
        NSMutableArray* trajectoryFeatures = [(MATrialAnalysis *)[notification object] visualFeedbackFeatures];
        
        self.currentFrame.liftSuccess = [(MATrialAnalysis *)[notification object] liftSuccess];
        
        
        self.gVisualFeedback.level1SceneDrawer.showFogClear = NO;
        self.currentFrame.binNumber = [trajectoryFeatures count];
        
        int i;
        for(i=0; i<20; i++)
        {
            MABinTrajFeatures * temp = [trajectoryFeatures objectAtIndex:i];
            
            [[self.currentFrame.pathBins objectAtIndex:i] setPositiveHorizontalMagnitude:temp.xPosXNorm];
            [[self.currentFrame.pathBins objectAtIndex:i] setPositiveHorizontalCategory:temp.xPosErrorCategory];
            
            [[self.currentFrame.pathBins objectAtIndex:i] setNegativeHorizontalMagnitude:temp.xNegXNorm];
            [[self.currentFrame.pathBins objectAtIndex:i] setNegativeHorizontalCategory:temp.xNegErrorCategory];
            
            [[self.currentFrame.pathBins objectAtIndex:i] setPositiveVerticalMagnitude:temp.yPosYNorm];
            [[self.currentFrame.pathBins objectAtIndex:i] setPositiveVerticalCategory:temp.yPosErrorCategory];
            
            [[self.currentFrame.pathBins objectAtIndex:i] setNegativeVerticalMagnitude:temp.yNegYNorm];
            [[self.currentFrame.pathBins objectAtIndex:i] setNegativeVerticalCategory:temp.yNegErrorCategory];

            [[self.currentFrame.pathBins objectAtIndex:i] setHorizontalComponentForPositiveVertical:temp.yPosXNorm];
            [[self.currentFrame.pathBins objectAtIndex:i] setHorizontalComponentForNegativeVertical:temp.yNegXNorm];
        }
        
        [self.gVisualFeedback.level1SceneDrawer.pathObject refreshTexureIDsAndScatterValues];
        
        self.gVisualFeedback.level1SceneDrawer.readyToUpdate = YES;
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.gTriggerLevelDisplay = YES;
    }
	
}


//post set 
-(void) receiveLevel2Tags:(NSNotification *) notification
{
    self.currentFrame.liftTag = vBlank;
    self.currentFrame.visualTag = vBlank;
    
    MALevel2FeedbackData* q = (MALevel2FeedbackData*)([notification object]);
    
    NSLog(@"from visual plugin: received tag: %i ", q.visualResult); 
    
    self.currentFrame.visualTag = q.visualResult;
    self.currentFrame.liftTag = q.liftResult;
   
    self.gVisualFeedback.level2SceneDrawer.sceneTransitionController.gTriggerLevelDisplay = YES;

}


//post level 3
-(void) receiveLevel3Results:(NSNotification *) notification
{    
    
    MALevel3FeedbackData * feedbackObject = [notification object];
    
    if (feedbackObject.level3Result == showEfficientSimpleTask){
        self.gVisualFeedback.level3SceneDrawer.travelQuality = 0;
    }
    
    if (feedbackObject.level3Result == showMildSimpleTask) {
        self.gVisualFeedback.level3SceneDrawer.travelQuality = 1;
    }
    
    if (feedbackObject.level3Result == showInEfficientSimpleTask) {
        self.gVisualFeedback.level3SceneDrawer.travelQuality = 2;
    }
    
    self.currentFrame.firstTarget = feedbackObject.firstTarget;
    
    
    // 0 = efficient, 1 = moderate, 2 = severe (0 means you see you the island, 2 mean you don't see it)
    
    if (feedbackObject.target1Success) {
        self.currentFrame.manipQualityTargetID1 = 0;
    }
    else {
        self.currentFrame.manipQualityTargetID1 = 2;
    }
    
    
    if (feedbackObject.target2Success) {
        self.currentFrame.manipQualityTargetID2 = 0;
    }
    else {
        self.currentFrame.manipQualityTargetID2 = 2;
    }
    
    
    if (feedbackObject.target3Success) {
        self.currentFrame.manipQualityTargetID3 = 0;
    }
    else {
        self.currentFrame.manipQualityTargetID3 = 2;
    }
    
    
    if (feedbackObject.target4Success) {
        self.currentFrame.manipQualityTargetID4 = 0;
    }
    else {
        self.currentFrame.manipQualityTargetID4 = 2;
    }
    
    self.gVisualFeedback.level3SceneDrawer.sceneTransitionController.gTriggerLevelDisplay = YES;
    [self.gVisualFeedback.windowController updatePopUpWithTravelQual];

}



//checks after button has been pushed to see what the target configuration is
-(void) receiveTangibleSetup:(NSNotification *) notification
{
    [self.gVisualFeedback.instructionDrawer tangibleSetup:notification];
}

- (void) setVisualFeedback:(VisualFeedback *)f
{
	self.gVisualFeedback = f;
}

-(void) receiveNotifyMoveTarget:(NSNotification *) notification
{
   NSNumber * targetIDNumber =  [notification object];
   self.targetUpdateID = [targetIDNumber intValue];
        
    if (self.gVisualFeedback.currEnabledLevel != kLevelDemo) {
        
        if ( self.targetUpdateID != -1) {
            
                self.portableTargetIsInWrongPlace = YES;
                self.previousState = self.gVisualFeedback.currEnabledLevel;
            
            if (self.gVisualFeedback.adaptationDelegate.transportIsCone) {
                self.gVisualFeedback.adaptationDelegate.instructionID = @"notifyTargetCone";
                [self.gVisualFeedback.adaptationDelegate runTaskInstruction:@"notifyTargetCone"];
            }
            else{
            
                self.gVisualFeedback.adaptationDelegate.instructionID = @"notifyTarget";
                [self.gVisualFeedback.adaptationDelegate runTaskInstruction:@"notifyTarget"];
            }
        }
    }
    else{
            
        if ( self.targetUpdateID == -1) {
            //go back to previous state
            self.gVisualFeedback.currEnabledLevel = self.previousState;
            self.portableTargetIsInWrongPlace = NO;

        }
    }
    //remember last state
    //-1 anytime we are in reaction
    //0-something if we need correction to a certain location 

}



@end
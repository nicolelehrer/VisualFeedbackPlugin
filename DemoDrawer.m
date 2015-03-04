//
//  DemoDrawer.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DemoDrawer.h"
#import "TargetSetup.h"

@interface DemoDrawer()
@property(retain) TargetSetup * targetSetup;
@property(assign) BOOL tangibleSetupResultsReceived;
@property(assign) BOOL showTargetSetup;
@property(retain) FeedbackDemo * feedbackDemo;
@end


@implementation DemoDrawer

@synthesize enableSpeak = _enableSpeak;
@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize currentFrame = _currentFrame;
@synthesize taskSceneTransitionController = _taskSceneTransitionController;
@synthesize feedbackSceneTransitionController = _feedbackSceneTransitionController;
@synthesize sceneTransitionController = _sceneTransitionController;

@synthesize taskDemoOpacity = _taskDemoOpacity;
@synthesize feedbackDemoOpacity = _feedbackDemoOpacity;
@synthesize setUpDemoOpacity = _setUpDemoOpacity;

@synthesize taskTextController = _taskTextController;
@synthesize taskImageController = _taskImageController;
@synthesize feedbackTextController = _feedbackTextController;
@synthesize feedbackImageController = _feedbackImageController;
@synthesize setUpTextController = _setUpTextController;
@synthesize setUpImageController = _setUpImageController;

@synthesize targetSetup = _targetSetup;
@synthesize tangibleSetupResultsReceived = _tangibleSetupResultsReceived;
@synthesize showTargetSetup = _showTargetSetup;
@synthesize feedbackDemo = _feedbackDemo;

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"VFPostSetScenario.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	DemoDrawer * node = [[DemoDrawer alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}



#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
        [self createSceneObjects];
         
        self.sceneTransitionController.useTimeOut = NO;
        self.sceneTransitionController.delayDurationInSeconds = 0.0;
        
        self.targetSetup = [[TargetSetup alloc] init];
        
    }
	
	return self;
}


-(void) createSceneObjects
{
    
    self.sceneTransitionController = [[SceneTransitionController alloc] initWithStartValue:0 andEndValue:1 andDurationInSec:.2];
    self.setUpTextController = [[TextController alloc] init];
    self.setUpImageController = [[ImageController alloc] init];
    self.feedbackDemo = [[FeedbackDemo alloc] init];
}


-(void) updateCameraLocationForDemoType:(NSString*)demoType
{
    if (![demoType isEqualToString:@"demoPostVisual"] && ![demoType isEqualToString:@"demoPostVisualWithLift"] && ![demoType isEqualToString:@"demoLevel2Visual"] ) {
        
        [[[Dash dashView] cam] setTranslateY:0.0];
        [[[Dash dashView] cam] setTranslateZ:6640.0];
    }
}


-(void) manageSceneTransition
{
    float sceneOpacity = [self.sceneTransitionController boolAnimateOpacityForScene];

    self.setUpDemoOpacity = sceneOpacity;
    self.setUpTextController.textOpacity = sceneOpacity;
    self.setUpImageController.imageOpacity = sceneOpacity;
    self.targetSetup.sceneOpacity = sceneOpacity;
    
    if (self.sceneTransitionController.oneTimeResetAfterFadeDown) {
        [self.setUpTextController.synth stopSpeaking];
    }
    
}


-(void)updateVFAdaptationState
{
    self.gVisualFeedback.adaptationDelegate.levelSentByAdaptation = kAdaptationLevelDemo;
    [self.gVisualFeedback.adaptationDelegate updateCurrentState];
}



-(void)setUpSpeakForGroupName:(NSString*)groupName
{
    self.setUpTextController.dialogueGroupName = groupName;
    NSLog(@"check to see receiving string in startup demo = %@", groupName);
    
    self.setUpTextController.dialogueArrayIndex = 0;
    self.enableSpeak = YES;
    self.sceneTransitionController.gTriggerLevelDisplay = YES;
    self.setUpImageController.showButtons = NO;
}

//called in vfAdaptationDelegate
- (void) taskDemo:(ADScenarioData*)adScen
{
    [self updateVFAdaptationState];
    [self setUpSpeakForGroupName:@"cone"];
}

//called in vfAdaptationDelegate
- (void) startUpDemo:(NSString*)demo
{
    [self updateVFAdaptationState];
    [self setUpSpeakForGroupName:demo];
    
    NSLog(@"check to see receiving string in startup demo method = %@", demo);
    
}

//called in vfadaptationDelegate
-(void) markersLostDemo
{
    [self updateVFAdaptationState];
    [self setUpSpeakForGroupName:@"markerLost"];
    
}



//called in vfadaptationDelegate
-(void) feedbackDemo:(ADScenarioData*)adScen withSelection:(NSString*)demo
{

    if ([demo isEqualToString:@"demoPostVisual"] || [demo isEqualToString:@"demoPostVisualWithLift"]) {
        
        //    [self updateVFAdaptationState];
        if ([demo isEqualToString: @"demoPostVisual"]) self.gVisualFeedback.adaptationDelegate.levelSentByAdaptation = kLevelDemoLevel1;
        if ([demo isEqualToString:@"demoPostVisualWithLift"]) self.gVisualFeedback.adaptationDelegate.levelSentByAdaptation = kLevelDemoLevel1Lift;
        
        [self.gVisualFeedback.adaptationDelegate updateCurrentState];
        [self setUpSpeakForGroupName:demo];

        self.gVisualFeedback.analysis.currentFrame.liftSuccess = NO;
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.useTimeOut = NO;
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.delayDurationInSeconds = 0;
      
        self.gVisualFeedback.level1SceneDrawer.sceneTransitionController.gTriggerLevelDisplay = YES;
    }

    if ([demo isEqualToString: @"demoLevel2Visual"]) {
        //show level 2
        self.gVisualFeedback.analysis.currentFrame.visualTag = vEfficient;
        self.gVisualFeedback.adaptationDelegate.levelSentByAdaptation = kLevelDemoLevel2;
        [self.gVisualFeedback.adaptationDelegate updateCurrentState];
        [self setUpSpeakForGroupName:demo];
        
        self.gVisualFeedback.level2SceneDrawer.sceneTransitionController.useTimeOut = NO;
        self.gVisualFeedback.level2SceneDrawer.sceneTransitionController.delayDurationInSeconds = 0;
        self.gVisualFeedback.level2SceneDrawer.sceneTransitionController.gTriggerLevelDisplay = YES;
    }
    
}







//called in vfadaptationDelegate
-(void) tangibleConnectionDemo:(ADScenarioData *)adScen
{
    [self updateVFAdaptationState];
    [self setUpSpeakForGroupName:@"targetSetup"];

    self.tangibleSetupResultsReceived = NO;

    self.targetSetup.targetTypeLeft = [adScen leftTarget];
    self.targetSetup.targetTypeMid = [adScen middleTarget];
    self.targetSetup.targetTypeRight = [adScen rightTarget];
}

//called in vfanalysis
-(void) tangibleSetup:(NSNotification *) notification
{
    NSDictionary * dict =  (NSDictionary*)([notification object]);
    self.targetSetup.leftTargetIsCorrect = [[dict valueForKey:@"leftTarget"] boolValue];
    self.targetSetup.rightTargetIsCorrect = [[dict valueForKey:@"rightTarget"] boolValue];
    self.targetSetup.middleTargetIsCorrect = [[dict valueForKey:@"middleTarget"] boolValue];

    if (!self.targetSetup.leftTargetIsCorrect  || !self.targetSetup.middleTargetIsCorrect || !self.targetSetup.rightTargetIsCorrect ) {
        self.setUpImageController.showButtons = NO;
        self.setUpTextController.dialogueGroupName = @"wrongTarget";
        self.setUpTextController.dialogueArrayIndex = 0;
        self.enableSpeak = YES;
        
    }
    self.tangibleSetupResultsReceived = YES;
}



-(void)drawTargetSetUp
{
    //managed by
    // tangibleConnectionDemo:(ADScenarioData *)adScen
    // tangibleSetup:(NSNotification *) notification
    
    if ([self.setUpTextController.dialogueGroupName isEqualToString: @"targetSetup" ]||
        [self.setUpTextController.dialogueGroupName isEqualToString: @"wrongTarget"] ) {
        
        
        [self.targetSetup drawTargetDemowithResultsIf:self.tangibleSetupResultsReceived];
        

    }
}

-(void)demoRestPadSound
{
    if ( [self.setUpTextController.dialogueGroupName isEqualToString: @"cone"]) {
        self.setUpTextController.playWristPadSound = YES;
    }
    else {
        self.setUpTextController.playWristPadSound = NO;
    }
}


-(void) drawShape:(GraphicsState *)state
{
    if(self.gVisualFeedback.currEnabledLevel == kLevelDemo || self.gVisualFeedback.currEnabledLevel == kLevelDemoLevel1 ||
       self.gVisualFeedback.currEnabledLevel == kLevelDemoLevel1Lift || self.gVisualFeedback.currEnabledLevel == kLevelDemoLevel2) {
    
        [self manageSceneTransition];
        
        if (self.sceneTransitionController.shouldDrawScene) {
            
            
            
            [self demoRestPadSound];
            
            [self.setUpTextController selectMessageFromGroup:self.setUpTextController.dialogueGroupName
                                                     atIndex:self.setUpTextController.dialogueArrayIndex];
            
            [self.setUpImageController drawImageGroup: self.setUpTextController.dialogueGroupName
                                               WithID: self.setUpTextController.dialogueArrayIndex];

            [self updateCameraLocationForDemoType:self.setUpTextController.dialogueGroupName];

            
            [self drawTargetSetUp];

            [self.setUpTextController drawText];

            if (self.setUpDemoOpacity == 1.0 && self.enableSpeak) {
                [self.setUpTextController speak];
            
            //    [self.setUpTextController.soundController updateDemoSpeechWithName:self.setUpTextController.dialogueGroupName];
                self.enableSpeak = NO;
            }
            
            //ensures speak notification object has been updated based on constraint above
            if (self.setUpDemoOpacity == 1.0) {
                 [self.setUpImageController drawButtonForGroupName:self.setUpTextController.dialogueGroupName];
             }
        
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
}


@end


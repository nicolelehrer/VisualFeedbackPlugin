//
//  VFWindowController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/8/11.
//  Copyright 2011 ASU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VisualFeedback;
@class VFAdaptationDelegate; 
@class VFAnalysis;
@class Dialogue;
@class VFPostSetScenario; 
@class VFPostTrialScenario;
@class VFPostSequenceScenario;
@class Path;
@class TestScenario;
@class VFAdaptationDebug;
@class Level3WaterController;
@class DemoDrawer;

@interface VFWindowController : NSObject {
	        
	NSWindowController	* windowController;	
	IBOutlet NSWindow	* gVFHomeSystemWindow;
	VisualFeedback	* gVisualFeedback;
	VFAdaptationDelegate	* gVFAdaptationDelegate;
	VFAnalysis	* gVFAnalysis;
	Dialogue * gVFDialogue;
    TestScenario * gTestScenario;
	VFAdaptationDebug * gAdaptationDebug;
    
	VFPostTrialScenario * gVFPostTrialScenario;
  	VFPostSetScenario * gVFPostSetScenario;
	VFPostSequenceScenario * gVFPostSequenceScenario;
    
    Level3WaterController * level3WaterController;
    
    DemoDrawer * gDemoDrawer;
    
    
    IBOutlet NSPopUpButton *tagQualityPopup;
    IBOutlet NSPopUpButton *travelQualPopUp;
    
    IBOutlet NSPopUpButton *fogTagQualityPopup;
    IBOutlet NSPopUpButton *popUp;
        
    IBOutlet NSTextField *label;
    NSTextField *stringIDLabelDisplay;
    NSTextField *debugStringIDInputField;
}

- (IBAction)updateEnabledLevel:(id)sender;
- (IBAction)updateFogTagQuality:(id)sender;

- (IBAction)updateTagQuality:(id)sender;

- (IBAction) showWindow:(id)sender;
- (void) setVisualFeedback:(VisualFeedback*)f;

//needs to be accessed by adaptationDelegate - better way?
-(void) updatePopUpWithEnabledLevel;
-(void) updateKillInActiveAnimation;

//needs to be accessed by analysis - better way?
-(void) updatePopUpWithTravelQual;


@property (retain) VisualFeedback * gVisualFeedback;
@property (retain) VFAdaptationDelegate * gVFAdaptationDelegate;
@property (retain) VFAnalysis * gVFAnalysis;

@property (retain) Dialogue * gVFDialogue;

@property (retain) VFPostTrialScenario * gVFPostTrialScenario;
@property (retain) VFPostSetScenario * gVFPostSetScenario;
@property (retain) VFPostSequenceScenario * gVFPostSequenceScenario;
@property (retain) TestScenario * gTestScenario;
@property (retain) VFAdaptationDebug * gAdaptationDebug;

@property (retain) Level3WaterController * level3WaterController;

@property (retain) DemoDrawer * gDemoDrawer;

@property (assign) float changeString;

@property (assign) IBOutlet NSTextField *stringIDLabelDisplay;
@property (assign) IBOutlet NSTextField *debugStringIDInputField;

@end

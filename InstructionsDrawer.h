//
//  InstructionsDrawer.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 2/7/13.
//
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "VisualFeedback.h"
#import "VideoController.h"
#import "ImageController.h"
#import "TargetSetup.h"
#import "TextController.h"

@interface InstructionsDrawer : Transform

@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) VideoController* videoController;
@property(retain) NSDictionary * instructionsDictionary;
@property(retain) ImageController * imageController;
@property(retain) TargetSetup * targetSetup;
@property(retain) TextController * textController;
@property(assign) BOOL tangibleSetupResultsReceived;



@property(assign) float opacity;
-(void) setVisualFeedback:(VisualFeedback *) f;
-(void) tangibleConnectionDemo:(ADScenarioData *)adScen;
-(void) tangibleSetup:(NSNotification *) notification;

@end

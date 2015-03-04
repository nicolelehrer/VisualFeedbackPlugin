//
//  TextController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "SoundController.h"

@interface TextController : NSObject <NSSpeechSynthesizerDelegate>

@property(retain) NSDictionary * dialogueDictionary;
@property(retain) NSArray * taskDemoMessages;

@property(retain) NSString * elementID;

@property(retain) NSSpeechSynthesizer * synth;

@property(assign) int dialogueArrayIndex; 

@property(assign) NSMutableArray * didCompleteCheckList;

@property(assign) float textOpacity;
@property(assign) float textTransX;
@property(assign) float textTransY;
@property(assign) float textTransZ;

@property(retain) NSString * textLine;
@property(retain) NSString * textLineCleaned;

@property(retain) NSString * dialogueGroupName;

@property(retain) StringDisplay * sdText;

@property(retain) SoundController * soundController;

@property(assign) BOOL doneReading;
@property(assign) BOOL playWristPadSound;


- (void) speak;
- (void) updateTextWithString:(NSString *)currentString;
- (void) drawText;
- (void) selectMessageFromGroup:(NSString *)arrayName atIndex:(int)arrayIndex;


@end

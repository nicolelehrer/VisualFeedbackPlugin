//
//  VFAdaptation.h
//  DemoAnalysis
//
//  Created by Nicole Lehrer on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


 
#import <Foundation/Foundation.h>


@protocol AdaptationVisualFeedbackProtocol 

- (void) adaptationTargetID:(int)target;
- (void) adaptationState:(int)vState;
- (void) adaptationZPrimeOver:(float)zOver;
- (void) adaptationDialogueContent:(int)dialogueNum;

@end



@interface VFAdaptation : NSObject

@property(assign) id analysis;

@end

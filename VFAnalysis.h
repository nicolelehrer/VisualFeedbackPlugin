//
//  VFAnalysis.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  recieves data from MotionAnalysisPlugin 

#import <Cocoa/Cocoa.h>
//#import "DAAnalysisFrame.h"

@class VisualFeedback;
@class VFAnalysisFrame;
@class TravelController;

@interface VFAnalysis : NSObject {
	
    VisualFeedback * gVisualFeedback;
    VFAnalysisFrame * currentFrame;
    TravelController * testControl;	

    
    
    

    

}

 
@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) VFAnalysisFrame * currentFrame;
@property(retain) TravelController * testControl; 
@property(assign) int previousState;
@property(assign) int targetUpdateID;
@property(assign) BOOL portableTargetIsInWrongPlace;

-(void) setVisualFeedback:(VisualFeedback *)f;
-(void) receiveNotifyMoveTarget:(NSNotification *) notification;


@end

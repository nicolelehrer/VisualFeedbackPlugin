//
//  Level3SceneController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level3SceneController.h"

@implementation Level3SceneController

@synthesize singleTravelSegment = _singleTravelSegment;

@synthesize transportQuality1 = _transportQuality1;
@synthesize transportQuality2 = _transportQuality2;
@synthesize manipQuality1 = _manipQuality1;
@synthesize manipQuality2 = _manipQuality2;


//@synthesize travelController0 = _travelController0;
//@synthesize travelController1 = _travelController1;
//@synthesize stopController0 = _stopController0;
//@synthesize stopController1 = _stopController1;


- (id)init
{
    self = [super init];
    
    if (self != nil) {
        
        [self createTravelController];
        
    }
    return self;
}


-(void) createTravelController
{
//    self.singleTravelSegment = [[TravelController alloc] initWithStartValue:0 andEndValue:13000 andDurationInSec:11];
    self.singleTravelSegment = [[TravelController alloc] initWithStartValue:0 andEndValue:26000 andDurationInSec:11];
    
}

-(void) resetDisplacement
{
    [self.singleTravelSegment resetDisplacementFast];
    
}



-(void) dealloc
{
    [super dealloc];
    [self.singleTravelSegment release];
}

@end

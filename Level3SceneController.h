//
//  Level3SceneController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelController.h"
#import "Level3WaterController.h"

@interface Level3SceneController : NSObject

@property(assign) float transportQuality1;
@property(assign) float transportQuality2;
@property(assign) float manipQuality1;
@property(assign) float manipQuality2;

@property(assign) TravelController * singleTravelSegment;

//@property(retain) TravelController * travelController0;
//@property(retain) TravelController * travelController1;
//@property(retain) TravelController * stopController0;
//@property(retain) TravelController * stopController1;



-(void) resetDisplacement;


@end

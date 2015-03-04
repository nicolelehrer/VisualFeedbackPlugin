//
//  Level2WaterController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "WaterSheet.h"
#import "MALevel2FeedbackData.h"

@interface Level2WaterController : NSObject

@property(assign) float opacityAdjustForTag;
@property(retain) WaterSheet * waterSheet;
@property(retain) WaterSheet * waterSheet2;

@property(retain) DTime * timekeeper;

-(void) drawWaterWithTag:(VisualLevel2Content)tag andLiftTag:(VisualLevel2Content)liftTag;

@end

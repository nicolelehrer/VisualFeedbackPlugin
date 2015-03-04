//
//  Level1WaterController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Transform.h"

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "WaterSheet.h"

@interface Level1WaterController : NSObject

@property(retain) WaterSheet * waterSheet;
@property(retain) DTime * timekeeper;

-(void) drawWater;

@end

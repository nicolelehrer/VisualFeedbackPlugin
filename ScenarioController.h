//
//  ScenarioController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisualFeedback.h"
#import "ScenarioDrawer.h"

#import "Level2SceneDrawer.h"

@interface ScenarioController : NSObject

- (id)init;
- (void) setVisualFeedback:(VisualFeedback *)f;

@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) ScenarioDrawer * scenarioDrawer;
@end

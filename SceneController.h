//
//  SceneController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VisualFeedback.h"
#import "Level2SceneDrawer.h"

@interface SceneController : NSObject

- (id)init;
- (void) setVisualFeedback:(VisualFeedback *)f;

@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) Level2SceneDrawer * level2SceneDrawer;

@end

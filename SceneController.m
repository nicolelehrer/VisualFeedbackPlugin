//
//  SceneController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneController.h"

@implementation SceneController

@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize level2SceneDrawer = _level2SceneDrawer;


- (id)init
{
self = [super init];
if (self != nil) {
    
    [self createLevel2SceneDrawer];
    NSLog(@"sceneController created");
}
return self;
}

-(void) createLevel2SceneDrawer
{
    self.level2SceneDrawer = [Level2SceneDrawer createWithName:@"Level2SceneDrawer" parent:[Dash root]];
}


- (void) setVisualFeedback:(VisualFeedback *)f
{
    self.gVisualFeedback = f;
}


-(void) dealloc
{
    [super dealloc];
    [self.level2SceneDrawer release];
}

@end

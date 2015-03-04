//
//  ScenarioController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScenarioController.h"

@implementation ScenarioController

@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize scenarioDrawer = _scenarioDrawer;


- (id)init
{
	self = [super init];
    if (self != nil) {
        
        [self createScenarioDrawer];
        NSLog(@"sceneController created");
    }
	return self;
}





-(void) createScenarioDrawer
{
    self.scenarioDrawer = [ScenarioDrawer createWithName:@"ScenarioDrawer" parent:[Dash root]];
}


-(void) setScenarioVisible
{
    self.scenarioDrawer.visible = NO;
}


- (void) setVisualFeedback:(VisualFeedback *)f
{
	self.gVisualFeedback = f;
}


-(void) dealloc
{
    [super dealloc];
    [self.scenarioDrawer release];
    
}

@end

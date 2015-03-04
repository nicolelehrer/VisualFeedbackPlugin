//
//  FeedbackDemo.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/29/12.
//
//

#import "FeedbackDemo.h"



@interface FeedbackDemo ()


@end

@implementation FeedbackDemo


- (id)init
{
	self = [super init];
    if (self) {
        
    }
	return self;
}



-(int) showFeedbackSceneForDemoType:(NSString*)demoType
{
    int level = 0;
    if ([demoType isEqualToString: @"demoPostVisual"]) {
        level = 1;
    }
    if ([demoType isEqualToString: @"demoLevel2Visual"]) {
        level = 2;
    }
    
    return level;
}

@end

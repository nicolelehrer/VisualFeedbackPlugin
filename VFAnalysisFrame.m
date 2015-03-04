//
//  VFAnalysisFrame.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VFAnalysisFrame.h"

@implementation VFAnalysisFrame

@synthesize firstTarget;

@synthesize visualTag;
@synthesize liftTag;

@synthesize binNumber;

@synthesize horizPosMagnitudes;
@synthesize horizPosCategories;
@synthesize horizNegMagnitudes;
@synthesize horizNegCategories;

@synthesize vertPosMagnitudes;
@synthesize vertPosCategories;	
@synthesize vertNegMagnitudes;
@synthesize vertNegCategories;	    

@synthesize horizDisplacementsOfPosVerticals;
@synthesize horizDisplacementsOfNegVerticals;

@synthesize visualPostSetTag;

@synthesize stateFromAnalysis;

@synthesize overShootPositive;
@synthesize overShootNegative;

@synthesize liftSuccess;

@synthesize manipQualityTargetID1 = _manipQualityTargetID1;
@synthesize manipQualityTargetID2 = _manipQualityTargetID2;
@synthesize manipQualityTargetID3 = _manipQualityTargetID3;
@synthesize manipQualityTargetID4 = _manipQualityTargetID4;



@synthesize enableFog = _enableFog;
@synthesize fogLevel = _fogLevel;

@synthesize pathBins = _pathBins;

- (id)init
{
	self = [super init];
    if (self) {
    				
		self.pathBins = [[NSMutableArray alloc] initWithCapacity:20];
        
        int i;
        for(i=0; i<20; i++){
            [self.pathBins addObject:[[PathFeatures alloc] init]];
        }

        
        NSLog( @"init VFAnalysisFrame");
      
	}
	return self;
}


- (void) dealloc
{
	[super dealloc];
}


@end

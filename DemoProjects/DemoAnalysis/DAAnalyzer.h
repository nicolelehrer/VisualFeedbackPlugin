//
//  DAAnalyzer.h
//  DemoAnalysis
//
//  Created by Loren Olson on 11/22/11.
//  Copyright (c) 2011 AME. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <unistd.h>
#import "DAController.h"

@class DAAnalysisFrame;

@interface DAAnalyzer : NSObject<DemoAnalysisProtocol> {
    
    // private
	useconds_t waitTimeInMicroseconds;
	float tick;
}

@property(retain) DAAnalysisFrame * currentFrame;
@property(assign) BOOL active;
@property(assign) float fluxScale;

@end

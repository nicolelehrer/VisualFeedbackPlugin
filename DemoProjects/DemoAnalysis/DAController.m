//
//  DAController.m
//  DemoAnalysis
//
//  Created by Loren Olson on 11/22/11.
//  Copyright (c) 2011 AME. All rights reserved.
//

#import "DAController.h"

@implementation DAController


@synthesize analysis = _analysis;


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (IBAction)switchAnalysisOn:(id)sender
{
    [self.analysis demoAnalyisActive:YES];
}

- (IBAction)switchAnalysisOff:(id)sender
{
    [self.analysis demoAnalyisActive:NO];
}



@end

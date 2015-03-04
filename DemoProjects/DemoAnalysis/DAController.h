//
//  DAController.h
//  DemoAnalysis
//
//  Created by Loren Olson on 11/22/11.
//  Copyright (c) 2011 AME. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DemoAnalysisProtocol 

- (void)demoAnalyisActive:(BOOL)status;
- (void)demoAnalyisSensitivity:(float)value;

@end



@interface DAController : NSObject

@property(assign) id analysis;

@end

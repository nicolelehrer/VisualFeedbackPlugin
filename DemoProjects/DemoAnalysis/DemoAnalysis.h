//
//  DemoAnalysis.h
//  DemoAnalysis
//
//  Created by Loren Olson on 11/2/11.
//  Copyright 2011 AME. All rights reserved.
//
//  This class implements a general purpose, non-descript Dash plugin named DemoAnalysis.

#import <Cocoa/Cocoa.h>
#import "DashHeaders.h"


@class DAAnalyzer;
@class DAController;


//
// Any Dash plugin must implement the DashPluginProtocol formal protocol.
// If the class doesn't implement this protocol, the bundle will not be loaded.
//
@interface DemoAnalysis : NSObject <DashPluginProtocol>

@property(retain) DAAnalyzer * analyzer;
@property(retain) DAController * controller;
 

// class methods
+ (DemoAnalysis *)sharedDemoAnalysis;
+ (BOOL) initializePlugin:(NSBundle *)bundle;


@end

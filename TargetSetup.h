//
//  TargetSetup.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/28/12.
//
//

#import <Foundation/Foundation.h>
#import "ADMainController.h"

@interface TargetSetup : NSObject

-(void) drawTargetDemowithResultsIf:(BOOL)readyToAssess;
-(void) drawCylinderPlacementReminderAtLocation:(TargetSelection)targetLocation;
-(void) drawConePlacementReminderAtLocation:(TargetSelection)targetLocation;

-(void) drawStaticTable;
-(void) drawWhiteTableSizedBG;

-(void)drawLevel3ReminderForTarget1:(TargetSelection)targetLocation1 andTarget2:(TargetSelection)targetLocation2;
-(void)drawOnlyConePlacementWithNoTableAtLocation:(TargetSelection)targetLocation;

@property float sceneOpacity;

@property (assign) TargetTypes targetTypeLeft;
@property (assign) TargetTypes targetTypeMid;
@property (assign) TargetTypes targetTypeRight;

@property(assign) BOOL leftTargetIsCorrect;
@property(assign) BOOL middleTargetIsCorrect;
@property(assign) BOOL rightTargetIsCorrect;
@property(assign) BOOL transportEnabledIsCorrect;

@property(assign) NSString * speechTag;

@property(assign) int targetID1ForL3;
@property(assign) int targetID2ForL3;
@property(assign) BOOL isTransportTask;

@end

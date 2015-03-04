//
//  Path.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/25/12.
//
//

#import <Foundation/Foundation.h>
#import "WaterSheet.h"


@interface Path : NSObject

-(void) drawErrorPathComponents;
-(void) drawTexturesInPath;
-(void) refreshTexureIDsAndScatterValues;
-(void) drawVerticalErrorPathComponents;
-(void) drawFirstRocks; 

@property(retain) NSMutableArray * pathBins;
@property(assign) float transX;
@property(assign) float transY;
@property(assign) float transZ;
@property(assign) float rotX;
@property(assign) float rotY;
@property(assign) float rotZ;
@property(assign) float opacity;
@property(assign) float pathZprimeSpread;
@property(assign) float  pathSlope;
@property(assign) float scatterMagnitude;
@property(retain) WaterSheet * underWaterRock;
@property(assign) int binNumber;

@end

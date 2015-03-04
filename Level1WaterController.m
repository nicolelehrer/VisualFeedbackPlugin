//
//  Level1WaterController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level1WaterController.h"

@implementation Level1WaterController

@synthesize waterSheet = _waterSheet;
@synthesize timekeeper = _timekeeper;

- (id)init
{
	self = [super init];
    
    if (self != nil) {
        
        [self createWaterSheet];
        [self setUpWaterSheet];
        
        
    }
	return self;
}

-(void) createWaterSheet
{
    self.waterSheet = [WaterSheet createWithName:@"PostTrialWaterSheet" parent:[Dash root] withGridDimsX:300 andY:300 withShaderName:@"WavesLevel1"];
}


-(void) setUpWaterSheet
{    
    
    self.waterSheet.scaledX = 1.8;
    self.waterSheet.scaledY = 1;
    self.waterSheet.scaledZ = 1;
    
    
    self.waterSheet.transX = 0;
 	self.waterSheet.transY = -3595.285;//-1734;
	self.waterSheet.transZ = 2500;//5600;
	self.waterSheet.rotX = -40;//-19;	
    
    
	self.waterSheet.ampX = 5;
	self.waterSheet.ampY = 2.631579;
	
	self.waterSheet.freqX = 13;
	self.waterSheet.freqY = .2105;
	
	self.waterSheet.timeFactorX = 2;
	self.waterSheet.timeFactorY = 5;
	
	self.waterSheet.useHeightCalc = 0;	
    
    self.waterSheet.opacity = 0;
    
    self.waterSheet.redValue = 1.0;
    self.waterSheet.greenValue = 1.0;
    self.waterSheet.blueValue = 1.0;
    
}

-(void) drawWater
{
    glPushMatrix();
    [self.waterSheet drawWater];
    glPopMatrix();
}

-(void) dealloc
{
    [super dealloc];
    [self.waterSheet release];
    
}

@end

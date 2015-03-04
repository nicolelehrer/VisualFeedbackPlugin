//
//  Level2WaterController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level2WaterController.h"

@implementation Level2WaterController

@synthesize waterSheet = _waterSheet;
@synthesize waterSheet2 = _waterSheet2;

@synthesize timekeeper = _timekeeper;
@synthesize opacityAdjustForTag = _opacityAdjustForTag;

- (id)init
{
	self = [super init];
    
    if (self != nil) {
        
        [self createWaterSheet];
        [self setUpWater];

        
    }
	return self;
}

-(void) createWaterSheet
{
    self.waterSheet = [WaterSheet createWithName:@"level2Water" parent:[Dash root] withGridDimsX:200 andY:100 withShaderName:@"WavesLevel2"];
    
     self.waterSheet2 = [WaterSheet createWithName:@"level2Water" parent:[Dash root] withGridDimsX:200 andY:100 withShaderName:@"WavesLevel2"];
}


-(void) setUpWater
{
    self.waterSheet.transX = 0;
	self.waterSheet.transY = -4952;
	self.waterSheet.transZ = 880;
	self.waterSheet.rotX = -80;	
	
	self.waterSheet.scaledX = 3; 
	self.waterSheet.scaledY = 3; 
	self.waterSheet.scaledZ = 1; 
	
	self.waterSheet.ampX = 2;
	self.waterSheet.ampY = 0;
	
	self.waterSheet.freqX = -26.69643;
	self.waterSheet.freqY = -0.07079012;
	self.waterSheet.timeFactorX = 1.4;
	self.waterSheet.timeFactorY = 3;
	
	self.waterSheet.seg = 2.0;
	self.waterSheet.useHeightCalc = 0;
    
    self.waterSheet.opacity = 0;
    
    self.waterSheet.redValue = 1.0;
    self.waterSheet.greenValue = 1.0;
    self.waterSheet.blueValue = 1.0;
    
    
    
    
    self.waterSheet2.transX = 0;
	self.waterSheet2.transY = -4952;
	self.waterSheet2.transZ = 880;
	self.waterSheet2.rotX = -80;
	
	self.waterSheet2.scaledX = 3;
	self.waterSheet2.scaledY = 3;
	self.waterSheet2.scaledZ = 1;
	
	self.waterSheet2.ampX = 0;
	self.waterSheet2.ampY = 0;
	
	self.waterSheet2.freqX = -26.69643;
	self.waterSheet2.freqY = -0.07079012;
	self.waterSheet2.timeFactorX = 1;
	self.waterSheet2.timeFactorY = 3;
	
	self.waterSheet2.seg = 2.0;
	self.waterSheet2.useHeightCalc = 1;
    
    self.waterSheet2.opacity = 0;
    
    self.waterSheet2.redValue = 1.0;
    self.waterSheet2.greenValue = 1.0;
    self.waterSheet2.blueValue = 1.0;


    
}


-(void) drawWaterWithTag:(VisualLevel2Content)tag andLiftTag:(VisualLevel2Content)liftTag 
{
    BOOL useWaterOverlay;
    
    if (tag != vBlank) {
        
        if (tag == vGraspIncomplete ||
            tag == vGraspMild) {
            useWaterOverlay = NO;
            self.waterSheet.useGreenLightReflection = NO;
            self.waterSheet2.useGreenLightReflection = NO;
            self.opacityAdjustForTag = .3;
        }
        
        else if (tag == vGraspComplete) {
            useWaterOverlay = NO;
            self.waterSheet.useGreenLightReflection = YES;
            self.waterSheet2.useGreenLightReflection = YES;
            self.opacityAdjustForTag = 1;
        }
        
        else {
            
            useWaterOverlay = YES;
            self.opacityAdjustForTag = 1.0;
            self.waterSheet.useGreenLightReflection = NO;
            self.waterSheet2.useGreenLightReflection = NO;

        }
        
        glPushMatrix();
        [self.waterSheet drawWater];
        glPopMatrix();
        
        glPushMatrix();
        [self.waterSheet drawDepthOverlay];
        glPopMatrix();
    }
    if (useWaterOverlay) {

        self.waterSheet2.ampX = 2.0*self.waterSheet2.opacity;
        glPushMatrix();
            [self.waterSheet2 drawWater];
        glPopMatrix();
    }

}


-(void) dealloc
{
    [super dealloc];
    [self.waterSheet release];

}

@end

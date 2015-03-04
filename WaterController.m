//
//  WaterController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WaterController.h"

@implementation WaterController

@synthesize waterTexture = _waterTexture;
@synthesize waterSheet = _waterSheet;
@synthesize travelController = _travelController;
@synthesize waterSheetDepthOverlap = _waterSheetDepthOverlap;
@synthesize waterSheetHeightOverlap = _waterSheetHeightOverlap;
@synthesize waterOpacity = _waterOpacity;

- (id)init
{
	self = [super init];
    
    if (self != nil) {
        
        
        self.waterSheetDepthOverlap = 976 + 1500;
        
        [self createTextures];
        [self createWaterSheet];
        [self setUpWaterControls];
        [self createTravelController];
    }
	return self;
}


-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];

	self.waterTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/whiteSquare.png"] target:GL_TEXTURE_2D];
}

-(void) createWaterSheet
{
    self.waterSheet = [WaterScape createWithName:@"WaterScape" parent:[Dash root] withGridDims:100 andShaderID:2];
}

-(void) setUpWaterControls
{
    self.waterOpacity = 1;
    
    self.waterSheet.scaledX = 2; 
    self.waterSheet.scaledY = 2; 
    self.waterSheet.scaledZ = 1; 
    self.waterSheet.rotX = -89; 	
    self.waterSheet.rotY =   0;
    self.waterSheet.ampX = 2.631579;
    self.waterSheet.ampY = 2.631579;
    self.waterSheet.freqX = 1;
    self.waterSheet.freqY = .1855;
    self.waterSheet.timeFactorX = 19.65;
    self.waterSheet.timeFactorY = 3;
    self.waterSheet.seg = 2.0;
    self.waterSheet.useHeightCalc = 1;
}

-(void) createTravelController
{
    self.travelController = [[TravelController alloc] initWithStartValue:0 andEndValue:5000 andDurationInSec:8];
}

-(void) resetDisplacement
{
    [self.travelController resetDisplacementFast];
}

       
-(void) drawWater
{
    int i; 
    for (i=0; i<5; i++)
    {     
        float displacementDepth = -[self.travelController calcDisplacement]-self.waterSheetDepthOverlap*i;
        
        self.waterSheet.transX = 0;
        self.waterSheet.transY = -displacementDepth;
        self.waterSheet.transZ = 0;
                
        [self.waterSheet drawWaterWithTextureType1:self.waterTexture andTextureType2:self.waterTexture andOpacity:self.waterOpacity];
        
    }
    
}

-(void) dealloc
{
    [super dealloc];
}


@end

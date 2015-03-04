//
//  Path.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/22/11.
//  Copyright 2011 ASU. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DashHeaders.h"
#import "Transform.h"
#import "Texture2d.h"



@interface PathController : NSObject{

    float imageScalarX;
    float imageScalarY; 
    
    NSMutableArray * textureIDList4;
	NSMutableArray * textureIDList3;
	NSMutableArray * textureIDList2;
	NSMutableArray * textureIDList1;
	
	NSMutableArray * posHorizDisplacement;
	NSMutableArray * posVertDisplacement_posHoriz;
    NSMutableArray * posVertDisplacement_negHoriz;
    
	NSMutableArray * negHorizDisplacement;
	NSMutableArray * negVertDisplacement_posHoriz;
	NSMutableArray * negVertDisplacement_negHoriz;
    
	NSMutableArray * posHorizCategory;
	NSMutableArray * posVertCategory_posHoriz;
    NSMutableArray * posVertCategory_negHoriz;
    
	NSMutableArray * negHorizCategory;
	NSMutableArray * negVertCategory_posHoriz;
	NSMutableArray * negVertCategory_negHoriz;
    
    NSMutableArray * posVertDisplacement;
    NSMutableArray * posVertCategory;
    NSMutableArray * negVertDisplacement;
    NSMutableArray * negVertCategory;
    
    NSMutableArray * horizDirectionAtNegVert;
    NSMutableArray * horizDirectionAtPosVert;
    
    
    
	//errorRocks
    float amplitude;
    
	float pathZprimeSpread;
	float pathSlope;
	float zPrimeError;
	
	float horizShift;
	float horizErrorAmper;
	float vertShift;
	
	float scatterMag;
	float totalRocks;
	
	float errorDuration;
	float rotateRocks;
	
	float scaleZone1;
	float scaleZone2;
	float scaleZone3;
	float scaleZone4;
	float scaleZone5;
	float scaleZone6;
	float scaleZone7;
	float scaleZone8;
	
	float imageHeightRocks;
	float imageWidthRocks;
	
	int binNumber;
	int filterType;
	int targetDescriptor;
	
	NSArray * scaleFactors;
	
	
	
	
	float magHoriz[50];
	float catHoriz[50];
	float magVert[50];
	float catVert[50];
	
	float magHorizNeg[50];
	float catHorizNeg[50];
	float magVertNeg[50];
	float catVertNeg[50];
	
	float scatterGain;
	float scatter[50];
	int texNumberList[50];
	int texNumberList2[50];
	int texNumberList3[50];
	int texNumberList4[50];	
	
	float scatterError[50];
	float scatterError2[50];
	int segmentArray[12];
	
	float transX;
	float transY;
	float transZ;
	
	float rotX;
	float rotY;
	float rotZ;
	
	float testOpacityDepreciation;
    
    float errorAmp;
    float errorAmp2;
    float errorAmp3;
    float errorAmp4;
    
    float errorAmpFactor;
    float errorAmpFactor2;
    float errorAmpFactor3;
    float errorAmpFactor4;
    float errorAmpFactor5;
    float errorAmpFactor6;
    
    BOOL enableTallRocks;
	
    
    float plotCenterX;
    float plotCenterY;
    float plotScaleX;
    float plotScaleY;
    
    BOOL caseDefaultColor;
    
    float scaleAdder1;
    float scaleAdder2;
    float scaleAdder3;
    float scaleAdder4;
    float scaleAdder5;
    float scaleAdder6;
    float scaleAdder7;
    float scaleAdder8;
    float scaleAdder9;
    
    int mappingChange;
    int mappingChangeAtBin;

    float opacity;
    
    

} 



-(void) drawTexturesDisplacedFromPath;
-(void) drawTexturesInPath;
-(void) drawPlotWithState:(GraphicsState *)state andOpacity:(float)adaptableOpacity;
-(void) mixTextures;

@property (retain) DTime *	timekeeper;

@property (retain) Texture2d *	g5glim1;
@property (retain) Texture2d *	g5glim2;

@property (assign)  float rocksScaleX;
@property (assign)  float rocksScaleY;

@property (assign)     float opacity;




@property (retain) NSMutableArray * greenTextures;
@property (retain) NSMutableArray * yellowTextures;
@property (retain) NSMutableArray * redTextures;
@property (retain) NSMutableArray * tallYellowTextures;
@property (retain) NSMutableArray * tallRedTextures;
@property (retain) NSMutableArray * shallowRedTextures;
@property (retain) NSMutableArray * shallowYellowTextures;


@property (retain) 	NSMutableArray * textureIDList4;
@property (retain) 	NSMutableArray * textureIDList3;
@property (retain) 	NSMutableArray * textureIDList2;
@property (retain) 	NSMutableArray * textureIDList1;

@property (retain) NSMutableArray * posHorizDisplacement;
@property (retain) NSMutableArray * posVertDisplacement_posHoriz;
@property (retain) NSMutableArray * posVertDisplacement_negHoriz;

@property (retain) NSMutableArray * negHorizDisplacement;
@property (retain) NSMutableArray * negVertDisplacement_posHoriz;
@property (retain) NSMutableArray * negVertDisplacement_negHoriz;

@property (retain) NSMutableArray * posHorizCategory;
@property (retain) NSMutableArray * posVertCategory_posHoriz;
@property (retain) NSMutableArray * posVertCategory_negHoriz;

@property (retain) NSMutableArray * negHorizCategory;
@property (retain) NSMutableArray * negVertCategory_posHoriz;
@property (retain) NSMutableArray * negVertCategory_negHoriz;

@property (retain) NSMutableArray * posVertDisplacement;
@property (retain) NSMutableArray * posVertCategory;
@property (retain) NSMutableArray * negVertDisplacement;
@property (retain) NSMutableArray * negVertCategory;

@property (retain) NSMutableArray * horizDirectionAtNegVert;
@property (retain) NSMutableArray * horizDirectionAtPosVert;


@property (assign) float imageScalarX;
@property (assign) float imageScalarY; 

@property (retain) NSArray * scaleFactors;

@property(assign) float pathZprimeSpread;
@property(assign) float  pathSlope;
@property(assign) float  zPrimeError;

@property(assign) float amplitude;


@property(assign) float  horizShift;
@property(assign) float  horizErrorAmper;
@property(assign) float  vertShift;


@property(assign) float  heightToWidthRatio;
@property(assign) float  ampHeightFactor;

@property(assign) float  scatterGain;
@property(assign) float  scatterMag;
@property(assign) float  totalRocks;

@property(assign) float  errorDuration;
@property(assign) float  rotateRocks;

@property(assign) float  scaleZone1;
@property(assign) float  scaleZone2;
@property(assign) float  scaleZone3;
@property(assign) float  scaleZone4;
@property(assign) float  scaleZone5;
@property(assign) float  scaleZone6;
@property(assign) float  scaleZone7;
@property(assign) float  scaleZone8;

@property(assign) float errorAmpFactor;
@property(assign) float errorAmpFactor2;
@property(assign) float errorAmpFactor3;
@property(assign) float errorAmpFactor4;
@property(assign) float errorAmpFactor5;
@property(assign) float errorAmpFactor6;


@property(assign) float  imageHeightRocks;
@property(assign) float  imageWidthRocks;


@property(assign) int binNumber;
@property(assign) int filterType;
@property(assign) int targetDescriptor;

@property(assign) float transX;
@property(assign) float transY;
@property(assign) float transZ;

@property(assign) float rotX;
@property(assign) float rotY;
@property(assign) float rotZ;


@property(assign) float errorAmp;
@property(assign) float errorAmp2;
@property(assign) float errorAmp3;
@property(assign) float errorAmp4;


@property(assign) float testOpacityDepreciation;

@property(assign)     BOOL enableTallRocks;


@property(assign)     float plotCenterX;
@property(assign)     float plotCenterY;
@property(assign)     float plotScaleX;
@property(assign)     float plotScaleY;

@property(assign)     BOOL caseDefaultColor;


@property(assign)   float scaleAdder1;
@property(assign)   float scaleAdder2;
@property(assign)   float scaleAdder3;
@property(assign)   float scaleAdder4;
@property(assign)   float scaleAdder5;
@property(assign)   float scaleAdder6;
@property(assign)   float scaleAdder7;
@property(assign)   float scaleAdder8;
@property(assign)   float scaleAdder9;

@property(assign)     int mappingChange;
@property(assign)     int mappingChangeAtBin;

@property(assign)   float scaleNegYValleyX;
@property(assign)   float scaleNegYValleyY;


@property(assign)   float group1Magnitudes;
@property(assign)   float group2Magnitudes;
@property(assign)   float group3Magnitudes;
@property(assign)   float group4Magnitudes;

@property(assign)   float group1Categories;
@property(assign)   float group2Categories;
@property(assign)   float group3Categories;
@property(assign)   float group4Categories;

@property(assign)   BOOL testHorizGroup1;
@property(assign)   BOOL testHorizGroup2;
@property(assign)   BOOL testHorizGroup3;
@property(assign)   BOOL testHorizGroup4;

@property(assign)   BOOL testVertGroup1;
@property(assign)   BOOL testVertGroup2;
@property(assign)   BOOL testVertGroup3;
@property(assign)   BOOL testVertGroup4;


@end

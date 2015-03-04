//
//  WaterSheet.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"

@interface WaterSheet : Transform


@property(assign) float * vert_array;
@property(assign) float * text_array;

@property(retain) NSString * selectedShaderName;

@property(assign) int tilex;
@property(assign) int tiley;


@property(assign) float opacity;

@property(retain) Texture2d * level1Water;
@property(retain) Texture2d * level2Water;
@property(retain) Texture2d * level2WaterLight;

@property(retain) Texture2d * level3WaterColor;
@property(retain) Texture2d * level3WaterNoColor;
@property(retain) Texture2d * level3FoamyWater;

@property(assign) int useColor;

@property(retain) Texture2d * depthOverlayTexture;
@property(retain) Shader *	selectedShader;

@property(retain) Shader *	shaderWave0;
@property(retain) Shader *	shaderWave1;
@property(retain) Shader *	shaderWave2;

@property(retain) DTime * timekeeper;

@property(assign) float * vertexData;
@property(assign) float * textureData;

@property(assign) float corner1x;
@property(assign) float corner2x;
@property(assign) float corner1y;
@property(assign) float corner2y;

@property(assign) float gridSizeX;
@property(assign) float gridSizeY;

@property(assign) float textureSizeX;
@property(assign) float textureSizeY;

@property(assign) int rowCount;
@property(assign) int colCount;

@property(assign) float x;
@property(assign) float y;

@property(assign) int numVertices;


//water properties
@property(assign) float timeOffsetX;

@property(assign) float ampX;
@property(assign) float freqX;

@property(assign) float ampY;
@property(assign) float freqY;

@property(assign) float ctimeShift;  

@property(assign) float timeShiftWaveX;  
@property(assign) float timeShiftWaveY; 

@property(assign) float timeFactorX;
@property(assign) float timeFactorY;

@property(assign) float animateSpeed;  	

@property(assign) float seg;
@property(assign) float slope;
@property(assign) int useHeightCalc;

@property(assign) float transX;
@property(assign) float transY;
@property(assign) float transZ;

@property(assign) float rotX;
@property(assign) float rotY;
@property(assign) float rotZ;

@property(assign) float scaledX;
@property(assign) float scaledY;
@property(assign) float scaledZ;

@property(assign) float vecCalcType;
@property(assign) float colorFactor;

@property(assign) float redValue;
@property(assign) float greenValue;
@property(assign) float blueValue;
@property(assign) float opacityFactor;

@property(assign) BOOL useGreenLightReflection;

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent withGridDimsX:(int)gridX andY:(int)gridY withShaderName:(NSString *) shaderName;
- (void) drawWater;
-(void) drawDepthOverlay;
-(void) drawUnderWaterObjectWithTexture:(Texture2d*)texture
                                 WithScaleX:(float)scaledX
                             WithScaleY:(float)scaledY
                          WithPositionX:(float)positionX
                          WithPositionY:(float)positionY
                          WithPositionZ:(float)positionZ
                          WithRotationX:(float)rotX;

@end


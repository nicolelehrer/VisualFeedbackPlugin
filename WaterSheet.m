//
//  WaterSheet.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WaterSheet.h"

@implementation WaterSheet

@synthesize vecCalcType;
@synthesize colorFactor;

@synthesize useColor = _useColor;
@synthesize tilex = _tilex;
@synthesize tiley = _tiley;

@synthesize selectedShaderName  = _selectedShaderName;

@synthesize vert_array = _vert_array;
@synthesize text_array = _text_array;

@synthesize opacity = _opacity;

@synthesize level1Water = _level1Water;
@synthesize level2Water = _level2Water;
@synthesize level2WaterLight = _level2WaterLight;

@synthesize level3WaterColor = _level3WaterColor;
@synthesize level3WaterNoColor = _level3WaterNoColor;
@synthesize level3FoamyWater = _level3FoamyWater;

@synthesize depthOverlayTexture = _depthOverlayTexture;
@synthesize selectedShader = _selectedShader;

@synthesize shaderWave0 = _shaderWave0;
@synthesize shaderWave1 = _shaderWave1;
@synthesize shaderWave2 = _shaderWave2;

@synthesize timekeeper = _timekeeper;

@synthesize vertexData = _vertexData;
@synthesize textureData = _textureData;

@synthesize corner1x = _corner1x;
@synthesize corner2x = _corner2x;
@synthesize corner1y = _corner1y;
@synthesize corner2y = _corner2y;

@synthesize gridSizeX = _gridSizeX;
@synthesize gridSizeY = _gridSizeY;

@synthesize textureSizeX= _textureSizeX;
@synthesize textureSizeY = _textureSizeY;

@synthesize rowCount = _rowCount;
@synthesize colCount = _colCount;

@synthesize x = _x;
@synthesize y = _y;

@synthesize numVertices = _numVertices;

//water properties 
@synthesize ampX = _ampX;
@synthesize freqX = _freqX;

@synthesize ampY = _ampY;
@synthesize freqY = _freqY;

@synthesize ctimeShift = _ctimeShift;  

@synthesize timeShiftWaveX = _timeShiftWaveX;  
@synthesize timeShiftWaveY = _timeShiftWaveY;

@synthesize timeFactorX = _timeFactorX;
@synthesize timeFactorY = _timeFactorY;

@synthesize animateSpeed = _animateSpeed;  	

@synthesize seg = _seg;
@synthesize slope = _slope;
@synthesize useHeightCalc = _useHeightCalc;

@synthesize transX = _transX;
@synthesize transY = _transY;
@synthesize transZ = _transZ;

@synthesize rotX = _rotX;
@synthesize rotY = _rotY;
@synthesize rotZ = _rotZ;

@synthesize scaledX = _scaledX;
@synthesize scaledY = _scaledY;
@synthesize scaledZ = _scaledZ;

@synthesize timeOffsetX = _timeOffsetX;

@synthesize redValue = _redValue;
@synthesize blueValue = _blueValue;
@synthesize greenValue = _greenValue;
@synthesize opacityFactor = _opacityFactor;

@synthesize useGreenLightReflection = _useGreenLightReflection;

#pragma mark ---- class methods ----


// This class method is called one time, after the plugin bundle is loaded by Dash.
// Dash loads plugins as the last step of its startup procedure. It will look thru a 
// user configurable list of folder paths, and load any bundles that implement the 
// DashPluginProtocol.


// factory method
+ (id) createWithName:(NSString *)aName parent:(Node *)aParent withGridDimsX:(int)gridX andY:(int)gridY withShaderName:(NSString *) shaderName
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
//	logDebug( @"YadaYada.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	WaterSheet * node = [[WaterSheet alloc] initWithName:aName parent:aParent withGridDimsX:gridX andY:gridY withShaderName:shaderName];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}



#pragma mark ---- initializers  ----

//
// designated initializer
// If you have any instance variables you want to initialze, or anything you want done when an instance is created,
// you put that here.
//
- (id) initWithName:(NSString *)aName parent:(Node *)aParent withGridDimsX:(int)gridX andY:(int)gridY withShaderName:(NSString *) shaderName


{
    if (![super initWithName:aName parent:aParent]) {
        logError( @"WaterSheet, super init failed!" );
        return nil;
    }
	
    self.tilex = gridX;
    self.tiley = gridY;
    
    self.textureSizeX = 1000;
    self.textureSizeY = 1000;
    
    self.selectedShaderName = shaderName;

    self.level1Water = [[TextureController textureController] createTexture2dWithImage:[NSString stringWithFormat:@"%@/textures/level1/waterCenterFilter.png",[[NSBundle bundleForClass:[self class]] resourcePath]] target:GL_TEXTURE_RECTANGLE_ARB];

    self.level2Water = [[TextureController textureController] createTexture2dWithImage:[NSString stringWithFormat:@"%@/textures/level2/waterLevel2.png",[[NSBundle bundleForClass:[self class]] resourcePath]] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.level2WaterLight = [[TextureController textureController] createTexture2dWithImage:[NSString stringWithFormat:@"%@/textures/level2/waterLevel2Light.png",[[NSBundle bundleForClass:[self class]] resourcePath]] target:GL_TEXTURE_RECTANGLE_ARB];

    
    self.level3WaterNoColor = [[TextureController textureController] createTexture2dWithImage:[NSString stringWithFormat:@"%@/textures/level3/greyWater.png",[[NSBundle bundleForClass:[self class]] resourcePath]] target:GL_TEXTURE_2D];
    
    self.level3WaterColor = [[TextureController textureController] createTexture2dWithImage:[NSString stringWithFormat:@"%@/textures/level3/dayWater.png",[[NSBundle bundleForClass:[self class]] resourcePath]] target:GL_TEXTURE_2D];
  
    self.level3FoamyWater = [[TextureController textureController] createTexture2dWithImage:[NSString stringWithFormat:@"%@/textures/level3/greyWaterWithFoal.png",[[NSBundle bundleForClass:[self class]] resourcePath]] target:GL_TEXTURE_2D];    
    
    self.depthOverlayTexture  = [[TextureController textureController] createTexture2dWithImage:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"/textures/waterWood/fogTempHack.png"] target:GL_TEXTURE_2D];
    
    
    
//	[[[Dash dash] timekeeper] start:kPlaybackStateForward];
	
	[self createVertexArray];
	[self createTextureArray];
	
    [self setUpShader];    
    
    return self;
}





-(void) setUpShader
{
    NSString * shadersDirectoryPath = [[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"/shaders/"] stringByAppendingPathComponent:self.selectedShaderName];
    
    self.selectedShader = [[MaterialController materialController] addShader:shadersDirectoryPath];
    
	[ self.selectedShader load];
	
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "TimeShiftX"), 0 );
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "TimeShiftY"), 0 );
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "AmplitudeX"), 0 );
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "FrequencyX"), 0); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "AmplitudeY"), 0);
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "FrequencyY"), 0); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "Segment"), 0); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "Slope"), 0); 
    
	glUniform1iARB( glGetUniformLocationARB( self.selectedShader.programObject, "BackgroundTexture0"), 0);    
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "Opacity"), 0);
	glUniform1iARB( glGetUniformLocationARB( self.selectedShader.programObject, "TurnHeightCalcOn"), 0 );
   
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "VecCalcType"), 0 );
    
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "RedValue"), 0 );
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "BlueValue"), 0 );
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "GreenValue"), 0 );

    [ self.selectedShader unload];

}


#pragma mark ---- instance methods  ----


-(void) setUpWater
{
//    self.scaledX = 2;
//    self.scaledY = .7;
//
//    self.transX = 0;
// 	self.transY = 500;
//	self.transZ = -183.4061+943.2314;
//	self.rotX = -56.59389;	
//    
//		
//	self.ampX = 2.631579;
//	self.ampY = 2.631579;
//	
//	self.freqX = .2105;
//	self.freqY = .2105;
//	
//	self.timeFactorX = 10;
//	self.timeFactorY = 5;
//	
//	self.useHeightCalc = 0;	


}

-(void) updateUniforms
{
    DTime * timekeeper = [[Dash dash] timekeeper];
    self.timeShiftWaveX  = ([timekeeper time]+self.timeOffsetX) * self.timeFactorX;
    self.timeShiftWaveY  = [timekeeper time] * self.timeFactorY;
    
    
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "TimeShiftX"), self.timeShiftWaveX );
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "TimeShiftY"), self.timeShiftWaveY );
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "AmplitudeX"), self.ampX );
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "FrequencyX"), self.freqX); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "AmplitudeY"), self.ampY);
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "FrequencyY"), self.freqY); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "Segment"), self.seg); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "Slope"), self.slope); 
	glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "Opacity"), self.opacity*(1-self.opacityFactor));
	glUniform1iARB( glGetUniformLocationARB( self.selectedShader.programObject, "TurnHeightCalcOn"), self.useHeightCalc );
	
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "VecCalcType"), self.vecCalcType );
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "ColorFactor"), self.colorFactor );
    
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "RedValue"), self.redValue );
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "BlueValue"), self.blueValue );
    glUniform1fARB( glGetUniformLocationARB( self.selectedShader.programObject, "GreenValue"), self.greenValue );


}

- (void) drawWater
{    
	glDisable( GL_LIGHTING );
	glDisable( GL_DEPTH_TEST );
	glDisable( GL_CULL_FACE );
    
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    
    glScaled(self.scaledX, self.scaledY, self.scaledZ);
    glRotated(self.rotX, 1, 0, 0);
    glRotated(self.rotY, 0, 1, 0);
    glRotated(self.rotZ, 0, 0, 1);
    glTranslated(self.transX, self.transY, self.transZ);
  
	[self.selectedShader load];
    
    Texture2d * selectedTexture;
	
    if ([self.selectedShaderName isEqualToString: @"WavesLevel3"]) {
    
        if (self.useColor == 0) {
            selectedTexture = self.level3WaterColor;
        }
        
        else if (self.useColor == 1) {
            selectedTexture = self.level3WaterNoColor;
        }
        
        else {
            selectedTexture = self.level3FoamyWater;
        }
        
        
    }

    if ([self.selectedShaderName isEqualToString: @"WavesLevel2"]) {
        if (self.useGreenLightReflection) {
            selectedTexture = self.level2WaterLight;
        }
        else{
            selectedTexture = self.level1Water;
        }
    }
    
    if ([self.selectedShaderName isEqualToString: @"WavesLevel1"]) {
        
        selectedTexture = self.level1Water;
    }

    
    [selectedTexture bind];
    [self updateUniforms];
    
    
	//glBindBuffer( GL_ARRAY_BUFFER, vertexVBO );
	//glVertexPointer( 3, GL_FLOAT, 0, 0 );
    glVertexPointer( 3, GL_FLOAT, 0, self.vert_array );
	glEnableClientState( GL_VERTEX_ARRAY );
	
	//glBindBuffer( GL_ARRAY_BUFFER, texCoordVBO );
	//glTexCoordPointer( 2, GL_FLOAT, 0, 0 );
    glTexCoordPointer( 2, GL_FLOAT, 0, self.text_array );
	glEnableClientState( GL_TEXTURE_COORD_ARRAY );
	
	glDrawArrays( GL_QUADS, 0, self.numVertices );
	
	glDisableClientState( GL_TEXTURE_COORD_ARRAY );
	glDisableClientState( GL_VERTEX_ARRAY );
	
	[selectedTexture loose];
	[ self.selectedShader unload];
	
}




- (void) drawUnderWaterObjectWithTexture:(Texture2d*)texture
                                  WithScaleX:(float)scaledX
                              WithScaleY:(float)scaledY
                           WithPositionX:(float)positionX
                           WithPositionY:(float)positionY
                           WithPositionZ:(float)positionZ
                           WithRotationX:(float)rotX
{
	glDisable( GL_LIGHTING );
	glDisable( GL_DEPTH_TEST );
	glDisable( GL_CULL_FACE );
    
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    
    glScaled(scaledX, scaledY, 1.0);
    glRotated(rotX, 1, 0, 0);
//    glRotated(self.rotY, 0, 1, 0);
//    glRotated(self.rotZ, 0, 0, 1);
    glTranslated(positionX, positionY, positionZ);
    
	[self.selectedShader load];
    
    [texture bind];
    [self updateUniforms];
    
    
	//glBindBuffer( GL_ARRAY_BUFFER, vertexVBO );
	//glVertexPointer( 3, GL_FLOAT, 0, 0 );
    glVertexPointer( 3, GL_FLOAT, 0, self.vert_array );
	glEnableClientState( GL_VERTEX_ARRAY );
	
	//glBindBuffer( GL_ARRAY_BUFFER, texCoordVBO );
	//glTexCoordPointer( 2, GL_FLOAT, 0, 0 );
    glTexCoordPointer( 2, GL_FLOAT, 0, self.text_array );
	glEnableClientState( GL_TEXTURE_COORD_ARRAY );
	
	glDrawArrays( GL_QUADS, 0, self.numVertices );
	
	glDisableClientState( GL_TEXTURE_COORD_ARRAY );
	glDisableClientState( GL_VERTEX_ARRAY );
	
	[texture loose];
	[ self.selectedShader unload];
	
}


- (void)createVertexArray
{
    //	GLenum err;
    
	float w = self.textureSizeX;// 840.0; //* 3.0;
	float h = self.textureSizeY;//840.0;//340.0; //* 3.0;
	
//	int tilex = 300; //800;
//	int tiley = 300; //400;
	float elementCount = self.tilex * self.tiley;
	self.numVertices = elementCount * 4;
	
	float tileWidth = (w * 2) / (float)self.tilex;
	float tileHeight = (h * 2) / (float)self.tiley;
	float sWidth = 1.0 / (float)self.tilex;
	float tHeight = 1.0 / (float)self.tiley;
	
	//glGenBuffers( 1, &vertexVBO );
	//glErrorCheck( "glGenBuffers" );
	
	//glBindBuffer( GL_ARRAY_BUFFER, vertexVBO );
	//glErrorCheck( "glBindBuffer" );
	
	//glBufferData( GL_ARRAY_BUFFER, vertexCount * 3 * sizeof(float), NULL, GL_STATIC_DRAW );
	//glErrorCheck( "glBufferData" );
	
	//float * vp = (float *)glMapBuffer( GL_ARRAY_BUFFER, GL_WRITE_ONLY );
    
    self.vert_array = (float *)malloc(self.numVertices * 3 * sizeof(float));
	float * vp = self.vert_array;
    
	int i, j;
	float y = -h;
	float t = 0.0;
	for (j = 0; j < self.tiley; j++) {
		float x = -w;
		float s = 0.0;
		for (i = 0; i < self.tilex; i++) {
			
			float yoff1 = 0; //sin(x * 2.0 * (3.14159 / (w * 2))) * 250.0;
			float yoff2 = 0; //sin((x + tileWidth) * 2.0 * (3.14159 / (w * 2))) * 250.0;
			
			*vp++ = x;
			*vp++ = y+yoff1;
			*vp++ = 0.0;
			*vp++ = x + tileWidth;
			*vp++ = y+yoff2;
			*vp++ = 0.0;
			*vp++ = x + tileWidth;
			*vp++ = y + tileHeight+yoff2;
			*vp++ = 0.0;
			*vp++ = x;
			*vp++ = y + tileHeight+yoff1;
			*vp++ = 0.0;
			
			x += tileWidth;
			s += sWidth;
		}
		y += tileHeight;
		t += tHeight;
	}
	
	//GLboolean success = glUnmapBuffer( GL_ARRAY_BUFFER );
	//if (!success) logWarn( @"glUnmapBuffer for vertex array failed" );
    
}

- (void)createTextureArray
{
    //	GLenum err;
	
	float w = self.textureSizeX;// 840.0; //* 3.0;
	float h = self.textureSizeY;//840.0;//340.0; //* 3.0;
	
//	int tilex = 300; //800;
//	int tiley = 300; //400;
	
	float tileWidth = (w * 2) / (float)self.tilex;
	float tileHeight = (h * 2) / (float)self.tiley;
	float sWidth = 1.0 / (float)self.tilex;
	float tHeight = 1.0 / (float)self.tiley;
	
	//glGenBuffers( 1, &texCoordVBO );
	//glErrorCheck( "glGenBuffers" );
	
	//glBindBuffer( GL_ARRAY_BUFFER, texCoordVBO );
	//glErrorCheck( "glBindBuffer" );
	
	//glBufferData( GL_ARRAY_BUFFER, vertexCount * 2 * sizeof(float), NULL, GL_STATIC_DRAW );
	//glErrorCheck( "glBufferData" );
	
	//float * vp = (float *)glMapBuffer( GL_ARRAY_BUFFER, GL_WRITE_ONLY );
    
    self.text_array = (float *)malloc(self.numVertices * 2 * sizeof(float));
	float * vp = self.text_array;
	
	int i, j;
	float y = -h;
	float t = 0.0;
	for (j = 0; j < self.tiley; j++) {
		float x = -w;
		float s = 0.0;
		for (i = 0; i < self.self.tilex; i++) {
			
			*vp++ = s;
			*vp++ = t;
			*vp++ = s + sWidth;
			*vp++ = t;
			*vp++ = s + sWidth;
			*vp++ = t + tHeight;
			*vp++ = s;
			*vp++ = t + tHeight;
			
			x += tileWidth;
			s += sWidth;
		}
		y += tileHeight;
		t += tHeight;
	}
	
	//GLboolean success = glUnmapBuffer( GL_ARRAY_BUFFER );
	//if (!success) logWarn( @"glUnmapBuffer for vertex array failed" );
}

-(void) drawDepthOverlay
{
    float imageWidth = 500;
    float imageHeight = 500;
    
	glDisable( GL_DEPTH_TEST );
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	
    
    glPushMatrix();
    glColor4f(1, 1, 1, self.opacity);
    glScaled(22,10,1);
    glTranslated(0, 2.183406, 0);
 	glEnable( GL_TEXTURE_2D );
	
	[self.depthOverlayTexture bindTexture];
	
	glBegin(GL_QUADS);
	
	float z=0.0;
	
	glTexCoord3f(0.0, 0.0, z);
	glVertex3f(-imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0, 0.0, z);
	glVertex3f( imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0, 1.0, z);
	glVertex3f( imageWidth/2, imageHeight/2, 0.0);
	
	glTexCoord3f(0.0, 1.0, z);
	glVertex3f(-imageWidth/2, imageHeight/2, 0.0);	
	glEnd();
	
	glDisable( GL_TEXTURE_2D ); 
    
    glPopMatrix();
}



#pragma mark ---- NSObject  ----




//
// if you alloc any objects, you should release them here
//
- (void) dealloc
{
    [self.level3WaterColor release];
	[self.level3WaterNoColor release];
    [self.level3FoamyWater release];
	[self.level2Water release];
	[self.level1Water release];
	[super dealloc];
}


@end

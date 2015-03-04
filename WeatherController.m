//
//  WeatherController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeatherController.h"

@implementation WeatherController
@synthesize rainSheet = _rainSheet;
@synthesize snowSheet = _snowSheet;
@synthesize dTimer = _dTimer;
@synthesize rainSheetSizeX = _rainSheetSizeX;
@synthesize rainSheetSizeY = _rainSheetSizeY;
@synthesize rainSheetTransX = _rainSheetTransX;
@synthesize rainSheetTransY = _rainSheetTransY;
@synthesize rainSheetTransZ = _rainSheetTransZ;
@synthesize rainSheetDepthOverlap = _rainSheetDepthOverlap;
@synthesize rainOpacity = _rainOpacity;
@synthesize cloudyToRainy = _cloudyToRainy;
@synthesize rainy = _rainy;
@synthesize modOpacity = _modOpacity;

 
- (id)init
{
    self = [super init];
    
    if (self != nil) {
    
        [self createTextures];
        [self createTimer];
        [self setUpRainSheet];
    }
    return self;
}


-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    
    self.rainSheet = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/rainSheet.png"] target:GL_TEXTURE_2D];
    
    self.snowSheet = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/snowSheet.png"] target:GL_TEXTURE_2D];
  
}

-(void) createTimer
{
    self.dTimer = [TimeController timekeeper];
}


-(void) setUpRainSheet
{
    self.rainSheetSizeX = 10000;
    self.rainSheetSizeY = 20000;
    self.rainSheetDepthOverlap = 295;
    self.rainSheetTransX = 0;
    self.rainSheetTransY = 0;
    self.rainSheetTransZ = 912;
}

-(void) glQuadCallWithHeight:(float) imageHeight andWidth:(float)imageWidth andAdjust:(float)adjustRate andRandStart:(float)randStart
{
	glBegin(GL_QUADS);
	
	float z=0.0;
	
    float adjust = adjustRate*[self.dTimer time]/100;
    
	glTexCoord3f(0.0+adjust, 0.0+fabs(adjust)+randStart, z);
	glVertex3f(-imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0+adjust, 0.0+fabs(adjust)+randStart, z);
	glVertex3f( imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0+adjust, 1.0+fabs(adjust)+randStart, z);
	glVertex3f( imageWidth/2, imageHeight/2, 0.0);
	
	glTexCoord3f(0.0+adjust, 1.0+fabs(adjust)+randStart, z);
	glVertex3f(-imageWidth/2, imageHeight/2, 0.0);	
    
	glEnd();
}



-(void) drawRainWithIntensity:(float)levelIntensity
{
    
    if (levelIntensity == 1) {
        
        glColor4f(1, 1, 1, .1*self.rainOpacity/6);
    }
    
    if (levelIntensity == 2) {
        
        glColor4f(1, 1, 1, .1*self.rainOpacity);
    }    

    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );
    
    glPushMatrix();
    
    glTranslated(self.rainSheetTransX, self.rainSheetTransY, self.rainSheetTransZ);
    glRotated(10, 0, 0, 1);
    
    glEnable(GL_TEXTURE_2D);
    
    [self.rainSheet bindTexture];

    [self glQuadCallWithHeight:self.rainSheetSizeY andWidth:self.rainSheetSizeX andAdjust:2 andRandStart:30];

    glTranslated(0, 0, self.rainSheetDepthOverlap);
    [self glQuadCallWithHeight:self.rainSheetSizeY andWidth:self.rainSheetSizeX andAdjust:-12 andRandStart:90];

    glTranslated(0, 0, self.rainSheetDepthOverlap);
    [self glQuadCallWithHeight:self.rainSheetSizeY andWidth:self.rainSheetSizeX andAdjust:16 andRandStart:0];

    glDisable(GL_TEXTURE_2D);

    glPopMatrix();

}



-(void) drawSnowSheet
{
    [self.snowSheet bindTexture];
    
    glColor4f(1, 1, 1, .2*self.rainOpacity);
    
    glPushMatrix();
    
    glTranslated(self.rainSheetTransX, self.rainSheetTransY, self.rainSheetTransZ);
    glRotated(10, 0, 0, 1);
    
    [self glQuadCallWithHeight:self.rainSheetSizeY andWidth:self.rainSheetSizeX andAdjust:2 andRandStart:30];
    
    glTranslated(0, 0, self.rainSheetDepthOverlap);
    [self glQuadCallWithHeight:self.rainSheetSizeY andWidth:self.rainSheetSizeX andAdjust:-12 andRandStart:60];
    
    glTranslated(0, 0, self.rainSheetDepthOverlap);
    [self glQuadCallWithHeight:self.rainSheetSizeY andWidth:self.rainSheetSizeX andAdjust:16 andRandStart:0];
    
    
    glPopMatrix();
    
}







-(void) dealloc
{
    [super dealloc];
    [self.rainSheet release];

}

@end

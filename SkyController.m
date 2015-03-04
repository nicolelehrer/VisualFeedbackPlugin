//
//  SkyController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SkyController.h"

@implementation SkyController

@synthesize level3SceneController = _level3SceneController;

@synthesize greyCloudySkyTexture = _greyCloudySkyTexture;
@synthesize daySkyTexture = _daySkyTexture;
@synthesize stormySkyTexture = _stormySkyTexture;
@synthesize clearSkyTexture = _clearSkyTexture;
@synthesize cloudTexture = _cloudTexture;
@synthesize flatGreyTexture = _flatGreyTexture;
@synthesize blueSkyNoCloudsTexture = _blueSkyNoCloudsTexture;
@synthesize whiteCloudySkyTexture = _whiteCloudySkyTexture;

@synthesize weatherController = _weatherController;
@synthesize transitionFactor = _transitionFactor;

@synthesize skyTransX = _skyTransX;
@synthesize skyTransY = _skyTransY;
@synthesize skyTransZ = _skyTransZ;

@synthesize skyScaleX = _skyScaleX;
@synthesize skyScaleY = _skyScaleY;
@synthesize skyScaleZ = _skyScaleZ;

@synthesize skyRotX = _skyRotX;
@synthesize skyRotY = _skyRotY;
@synthesize skyRotZ = _skyRotZ;

@synthesize skyOpacity = _skyOpacity;

@synthesize dTimer = _dTimer;

@synthesize fractionTraveled = _fractionTraveled;
@synthesize clearToCloudy = _clearToCloudy;
@synthesize cloudyToRainy = _cloudyToRainy;
@synthesize clearSky = _clearSky;
@synthesize rainy = _rainy;
@synthesize cloudy = _cloudy;
@synthesize clearToSunrise = _clearToSunrise;
@synthesize goodSky = _goodSky;

@synthesize lightening = _lightening;
@synthesize lighteningReflection = _lighteningReflection;
@synthesize  randOpac;


- (id)init
{
	self = [super init];
    
    if (self != nil) {
        
        self.level3SceneController = [[Level3SceneController alloc] init];
        self.weatherController = [[WeatherController alloc] init];

        [self createTimeController];
        [self createTextures];
        [self setUpSkyControls];
    }
	return self;
}


-(void) createTimeController
{
    self.dTimer = [TimeController timekeeper];
}

-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];

   
     self.blueSkyNoCloudsTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/blueSkyNoClouds.png"] target:GL_TEXTURE_2D];
    
    self.whiteCloudySkyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/blueSkyClouds.png"] target:GL_TEXTURE_2D];
    
	self.stormySkyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/stormySky.png"] target:GL_TEXTURE_2D];
    
    self.clearSkyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/clearSky.png"] target:GL_TEXTURE_2D];
    
//    self.goodSky = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/goodSky4.png"] target:GL_TEXTURE_2D];

     self.daySkyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/daySky.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    self.greyCloudySkyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/greyCloudySky.png"] target:GL_TEXTURE_2D];
    
     self.cloudTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/cloud.png"] target:GL_TEXTURE_2D];
   
     self.flatGreyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/flatGrey.png"] target:GL_TEXTURE_2D];
    
    
    self.lightening = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/stormySkyLightning.png"] target:GL_TEXTURE_2D];
    
     self.lighteningReflection = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/waterWood/whiteGradient.png"] target:GL_TEXTURE_RECTANGLE_ARB];
}

-(void) setUpSkyControls
{
    self.skyOpacity = 1.0;
    
    self.skyTransX = 0;
    self.skyTransY = 202;
    self.skyTransZ = 5600;
    self.skyScaleX = 3;
    self.skyScaleY = 1.7;
    self.skyScaleZ = 0;

}


-(void) glQuadCallWithHeight:(float) imageHeight andWidth:(float)imageWidth WithAdjust:(float)adjustFactor
{
	glBegin(GL_QUADS);
	
	float z=0.0;
	
    float adjust = [self.dTimer time]/100*adjustFactor;
    
	glTexCoord3f(0.0+adjust, 0.0, z);
	glVertex3f(-imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0+adjust, 0.0, z);
	glVertex3f( imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0+adjust, 1.0, z);
	glVertex3f( imageWidth/2, imageHeight/2, 0.0);
	
	glTexCoord3f(0.0+adjust, 1.0, z);
	glVertex3f(-imageWidth/2, imageHeight/2, 0.0);	
    
	glEnd();
}


-(void) drawGreySky 
{
    float imageWidth = 512*3;
    float imageHeight = 512*8;    
    
    glColor4f(1.0, 1.0, 1.0, self.skyOpacity);  
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );

    glPushMatrix();

    glTranslated(0, 115.4701, 5464.372);	
    glRotated(70, 1, 0, 0);
    glRotated(self.skyRotY, 0, 1, 0);
    glRotated(-90, 0, 0, 1);
     
    glEnable(GL_TEXTURE_2D);

    [self.greyCloudySkyTexture bindTexture];
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:5];
    
    glDisable(GL_TEXTURE_2D);

    glPopMatrix();
}



-(void) drawStormySkyWithLightening:(BOOL)doLightening
{
    float imageWidth = 512*3;
    float imageHeight = 512*8;    
    
    glColor4f(1.0, 1.0, 1.0, self.skyOpacity);  

    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );

    glPushMatrix();
    
    glTranslated(0, 115.4701, 5464.372);	
    glRotated(70, 1, 0, 0);
    glRotated(self.skyRotY, 0, 1, 0);
    glRotated(-90, 0, 0, 1);
    
    glEnable(GL_TEXTURE_2D);
    
    [self.stormySkyTexture bindTexture];
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:5];

    float timer = [self.dTimer time];
    
    float randOpac2;
    
    if( (sin(timer) > .5 && sin(timer) < .75) ||
        (sin(timer) < -.5 && sin(timer) > -.75)) {
        
        randOpac2 = (float)(rand() % 10*(rand() % 2 ? 0 : 1))/10;	
    }
    
    self.randOpac = randOpac2;
    
    if (doLightening) {
        
        glColor4f(1.0, 1.0, 1.0, self.skyOpacity*randOpac2); 
        
        [self.lightening bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:5];
    }
    
    glDisable(GL_TEXTURE_2D);

    glPopMatrix();
}


-(void) drawClearSky
{    
	float imageWidth;
	float imageHeight;
    
    imageWidth = 512*5;
    imageHeight = 512*1.8;
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );
    
    glPushMatrix();
    
    glTranslated(0, 419, 5600);
    glColor4f(1.0, 1.0, 1.0, self.skyOpacity);  
    
    glEnable(GL_TEXTURE_RECTANGLE_ARB);

    [self.daySkyTexture bindTexture];
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:0];
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);

    glPopMatrix();
}
    
-(void) drawCloud
{  
    float imageWidth = 512*(self.skyScaleX);
    float imageHeight = 512*(self.skyScaleY);
        
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );

    glPushMatrix();
    
    glTranslated(self.skyTransX, 173.5587, 6483.497);		
    
    float timer = [self.dTimer time];
    glColor4f(1.0, 1.0, 1.0, self.skyOpacity*0.2-.1*sin(timer*2));
    
    glEnable(GL_TEXTURE_2D);
    
    [self.cloudTexture bindTexture];
    
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:10];
    
    glDisable(GL_TEXTURE_2D);
    glPopMatrix();
}



-(void) drawClearSkyWithCloudsFadeIn:(BOOL) doFadeIn
{
    
    [self calcTravel];
	float imageWidth;
	float imageHeight;
    
    
    imageWidth = 512*3;
    imageHeight = 512*8;    
    
    glPushMatrix();
    
    
    glTranslated(0, 115.4701, 5464.372);	
    
    glRotated(70, 1, 0, 0);
    glRotated(self.skyRotY, 0, 1, 0);
    glRotated(-90, 0, 0, 1);
    
    float totalOpacity;
    
    if (doFadeIn) {
        
        glColor4f(1.0, 1.0, 1.0, self.skyOpacity);  
        [self.blueSkyNoCloudsTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:0];
        
        totalOpacity = self.skyOpacity*self.transitionFactor*3;
        
        if (totalOpacity>1) {
            totalOpacity = 1;
        }
    }
    
    else {
        totalOpacity = 1;
    }
    
    glColor4f(1.0, 1.0, 1.0, self.skyOpacity*totalOpacity); 
    
    glEnable(GL_TEXTURE_2D);
    
    
    [self.whiteCloudySkyTexture bindTexture];
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth WithAdjust:5];
    
    glDisable(GL_TEXTURE_2D);
    
    glPopMatrix();
}

-(void) resetVals
{
    self.fractionTraveled = [self.level3SceneController.singleTravelSegment resetDisplacementFast];
    
    
}


-(void) calcTravel
{        
    self.transitionFactor = [self.level3SceneController.singleTravelSegment calcDisplacement]/self.level3SceneController.singleTravelSegment.endValue;
}


-(void) dealloc
{
    [super dealloc];
    [self.stormySkyTexture release];
    [self.clearSkyTexture release];
    [self.dTimer release];
    [self.level3SceneController release];

}



@end

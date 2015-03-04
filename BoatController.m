//
//  BoatController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoatController.h"
#import "VFAnalysisFrame.h"

@implementation BoatController

@synthesize timekeeper;

@synthesize fogDisplacement = _fogDisplacement;
@synthesize fogOpacity = _fogOpacity;

@synthesize analysisFrame = _analysisFrame;
@synthesize analysisFeatures = _analysisFeatures;

@synthesize randomVariation = _randomVariation;

@synthesize efficientTexture0 = _efficientTexture0;
@synthesize efficientTexture1 = _efficientTexture1;
@synthesize efficientTexture2 = _efficientTexture2;
@synthesize boatTextureInaccurate0Shadow = _boatTextureInaccurate0Shadow;

@synthesize boatTextureInaccurate0 = _boatTextureInaccurate0;
@synthesize boatTextureInaccurate1 = _boatTextureInaccurate1;
@synthesize boatTextureInaccurate0Red = _boatTextureInaccurate0Red;
@synthesize boatTextureInaccurate1Red = _boatTextureInaccurate1Red;
@synthesize boatTextureInaccurate0RedVar1 = _boatTextureInaccurate0RedVar1;
@synthesize boatTextureInaccurate1RedVar1 = _boatTextureInaccurate1RedVar1;
@synthesize boatTexutreSegment01 = _boatTexutreSegment01;
@synthesize boatTexutreSegment11 = _boatTexutreSegment11;
@synthesize boatTexutreSegment21 = _boatTexutreSegment21;
@synthesize boatTexutreSegment01Red = _boatTexutreSegment01Red;
@synthesize boatTexutreSegment11Red = _boatTexutreSegment11Red;
@synthesize boatTexutreSegment21Red = _boatTexutreSegment21Red;
@synthesize boatTexutreSegment00 = _boatTexutreSegment00;
@synthesize boatTexutreSegment10 = _boatTexutreSegment10;
@synthesize boatTexutreSegment20 = _boatTexutreSegment20;
@synthesize boatTexutreSegment00Red = _boatTexutreSegment00Red;
@synthesize boatTexutreSegment10Red = _boatTexutreSegment10Red;
@synthesize boatTexutreSegment20Red = _boatTexutreSegment20Red;

@synthesize lampTextureNoLight = _lampTextureNoLight;    
@synthesize lampTexture = _lampTexture;

@synthesize boatGrasp0 = _boatGrasp0;
@synthesize boatGrasp1 = _boatGrasp1;
@synthesize boatGrasp2 = _boatGrasp2;

@synthesize boatGraspMild = _boatGraspMild;

@synthesize boatGrasp0incomplete = _boatGrasp0incomplete;
@synthesize boatGrasp1incomplete = _boatGrasp1incomplete;
@synthesize boatGrasp2incomplete = _boatGrasp2incomplete;

@synthesize fogTagTexture = _fogTagTexture;
@synthesize lastStepTexture = _lastStepTexture;
@synthesize fogOverlayTexture = _fogOverlayTexture;


@synthesize boatRotX = _boatRotX;
@synthesize boatRotY = _boatRotY;
@synthesize boatRotZ = _boatRotZ;

@synthesize boatTransX = _boatTransX;
@synthesize boatTransY = _boatTransY;
@synthesize boatTransZ = _boatTransZ;

@synthesize boatSizeX = _boatSizeX;
@synthesize boatSizeY = _boatSizeY;

@synthesize boatOpacity = _boatOpacity;
@synthesize fogTranslateX = _fogTranslateX;
@synthesize fogTranslateY = _fogTranslateY;

@synthesize randOpac = _randOpac;

- (id)init
{
	self = [super init];
    
    if (self != nil) {
        
        [self createTimer];
        [self createTextures];
        
    }
	return self;
}


-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    
    self.efficientTexture0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boat.png"] target:GL_TEXTURE_2D];
    self.efficientTexture1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatBright.png"] target:GL_TEXTURE_2D];
    self.efficientTexture2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatBack.png"] target:GL_TEXTURE_2D];
    
    self.boatTextureInaccurate0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateSmall0.png"] target:GL_TEXTURE_2D];
    self.boatTextureInaccurate1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateSmall1.png"] target:GL_TEXTURE_2D];
    
    self.boatTextureInaccurate0Shadow = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateColor1Shadow.png"] target:GL_TEXTURE_2D];
    
    self.boatTextureInaccurate1Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateColor0.png"] target:GL_TEXTURE_2D];
    self.boatTextureInaccurate0Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateColor1.png"] target:GL_TEXTURE_2D];
    
    self.boatTextureInaccurate1RedVar1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateColor0var1.png"] target:GL_TEXTURE_2D];
    self.boatTextureInaccurate0RedVar1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/inaccurateColor1var1.png"] target:GL_TEXTURE_2D];

    
    self.boatTexutreSegment01 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg1Yellow2.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment11 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg2Yellow2.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment21 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg3Yellow2.png"] target:GL_TEXTURE_2D];
    
    self.boatTexutreSegment01Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg1Red2.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment11Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg2Red2.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment21Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg3Red2.png"] target:GL_TEXTURE_2D];
    
    
    self.boatTexutreSegment00 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg1Yellow.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment10 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg2Yellow.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment20 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg3Yellow.png"] target:GL_TEXTURE_2D];
    
    self.boatTexutreSegment00Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg1Red.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment10Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg2Red.png"] target:GL_TEXTURE_2D];
    self.boatTexutreSegment20Red = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/seg3Red.png"] target:GL_TEXTURE_2D];
    
    
    self.boatGrasp0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatFrame.png"] target:GL_TEXTURE_2D];
    self.boatGrasp1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatFrame.png"] target:GL_TEXTURE_2D];
    self.boatGrasp2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatFrame.png"] target:GL_TEXTURE_2D];
    
    self.boatGraspMild = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatFrameDim.png"] target:GL_TEXTURE_2D];

    self.boatGrasp0incomplete = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatGraspIncomplete.png"] target:GL_TEXTURE_2D];
    self.boatGrasp1incomplete = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatGraspIncomplete.png"] target:GL_TEXTURE_2D];
    self.boatGrasp2incomplete = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/boatGraspIncomplete.png"] target:GL_TEXTURE_2D];
    
    self.lampTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/lampLit.png"] target:GL_TEXTURE_2D];
    self.lampTextureNoLight = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2Boats/lampNoLight.png"] target:GL_TEXTURE_2D];
    

    
    
    self.fogTagTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level2/fogLevel2.png"] target:GL_TEXTURE_2D];
    
    self.lastStepTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/waterWood/lastStep.png"] target:GL_TEXTURE_2D];
    
    self.fogOverlayTexture  = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/waterWood/fogTempHack.png"] target:GL_TEXTURE_2D];

    
}


-(void) createTimer
{
    timekeeper = [TimeController timekeeper];			
    
}


-(void) glQuadWithTexture:(Texture2d *)texture withHeight:(float) imageHeight withWidth:(float)imageWidth 
{
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );
	
 	glEnable( GL_TEXTURE_2D );
	
	[texture bindTexture];
	
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
}



- (void) drawEfficient
{
    self.boatSizeX = 1500;
    self.boatSizeY = 1500;
    self.boatTransX = 131.0044;
    self.boatTransY =  -314.4105;
    self.boatTransZ = 4500;
    self.boatRotX = 4;
    self.boatRotY = 4;

	float timer = [timekeeper time];

    glPushMatrix();     
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(-20 +self.boatRotX*sin(timer), 1, 0, 0);

    glRotated(self.boatRotY*sin(timer), 0, 1, 0);

    
    glColor4f(1+sin(timer)/2.5, 1+sin(timer)/2.5, 1+sin(timer)/2.5, self.boatOpacity);
    [self glQuadWithTexture:self.efficientTexture0 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer)/(2+1.703057));
    [self glQuadWithTexture:self.efficientTexture1 withHeight:self.boatSizeY withWidth:self.boatSizeX];

    glColor4f(1, 1, 1, self.boatOpacity*sin(timer)/(-1.703057));
    [self glQuadWithTexture:self.efficientTexture2 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();
}


-(void) drawMediumCurved
{
    float timer = [timekeeper time];

    self.boatSizeX = 1500;
    self.boatSizeY = 1500;
    self.boatTransX = -50;
    self.boatTransY =  -200;
    self.boatTransZ = 4782;
    self.boatRotX = -30;
    self.boatRotY = 0;
    self.boatRotZ = 0;
        
    glPushMatrix();         
        
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+2*sin(timer), 1, 0, 0); 
    glRotated(self.boatRotY+5*sin(timer), 0, 1, 0);        
    glRotated(self.boatRotZ+sin(timer), 0, 0, 1);  
    
        
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTextureInaccurate0 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1,  self.boatOpacity*sin(timer+28.38428));
    [self glQuadWithTexture:self.boatTextureInaccurate1 withHeight:self.boatSizeY withWidth:self.boatSizeX];
        
    glPopMatrix();
}

-(void) drawHighCurved
{
    float timer = [timekeeper time];
    
    self.boatSizeX = 1500;
    self.boatSizeY = 1500;
    self.boatTransX = -50;
    self.boatTransY =  -200;
    self.boatTransZ = 4782;
    self.boatRotX = -30;
    self.boatRotY = 0;
    self.boatRotZ = 0;
    
    glPushMatrix();         
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+2*sin(timer), 1, 0, 0); 
    glRotated(self.boatRotY+5*sin(timer), 0, 1, 0);        
    glRotated(self.boatRotZ+sin(timer), 0, 0, 1);
    
    glColor4f(1, 1, 1,  self.boatOpacity*-sin((timer+28.38428)));
    [self glQuadWithTexture:self.boatTextureInaccurate0Shadow withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    if (self.randomVariation == 1) {
   
        glColor4f(1, 1, 1,  self.boatOpacity);
        [self glQuadWithTexture:self.boatTextureInaccurate0Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
        
        glColor4f(1, 1, 1,  self.boatOpacity*sin((timer+28.38428)));
        [self glQuadWithTexture:self.boatTextureInaccurate1Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    }
    
    if (self.randomVariation == 2) {
        
        glColor4f(1, 1, 1,  self.boatOpacity);
        [self glQuadWithTexture:self.boatTextureInaccurate0RedVar1 withHeight:self.boatSizeY withWidth:self.boatSizeX];
        
        glColor4f(1, 1, 1,  self.boatOpacity*sin((timer+28.38428)));
        [self glQuadWithTexture:self.boatTextureInaccurate1RedVar1 withHeight:self.boatSizeY withWidth:self.boatSizeX];
        

    }
    glPopMatrix();

}



-(void) drawMediumSegmented
{
    float timer = [timekeeper time];
    
    self.boatSizeX = 1500;
    self.boatSizeY = 1500;
    self.boatTransX = -674.3654;
    self.boatTransY =  214;
    self.boatTransZ = 2400;
    self.boatRotX = 10;
    self.boatRotY = 3;
    self.boatRotZ = 0;
    
    glPushMatrix();         
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+sin(timer-90), 1, 0, 0); 
    glRotated(self.boatRotZ+sin(timer-90), 0, 0, 1);
    
    
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTexutreSegment21 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer+11));
    [self glQuadWithTexture:self.boatTexutreSegment20 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();     
    
    
    self.boatTransX = -167.8493;
    self.boatTransY =  9;
    self.boatTransZ = 2400;
    self.boatRotX = 15;
    self.boatRotY = 2;
    
    glPushMatrix();         
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+sin(timer+90), 1, 0, 0); 
    glRotated(self.boatRotZ+sin(timer+90), 0, 0, 1);  
    
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTexutreSegment10 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer+11));
    [self glQuadWithTexture:self.boatTexutreSegment11 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();     
    

    self.boatTransX = 346.0358;
    self.boatTransY =  -288.2096;
    self.boatTransZ = 2400;
    self.boatRotX = 22;
    self.boatRotY = 4;

    glPushMatrix();         
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+sin(timer), 1, 0, 0); 
    glRotated(self.boatRotZ+sin(timer), 0, 0, 1);  
    
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTexutreSegment00 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer+11));
    [self glQuadWithTexture:self.boatTexutreSegment01 withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();     

}


-(void) drawHighSegmented
{
    float timer = [timekeeper time];
    
    self.boatSizeX = 1500;
    self.boatSizeY = 1500;
    self.boatTransX = -681.2227;
    self.boatTransY =  235.8079;
    self.boatTransZ = 2400;
    self.boatRotX = 10;
    self.boatRotY = 3;
    self.boatRotZ = 0;
    
    glPushMatrix();         
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+sin(timer-90), 1, 0, 0); 
    glRotated(self.boatRotZ+sin(timer-90), 0, 0, 1);  
    
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTexutreSegment21Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer+11));
    [self glQuadWithTexture:self.boatTexutreSegment20Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();     
    
    
    self.boatTransX = -314.4105;
    self.boatTransY =  -26.20087;
    self.boatTransZ = 2400;
    self.boatRotX = 15;
    self.boatRotY = 2;
     
    glPushMatrix();         
    
    glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
    glRotated(self.boatRotX+sin(timer+90), 1, 0, 0); 
    glRotated(self.boatRotZ+sin(timer+90), 0, 0, 1);  
    
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTexutreSegment11Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer+11));
    [self glQuadWithTexture:self.boatTexutreSegment10Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();     
    
    
    self.boatTransX = 209.607;
    self.boatTransY =  -288.2096;
    self.boatTransZ = 2400;
    self.boatRotX = 22;
    self.boatRotY = 4;
    
    glPushMatrix();         
    
    glTranslated(self.boatTransX+180, self.boatTransY-50, self.boatTransZ);
    glRotated(self.boatRotX+sin(timer), 1, 0, 0); 
    glRotated(self.boatRotZ+sin(timer), 0, 0, 1);  
    
    glColor4f(1, 1, 1,  self.boatOpacity);
    [self glQuadWithTexture:self.boatTexutreSegment00Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glColor4f(1, 1, 1, self.boatOpacity*sin(timer+11));
    [self glQuadWithTexture:self.boatTexutreSegment01Red withHeight:self.boatSizeY withWidth:self.boatSizeX];
    
    glPopMatrix();     
    
}



-(void) resetValues
{
    
    self.fogDisplacement = 0;
    self.fogOpacity = 0;

}


-(void) drawGraspWithErrorLevel:(float)errorLevel
{    
    self.boatSizeX = 1500;
    self.boatSizeY = 1500;
    self.boatTransX = 131.0044;
    self.boatTransY =  -354.4105;
    self.boatTransZ = 4500;
    self.boatRotX = 10;
    self.boatRotY = 10;
    
	float timer = [timekeeper time];
    
    glPushMatrix();
    
        glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
        glRotated(self.boatRotX*sin(timer), 1, 0, 0);
        glRotated(self.boatRotY*sin(timer/2), 0, 1, 0);
        
        if (errorLevel == 0) {

            glColor4f(1+sin(timer)/2.5, 1+sin(timer)/2.5, 1+sin(timer)/2.5, self.boatOpacity);
            [self glQuadWithTexture:self.boatGrasp0 withHeight:self.boatSizeY withWidth:self.boatSizeX];
            
            glColor4f(1, 1, 1, self.boatOpacity*sin(timer)/(2+1.703057));
            [self glQuadWithTexture:self.boatGrasp1 withHeight:self.boatSizeY withWidth:self.boatSizeX];
            
            glColor4f(1, 1, 1, self.boatOpacity*sin(timer)/(-1.703057));
            [self glQuadWithTexture:self.boatGrasp2 withHeight:self.boatSizeY withWidth:self.boatSizeX];
        }
        else if (errorLevel == 1) {

            glColor4f(1, 1, 1, self.boatOpacity);
            [self glQuadWithTexture:self.boatGrasp0incomplete withHeight:self.boatSizeY withWidth:self.boatSizeX];
            
            
//            if( (sin(timer) > .5 && sin(timer) < .75) ||
//               (sin(timer) < -.5 && sin(timer) > -.75)) {
//                
//                self.randOpac = (float)(rand() % 10*(rand() % 2 ? 0 : 1))/10;	
//            }
            
            self.randOpac = sin(timer*5)+sin(timer*3);
            
            glColor4f(1, 1, 1, self.boatOpacity*self.randOpac);
            [self glQuadWithTexture:self.boatGraspMild withHeight:self.boatSizeY withWidth:self.boatSizeX];
        }
    
        else if (errorLevel == 2) {
            
            glColor4f(1+sin(timer)/2.5, 1+sin(timer)/2.5, 1+sin(timer)/2.5, self.boatOpacity);
            [self glQuadWithTexture:self.boatGrasp0incomplete withHeight:self.boatSizeY withWidth:self.boatSizeX];
            
            glColor4f(1, 1, 1, self.boatOpacity*sin(timer)/(2+1.703057));
            [self glQuadWithTexture:self.boatGrasp1incomplete withHeight:self.boatSizeY withWidth:self.boatSizeX];
            
            glColor4f(1, 1, 1, self.boatOpacity*sin(timer)/(-1.703057));
            [self glQuadWithTexture:self.boatGrasp2incomplete withHeight:self.boatSizeY withWidth:self.boatSizeX];
        }
        else {
            
        }
    
    
    
    glPopMatrix();

    
    glPushMatrix();
    
        glTranslated(self.boatTransX, self.boatTransY, self.boatTransZ);
        glRotated(self.boatRotX*sin(timer), 1, 0, 0);
        glRotated(self.boatRotY*sin(timer/2), 0, 1, 0);

        glScaled(1, 1, 1);
        
        
        if (errorLevel == 0) {
            
            glColor4f(1+sin(timer)/2.5, 1+sin(timer)/2.5, 1+sin(timer)/2.5, self.boatOpacity);
            [self glQuadWithTexture:self.lampTexture withHeight:self.boatSizeX withWidth:self.boatSizeY];

        }
        else if (errorLevel == 1) {
            
            glColor4f(1+sin(timer)/2.5, 1+sin(timer)/2.5, 1+sin(timer)/2.5, self.boatOpacity);
            [self glQuadWithTexture:self.lampTextureNoLight withHeight:self.boatSizeX withWidth:self.boatSizeY];
            
            glColor4f(1+sin(timer)/2.5, 1+sin(timer)/2.5, 1+sin(timer)/2.5, self.boatOpacity*self.randOpac/2);
            [self glQuadWithTexture:self.lampTexture withHeight:self.boatSizeX withWidth:self.boatSizeY];
            
        }
        else if (errorLevel == 2) {
            
            glColor4f(.7, .7, .7, self.boatOpacity);
            [self glQuadWithTexture:self.lampTextureNoLight withHeight:self.boatSizeX withWidth:self.boatSizeY];
            
        }
        else {
            
        }

    glPopMatrix();

}

-(void) drawDepthOverlay
{	    
    glPushMatrix();
    
        glColor4f(1, 1, 1, self.boatOpacity);
        glScaled(22,15,1);
        glTranslated(0, 2.183406-46.15857, 0);
        
        [self glQuadWithTexture:self.fogOverlayTexture  withHeight:500 withWidth:500]; 

    glPopMatrix();
    
    glPushMatrix();
    
        glColor4f(1, 1, 1, self.boatOpacity);
        glScaled(22,15,1);
        glTranslated(0, 2.183406+36.21384, 0);
        glRotated(180, 1, 0, 0);
          
        [self glQuadWithTexture:self.fogOverlayTexture  withHeight:500 withWidth:500]; 

    glPopMatrix();
        
}



-(void) drawBoatWithTag:(VisualLevel2Content)tag
{    
    if (tag == vEfficient) {
        
        [self drawEfficient];
    }
    else if (tag == vCurvedHigh) {
        
        [self drawHighCurved];
    }
    else if (tag == vCurvedMed) {
        
        [self drawMediumCurved];
    }
    else if (tag == vSegmentedMed) {
        
        [self drawMediumSegmented];
    }
    else if (tag == vSegmentedHigh) {
        
        [self drawHighSegmented];
    }
    else if (tag == vGraspComplete) {
       
        [self drawGraspWithErrorLevel:0];
    }
    else if (tag == vGraspMild) { 
        
        [self drawGraspWithErrorLevel:1];
    }
    else if (tag == vGraspIncomplete) {
        
        [self drawGraspWithErrorLevel:2];
    }
}



- (void) drawFogWithLiftTag:(VisualLevel2Content)liftTag WithFadeUpCue:(BOOL)fadeUpCue
{
    if (liftTag != vBlank) {
        
        float timer = [self.timekeeper time]/100;
        float modOpacity;
        float heightFactor;
        
        
        if (liftTag == vLiftSuccess) {
            
            heightFactor = -75;

            if (self.fogOpacity < 1.0 && fadeUpCue) {
                self.fogDisplacement = 0;
                modOpacity = self.fogOpacity;
            }
            else { 
                self.fogDisplacement = self.fogDisplacement+1;
                modOpacity = self.fogOpacity-self.fogDisplacement/100;
            }
            
        }
        
        else if (liftTag == vLiftModerate) {
            self.fogDisplacement = 0;
            modOpacity= self.fogOpacity;
            heightFactor = 20;
        }
        
        else if (liftTag == vLiftIncomplete) {
            self.fogDisplacement = 0;
            modOpacity= self.fogOpacity;
            heightFactor = -75;
        }
        
        //    NSLog(@"fogOpacity = %f", self.fogOpacity);
        glDisable( GL_DEPTH_TEST );
        glEnable( GL_BLEND );
        glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        
        glEnable( GL_TEXTURE_2D);
        
            glPushMatrix();
                glScaled(10, 5, 1);
                glTranslated(-self.fogDisplacement, heightFactor, 5300);
                [self glQuadWithTexture:self.fogTagTexture withHeight:1500 withWidth:1500 andOpacity:modOpacity withColorShift:0 andDisplacement:timer WithInitialDisplacement:0];
            glPopMatrix();
            
            glPushMatrix();
                glScaled(10, 5, 1);
                glTranslated(self.fogDisplacement, heightFactor, 5300);
                [self glQuadWithTexture:self.fogTagTexture withHeight:1500 withWidth:1500 andOpacity:modOpacity*.75 withColorShift:0 andDisplacement:-timer WithInitialDisplacement:1];
            glPopMatrix();
        
        glDisable( GL_TEXTURE_2D );
        
    }
}

-(void) glQuadWithTexture:(Texture2d *)texture withHeight:(float) imageHeight withWidth:(float)imageWidth andOpacity:(float)opacity withColorShift:(float)colorShift andDisplacement:(float)displacement WithInitialDisplacement:(float)initialDisplacement
{
	glDisable( GL_DEPTH_TEST );
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	
 	glEnable( GL_TEXTURE_2D );
    
	glColor4f(1+sin(colorShift)/2.5, 1+sin(colorShift)/2.5, 1+sin(colorShift)/2.5, opacity);
	
	[texture bindTexture];
	
	glBegin(GL_QUADS);
	
	float z=0.0;
	
	glTexCoord3f(0.0+displacement+initialDisplacement, 0.0, z);
	glVertex3f(-imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0+displacement+initialDisplacement, 0.0, z);
	glVertex3f( imageWidth/2, -imageHeight/2, 0.0);
	
	glTexCoord3f(1.0+displacement+initialDisplacement, 1.0, z);
	glVertex3f( imageWidth/2, imageHeight/2, 0.0);
	
	glTexCoord3f(0.0+displacement+initialDisplacement, 1.0, z);
	glVertex3f(-imageWidth/2, imageHeight/2, 0.0);
	glEnd();
	
	glDisable( GL_TEXTURE_2D );
}

-(void) dealloc
{
    [super dealloc];
    [self.timekeeper release];
    [self.efficientTexture2 release];
    [self.efficientTexture1 release];
    [self.efficientTexture0 release];
    
}

@end

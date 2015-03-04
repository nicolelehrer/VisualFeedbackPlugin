//
//  BirdsController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdsController.h"

@implementation BirdsController

@synthesize cutOffPositionX = _cutOffPositionX;
@synthesize initialPositionY = _initialPositionY;
@synthesize initialPositionZ = _initialPositionZ;

@synthesize transitionFactor = _transitionFactor;
@synthesize wingTexture = _wingTexture;
@synthesize bodyTexture = _bodyTexture;

@synthesize dTimer = _dTimer;
@synthesize birdScaleX = _birdScaleX;
@synthesize birdScaleY = _birdScaleY;
@synthesize birdOpacity = _birdOpacity;
@synthesize birdPositionX = _birdPositionX;
@synthesize birdPositionY = _birdPositionY;
@synthesize birdPositionZ = _birdPositionZ;

@synthesize sceneController = _sceneController;

@synthesize zComponent = _zComponent;
@synthesize yComponent = _yComponent;
@synthesize displacement = _displacement;
@synthesize opacitySubtractor = _opacitySubtractor;

- (id)init
{
	self = [super init];
    
    if (self != nil) {
        [self setUpBirdControls];
        [self createTimeController];
        [self createTextures];
        [self createTravelController];
    
        self.birdPositionX =2383.928;
        self.birdPositionY = 1291.071;
        self.birdPositionZ = -7434.821;
        
        self.cutOffPositionX = -7000;
    }
	return self;
}

-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];

    	
    
	self.bodyTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/body.png"] target:GL_TEXTURE_2D];
    
    self.wingTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/wing.png"] target:GL_TEXTURE_2D];
}

-(void) createTravelController
{
    self.sceneController = [[Level3SceneController alloc] init];
}

-(void) createTimeController
{
    self.dTimer = [TimeController timekeeper];
}


-(void) calcTranslation
{
    float waterAngle = -91.06681; //manually set to equal waterSheet.rotX in level3WaterController
    
    self.displacement = [self.sceneController.singleTravelSegment calcDisplacement];
    self.yComponent = self.displacement*sin(waterAngle);
    self.zComponent = self.displacement*cos(waterAngle);
    
    self.transitionFactor = [self.sceneController.singleTravelSegment calcDisplacement]/self.sceneController.singleTravelSegment.endValue;
}

-(void) glQuadCallWithHeight:(float) imageHeight andWidth:(float)imageWidth
{
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
}

-(void) setUpBirdControls
{
    self.birdOpacity = 1.0;
    self.birdScaleX = 3.0;
    self.birdScaleY = 3.0;
    self.birdPositionX = 0.0;
    self.birdPositionY = 0.0;
    self.birdPositionZ = 0.0;
}

-(void) drawBirdWithRandomStart:(float)randomStart
{
//    [self calcTranslation];
    
    float imageWidth = 30*self.birdScaleY;
    float timer = [self.dTimer time]*12;
        
    glPushMatrix();
    glTranslated(self.birdPositionX-timer*100, self.birdPositionY, self.birdPositionZ-timer*100);

    if(self.birdPositionX-timer*100 > self.cutOffPositionX)
    {
        glColor4f(.6, .6, .6, self.birdOpacity);
    }
    else 
    {
        self.opacitySubtractor = self.opacitySubtractor + .005;
        float temp = .6-self.opacitySubtractor;
        glColor4f(temp, temp, temp, temp);
    }
    
    [self.wingTexture bindTexture];        
   
    glPushMatrix();    
    glRotated(45*sin(timer+randomStart), 0, 0, 1);
    [self glQuadCallWithHeight:imageWidth andWidth:imageWidth];
    glPopMatrix();
    
    glPushMatrix();
    glTranslated(imageWidth*.75, 0, 0);
    glRotated(-45*sin(timer+randomStart), 0, 0, 1);
    [self glQuadCallWithHeight:imageWidth andWidth:imageWidth];
    glPopMatrix();
    
    [self.bodyTexture bindTexture];
    glPushMatrix(); 
    glTranslated(imageWidth/2, 30*sin(timer+randomStart), 0);
    [self glQuadCallWithHeight:imageWidth andWidth:imageWidth];
    glPopMatrix();

    
    glPopMatrix();
}

-(void) drawFakeFlock
{

    float timer = [self.dTimer time];

    [self drawBirdWithRandomStart:45];
    
    glTranslated(-200, 100+sin(timer), 0);
    [self drawBirdWithRandomStart:90];
    
    glTranslated(200, -200, 0);
    [self drawBirdWithRandomStart:270];
    
    glTranslated(200+sin(timer), -200, 0);
    [self drawBirdWithRandomStart:-45];
    
    glTranslated(150, 50*sin(timer), 0);
    [self drawBirdWithRandomStart:-45];
    
    glTranslated(150, -50*sin(timer), 0);
    [self drawBirdWithRandomStart:-90];
    
    glTranslated(-150, 200, 0);
    [self drawBirdWithRandomStart:-270];
    
    glTranslated(-150+sin(timer), 200, 0);
    [self drawBirdWithRandomStart:45];
    
    glTranslated(-200, 50+sin(timer), 0);
    [self drawBirdWithRandomStart:45];
    
    glTranslated(-200, 50+sin(timer), 0);
    [self drawBirdWithRandomStart:90];
    
    glTranslated(200, -50, 0);
    [self drawBirdWithRandomStart:270];
    
    glTranslated(-200+sin(timer), -200, 0);
    [self drawBirdWithRandomStart:-45];
    
    glTranslated(50, 10*sin(timer), 0);
    [self drawBirdWithRandomStart:-45];
    
    glTranslated(10, -90*sin(timer), 0);
    [self drawBirdWithRandomStart:-90];
    
    glTranslated(-150, 100, 0);
    [self drawBirdWithRandomStart:-270];
    
    glTranslated(-50+sin(timer), 200, 0);
    [self drawBirdWithRandomStart:45];

}
 

-(void) resetDisplacement
{
//    self.displacement = [self.sceneController.singleTravelSegment resetDisplacementFast];
    
    self.opacitySubtractor = 0;

    self.yComponent = 0;
    self.zComponent = 0;
}


-(void) dealloc
{
    [super dealloc];
    [self.bodyTexture release];
    [self.wingTexture release];
    [self.sceneController release];
    [self.dTimer release];

}

@end

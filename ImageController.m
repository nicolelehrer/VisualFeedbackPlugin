//
//  ImageController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageController.h"

@implementation ImageController
@synthesize taskTexture0 = _taskTexture0;
@synthesize taskTexture1 = _taskTexture1;
@synthesize taskTexture2 = _taskTexture2;
@synthesize taskTexture2b = _taskTexture2b;

@synthesize taskTexture3 = _taskTexture3;
@synthesize taskTexture4 = _taskTexture4;
@synthesize taskTexture5 = _taskTexture5;
@synthesize yesButton = _yesButton;
@synthesize noButton = _noButton;
@synthesize imageOpacity = _imageOpacity;
@synthesize textImageID = _textImageID;
@synthesize imageGroupName = _imageGroupName;
@synthesize doneButton = _doneButton;
@synthesize readyButton = _readyButton;

@synthesize feedback0TRed = _feedback0TRed;
@synthesize fbTextureRealTime = _fbTextureRealTime;
@synthesize feedback0TWhite = _feedback0TWhite;

@synthesize offRestPad = _offRestPad;

@synthesize chairTexture = _chairTexture;
@synthesize markerTexture = _markerTexture;
@synthesize showButtons = _showButtons;

@synthesize replayButton = _replayButton;
@synthesize nextButton = _nextButton;
@synthesize moreDetailButton = _moreDetailButton;


- (id)init
{
	self = [super init];
    if (self) {
        [self loadTextures];
        
        //to display buttons after text done reading
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveCheckForDemoReplay:)
													 name:@"CheckForDemoReplay"
												   object:nil];
        
        
    }
	return self;
}

-(void)loadTextures
{
    self.taskTexture0 = [self loadImageWithName:@"cone0.png"];
    self.taskTexture1 = [self loadImageWithName:@"cone1.png"];
    self.taskTexture2 = [self loadImageWithName:@"cone2.png"];
    self.taskTexture2b = [self loadImageWithName:@"cone2b.png"];
    self.taskTexture3 = [self loadImageWithName:@"cone3.png"];
    self.taskTexture4 = [self loadImageWithName:@"cone4.png"];
    self.taskTexture5 = [self loadImageWithName:@"cone5.png"];
    
    self.fbTextureRealTime = [self loadImageWithName:@"feedback0T.png"];
    self.feedback0TWhite = [self loadImageWithName:@"feedback0TWhite.png"];
    self.feedback0TRed = [self loadImageWithName:@"feedback0TRed.png"];
    
    self.readyButton = [self loadImageWithName:@"readyButton.png"];
    self.yesButton = [self loadImageWithName:@"YesButton.png"];
    self.doneButton = [self loadImageWithName:@"doneButton.png"];
    self.noButton = [self loadImageWithName:@"NoButton.png"];
    
    self.offRestPad = [self loadImageWithName:@"offRestPad.png"];
    self.chairTexture = [self loadImageWithName:@"chair.png"];
    self.markerTexture = [self loadImageWithName:@"marker.png"];

    self.replayButton = [self loadImageWithName:@"replayButton.png"];
    self.nextButton = [self loadImageWithName:@"nextButton.png"];
    self.moreDetailButton = [self loadImageWithName:@"moreDetailButton.png"];


}

-(Texture2d*)loadImageWithName:(NSString*)imageName
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    NSString * fileName = [@"/textures/demo/" stringByAppendingPathComponent:imageName];
    
    return [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:fileName] target:GL_TEXTURE_RECTANGLE_ARB];
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


-(void) drawImageGroup:(NSString *)groupName WithID:(int)imageID
{
    float imageWidth = 576*5;
    float imageHeight = 362*5;
        
    glPushMatrix();
    
    glTranslated(0, 350, 0);
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );

    
    Texture2d * selectedTexture = nil;
    if ([groupName isEqualToString:@"cone"]) {
            
        if (imageID == 0) selectedTexture = self.taskTexture0;
        if (imageID == 1) selectedTexture = self.taskTexture1;
        if (imageID == 2) selectedTexture = self.taskTexture1;

        if (imageID == 3) selectedTexture = self.offRestPad;
        if (imageID == 4) selectedTexture = self.taskTexture1;

        if (imageID == 5) selectedTexture = self.taskTexture2;
        if (imageID == 6) selectedTexture = self.taskTexture2b;
        if (imageID == 7) selectedTexture = self.taskTexture3;
        if (imageID == 8) selectedTexture = self.taskTexture4;
        if (imageID == 9) selectedTexture = self.taskTexture4;
        if (imageID == 10) selectedTexture = self.taskTexture2;

        
        glColor4f(1.0, 1.0, 1.0, self.imageOpacity);
        
        if (selectedTexture != nil) {
            
            glPushMatrix();
            
            glEnable(GL_TEXTURE_RECTANGLE_ARB);
            [selectedTexture bindTexture];
            [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
            glDisable(GL_TEXTURE_RECTANGLE_ARB);

            glPopMatrix();
        }
        
    }
    
    if ([groupName isEqualToString:@"feedbackL0Visual"]) {
        
        if (imageID == 0) selectedTexture = self.feedback0TRed;
        if (imageID == 1 ||imageID == 2) selectedTexture = self.feedback0TWhite;
        
        glColor4f(1.0, 1.0, 1.0, self.imageOpacity);
        
        if (selectedTexture != nil) {
            
            glPushMatrix();
            
            glEnable(GL_TEXTURE_RECTANGLE_ARB);
            [selectedTexture bindTexture];
            [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
            glDisable(GL_TEXTURE_RECTANGLE_ARB);
            
            glPopMatrix();
        }
    }
    
    if ([groupName isEqualToString:@"marker"]) {
        
        glColor4f(1.0, 1.0, 1.0, self.imageOpacity);
      
        glPushMatrix();
        
            glTranslated(0, 500, 0);
            glEnable(GL_TEXTURE_RECTANGLE_ARB);
            [self.markerTexture bindTexture];
            [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
            glDisable(GL_TEXTURE_RECTANGLE_ARB);
        
        glPopMatrix();
    }
    
    if ([groupName isEqualToString:@"chair"]) {
    
        glColor4f(1.0, 1.0, 1.0, self.imageOpacity);
        
        glPushMatrix();
            glTranslated(0, 500, 0);
            glEnable(GL_TEXTURE_RECTANGLE_ARB);
            [self.chairTexture bindTexture];
            [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
            glDisable(GL_TEXTURE_RECTANGLE_ARB);
        glPopMatrix();
    }
    
        
    
    glPopMatrix();

    
    
}



-(void) drawButtonForGroupName:(NSString*)groupName
{
    if (([groupName isEqualToString:@"targetSetup"] ||
        [groupName isEqualToString:@"wrongTarget"] ||
        [groupName isEqualToString:@"startUp"] ||
        [groupName isEqualToString:@"marker"] ||
        [groupName isEqualToString:@"chair"] ||
        [groupName isEqualToString: @"markerLost"] ||
         [groupName isEqualToString:@"seat"]) && self.showButtons) {
        
        glColor4f(1.0, 1.0, 1.0, self.imageOpacity);
        
        glPushMatrix();
        
            glEnable(GL_TEXTURE_RECTANGLE_ARB);

            float buttonSize = 512*1.5;
        
            glTranslated(0, -1200, 0);

            [self.readyButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
            glDisable(GL_TEXTURE_RECTANGLE_ARB);
            
        glPopMatrix();
        
    }
    
    if (([groupName isEqualToString:@"sessionDone"]) && self.showButtons) {
        
        glColor4f(1.0, 1.0, 1.0, self.imageOpacity);
        
        glPushMatrix();
        
            glEnable(GL_TEXTURE_RECTANGLE_ARB);
            
            float buttonSize = 512*1.5;
            
            glTranslated(0, -900, 0);
            
            [self.doneButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
            glDisable(GL_TEXTURE_RECTANGLE_ARB);
        
        glPopMatrix();
        
    }

    if (([groupName isEqualToString:@"cone"]) && self.showButtons) {

        //allows for one more iteration in textcontroller
        
        float buttonSize = 512*1.5;

            glPushMatrix();
            
            glEnable(GL_TEXTURE_RECTANGLE_ARB);
            
            glTranslated(-buttonSize, 0, 0);
            [self.noButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
            glTranslated(buttonSize*2, 0, 0);
            [self.yesButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
            glDisable(GL_TEXTURE_RECTANGLE_ARB);
            
            glPopMatrix();
        
    }


}



-(void)receiveCheckForDemoReplay:(NSNotification*)notification
{
    self.showButtons = [[notification object] boolValue];
}

-(void) drawButtonsForInstructionType:(NSString*)instructionType
{
    if (self.showButtons) {
        
        float buttonSize = 512*1.5;
        
        glPushMatrix();
        
        
        glDisable( GL_DEPTH_TEST );
        glEnable( GL_BLEND );
        glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        glDisable( GL_LIGHTING );

        glColor4f(1.0, 1.0, 1.0, 1.0);

        glEnable(GL_TEXTURE_RECTANGLE_ARB);
        
        
        glTranslated(-buttonSize, -1500, 0);
 
        if ([instructionType isEqualToString:@"moreDetailAndNext"]) {
            [self.moreDetailButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
            glTranslated(buttonSize*2, 0, 0);
            [self.nextButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];

        }
        else if ([instructionType isEqualToString:@"moreDetailAndReplay"]){
            [self.replayButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
            glTranslated(buttonSize*2, 0, 0);
            [self.nextButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];

        }
        else if ([instructionType isEqualToString:@"nextButton"]){
     
            glTranslated(buttonSize, 0, 0);
            [self.nextButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
            
        }
       
        else if ([instructionType isEqualToString:@"readyButton"]){
            glTranslated(buttonSize, 0, 0);
            [self.readyButton bindTexture];
            [self glQuadCallWithHeight:buttonSize andWidth:buttonSize];
        }
     
       
        
               
        glDisable(GL_TEXTURE_RECTANGLE_ARB);
        
        glPopMatrix();
        
    }
    
}



@end

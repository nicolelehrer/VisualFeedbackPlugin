//
//  Dialogue.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dialogue.h"

@implementation Dialogue


@synthesize timekeeper = _timekeeper;
@synthesize lightIndicatorMid = _lightIndicatorMid;
@synthesize orderLeftRight = _orderLeftRight;

@synthesize rightToLeft = _rightToLeft;
@synthesize fadeUpLight = _fadeUpLight;
@synthesize lightOpacity = _lightOpacity;

@synthesize sceneOpacity = _sceneOpacity;
@synthesize textTransX = _textTransX;
@synthesize textTransY = _textTransY;
@synthesize textTransZ = _textTransZ;
@synthesize dialogueIntensity = _dialogueIntensity;
@synthesize imageIDs = _imageIDs;
@synthesize dialogueContents = _dialogueContents;
@synthesize dialogueKey = _dialogueKey;
@synthesize dialogueContentsPList = _dialogueContentsPList;
@synthesize dialogueDictionary = _dialogueDictionary;
@synthesize gVFAdaptationDelegate = _gVFAdaptationDelegate;
@synthesize sceneTransitionController = _sceneTransitionController;

@synthesize successTexture = _successTexture;
@synthesize tableTexture = _tableTexture;

@synthesize coneTexture0 = _coneTexture0;
@synthesize virtualTexture0 = _virtualTexture0;
@synthesize buttonTexture0 = _buttonTexture0;
@synthesize liftOnTableTexture0 = _liftOnTableTexture0;
@synthesize liftOffTableTexture0 = _liftOffTableTexture0;

@synthesize coneTexture1 = _coneTexture1;
@synthesize virtualTexture1 = _virtualTexture1;
@synthesize buttonTexture1 = _buttonTexture1;
@synthesize liftOnTableTexture1 = _liftOnTableTexture1;
@synthesize liftOffTableTexture1 = _liftOffTableTexture1;

@synthesize coneTexture2 = _coneTexture2;
@synthesize virtualTexture2 = _virtualTexture2;
@synthesize buttonTexture2 = _buttonTexture2;
@synthesize liftOnTableTexture2 = _liftOnTableTexture2;
@synthesize liftOffTableTexture2 = _liftOffTableTexture2;

@synthesize lightIndicatorIps = _lightIndicatorIps;
@synthesize orderRightLeft = _orderRightLeft;
@synthesize didReact = _didReact;

@synthesize targetObjectTextures = _targetObjectTextures;

@synthesize transportEnableErrorTexture = _transportEnableErrorTexture;
@synthesize leftErrorTexture = _leftErrorTexture;
@synthesize middleErrorTexture = _middleErrorTexture;
@synthesize rightErrorTexture = _rightErrorTexture;


@synthesize gVisualFeedback = _gVisualFeedback;

@synthesize synth = _synth;
@synthesize audioPlayer = _audioPlayer;


+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"Dialogue.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	Dialogue * node = [[Dialogue alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
    
	return node;
}



#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
		        
		
		self.dialogueContents = nil;
		self.imageIDs = nil;
		
        
		self.dialogueContentsPList = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent: @"/dialogueText.plist"];				
        
		self.dialogueKey = @"0";
		
		[self loadDialoguePListIntoArray];
		
		self.sceneOpacity = 0.0;
        
        [self createTextures];
        
        [self createSceneManagementObject];
        
//        [self initSpeakObjects];
        
        
        self.sceneTransitionController.useTimeOut = NO; //wait until they setup the targets right 
        self.sceneTransitionController.timedOutInSeconds = 3;
        self.sceneTransitionController.delayDurationInSeconds = 0.0;

        [self createTimeController];
        
        
}
	
	return self;
}


-(void) createTimeController
{
    self.timekeeper = [TimeController timekeeper];
}

-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
 
    
    self.leftErrorTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/leftError.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.rightErrorTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/rightError.png"] target:GL_TEXTURE_RECTANGLE_ARB];    
    
    self.middleErrorTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/middleError.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.transportEnableErrorTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/transportEnableError.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.lightIndicatorIps = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/lightIpsilateral.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
     self.orderRightLeft = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/orderRightLeft.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    
    self.lightIndicatorMid = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/lightMidline.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.orderLeftRight = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/orderLeftRight.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    
	self.tableTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/table.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.successTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/success.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    
    //subbing these in for now instead of lift turned on or off??
    self.liftOnTableTexture0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/leftTranspOn.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.liftOnTableTexture1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/middleTranspOn.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.liftOnTableTexture2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/rightTranspOn.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    //subbing these in for now instead of lift turned on or off??
    self.liftOffTableTexture0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/leftTranspOff.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.liftOffTableTexture1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/middleTranspOff.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.liftOffTableTexture2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/rightTranspOff.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    
    self.buttonTexture0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/button0.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.buttonTexture1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/button1.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.buttonTexture2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/button2.png"] target:GL_TEXTURE_RECTANGLE_ARB];

	
    self.virtualTexture0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/virtual0.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.virtualTexture1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/virtual1.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.virtualTexture2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/virtual2.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    self.coneTexture0 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/cone0.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.coneTexture1 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/cone1.png"] target:GL_TEXTURE_RECTANGLE_ARB];
	self.coneTexture2 = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/dialogue/cone2.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    self.targetObjectTextures = [NSArray arrayWithObjects: self.virtualTexture0, self.virtualTexture1, self.virtualTexture2,
                                                           self.coneTexture0, self.coneTexture1, self.coneTexture2, nil];
	
}


-(void) createSceneManagementObject
{
   self.sceneTransitionController = [[SceneTransitionController alloc] initWithStartValue:0 andEndValue:1 andDurationInSec:1];    
}

-(void) manageSceneTransition
{
    
    self.sceneOpacity = [self.sceneTransitionController boolAnimateOpacityForScene];
    
}





- (void) loadDialoguePListIntoArray
{
	self.dialogueDictionary = [NSDictionary dictionaryWithContentsOfFile:self.dialogueContentsPList];
    
	if (self.dialogueDictionary == nil) {
		NSLog( @"dialogueDictionary is nil");
    }
    else {
    	NSLog( @"loaded %lu componenets from dialogueDictionary", [self.dialogueDictionary count]);        
    }
	
}


- (void) updateDialogueNumber:(int)dialogueNum
{	
	if (dialogueNum < [self.dialogueDictionary count]) {									
        //check to see if dialogue number exists in pList
		
		self.dialogueKey = [[NSNumber numberWithInt:dialogueNum] stringValue];

        //convert dialogue number from int to string to use valueForKey
	}
	else {
        
		self.dialogueKey = @"0";
		NSLog(@"bad dialogue number");
	}
	
	self.dialogueContents = [self.dialogueDictionary valueForKey:self.dialogueKey];
    
//	NSLog(@"%@", [self.dialogueContents objectAtIndex:0]);
//	NSLog(@"%@", [self.dialogueContents objectAtIndex:1]);
//	NSLog(@"%@", [self.dialogueContents objectAtIndex:2]);

    //grab array with the approppriate content based on dialogueKey
	
}


-(void) glQuadCallWithHeight:(float) imageHeight andWidth:(float)imageWidth
{
    
	glBegin(GL_QUADS);
	
	float z=0.0;
    //	
    //    float adjust = [self.dTimer time]/100;
    
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


-(void) drawStaticTable 
{
    glPushMatrix();
    
    float scaleUP = 5;
    float imageWidth = scaleUP*908;
    float imageHeight = scaleUP*528;
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
    glColor4f(1, 1, 1, self.sceneOpacity);
    
    [self.tableTexture bindTexture];
    
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);
    
    glPopMatrix();
}


-(void) drawSuccessMessage
{
    glPushMatrix();
    
    float scaleUP = 5;
    float imageWidth = scaleUP*908;
    float imageHeight = scaleUP*528;
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
    glColor4f(1, 1, 1, self.sceneOpacity);
    
    [self.successTexture bindTexture];
    
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);
    
    glPopMatrix();
}


-(void) drawErrorMessageAtTarget:(int)targetLocation
{
    glPushMatrix();
    
    float scaleUP = 5;
    float imageWidth = scaleUP*908;
    float imageHeight = scaleUP*528;
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
    glColor4f(1, 1, 1, self.sceneOpacity);
    
    Texture2d * selectedTexture;
    
    if (targetLocation == 0) {
        selectedTexture = self.leftErrorTexture;
    }
    
    if (targetLocation == 1) {
        selectedTexture = self.middleErrorTexture;
    }
    
    if (targetLocation == 2) {
        selectedTexture = self.rightErrorTexture;
    }
    
//    if (targetLocation == 3) {
//        selectedTexture = self.transportEnableErrorTexture;
//    }
    
    
    [selectedTexture bindTexture];
    
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);
    
    glPopMatrix();
}

-(void) drawTargetSetup
{
    glPushMatrix();
    
    float scaleUP = 5;
    float imageWidth = scaleUP*908;
    float imageHeight = scaleUP*528;
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
    glColor4f(1, 1, 1, self.sceneOpacity);
    
    Texture2d * selectedTexture;
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeLeft == targetCone ) {
        selectedTexture = self.coneTexture0;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeLeft == targetButton) {
        selectedTexture = self.buttonTexture0;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    } 
    if (self.gVisualFeedback.adaptationDelegate.targetTypeLeft == targetVirtual) {
        selectedTexture = self.virtualTexture0;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeLeft == targetTransportOff) {
        selectedTexture = self.liftOffTableTexture0;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }

    if (self.gVisualFeedback.adaptationDelegate.targetTypeLeft == targetTransportOn) {
        selectedTexture = self.liftOnTableTexture0;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
        
       
    
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeMid == targetCone) {
        selectedTexture = self.coneTexture1;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeMid == targetButton) {
        selectedTexture = self.buttonTexture1;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    } 
    if (self.gVisualFeedback.adaptationDelegate.targetTypeMid == targetVirtual) {
        selectedTexture = self.virtualTexture1;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeMid == targetTransportOff) {
        selectedTexture = self.liftOffTableTexture1;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeMid == targetTransportOn) {
        selectedTexture = self.liftOnTableTexture1;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
       
   
    
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeRight == targetCone) {
        selectedTexture = self.coneTexture2;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeRight == targetButton) {
        selectedTexture = self.buttonTexture2;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    } 
    if (self.gVisualFeedback.adaptationDelegate.targetTypeRight == targetVirtual) {
        selectedTexture = self.virtualTexture2;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeRight == targetTransportOff) {
        selectedTexture = self.liftOffTableTexture2;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    if (self.gVisualFeedback.adaptationDelegate.targetTypeRight == targetTransportOn) {
        selectedTexture = self.liftOnTableTexture2;
        [selectedTexture bindTexture];
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];

    }
    
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);
    
    glPopMatrix();
}


-(void) drawLight 
{
    glPushMatrix();
    
    float scaleUP = 5;
    float imageWidth = scaleUP*908;
    float imageHeight = scaleUP*528;
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
     
    if (self.fadeUpLight) {
        if(self.lightOpacity<1)
        {
            self.lightOpacity = self.lightOpacity+.05;
            
        }
        if(self.lightOpacity>=1)
        {
            self.lightOpacity = 1.0;
        }
        
    }
   else {
       if(self.lightOpacity > 0)
       {
           self.lightOpacity = self.lightOpacity-.05;
           
       }
       
       if(self.lightOpacity<=0)
       {
           self.lightOpacity = 0;
       }    
   }
    
    glColor4f(1, 1, 1, self.sceneOpacity*self.lightOpacity);
    
    if (self.rightToLeft) {
        
        [self.lightIndicatorIps bindTexture];
    }
    else {
        [self.lightIndicatorMid bindTexture];
    } 

    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
    
    
    if(self.didReact)
    {
    
        glColor4f(1, 1, 1, self.sceneOpacity*(1-self.lightOpacity));
    
        if (self.rightToLeft) {

            [self.orderRightLeft bindTexture];
        }
        else {
            [self.orderLeftRight bindTexture];
        }
        
        [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
    }
    
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);
    
    glPopMatrix();
}



-(void) initSpeakObjects

{

    self.synth = [[NSSpeechSynthesizer alloc] init]; //start with default voice

    


}


- (void)speak
{
 /*   
     NSString *text = @"Good morning Thanassis.  You look well. Have you been working out?  How about that soccer match yesterday?";

//    //displaying voice names        
//     int i;
//     
//     int num = [[NSSpeechSynthesizer availableVoices] count];
//
//     for( i =0; i<num; i++) {
//    
//       NSLog(@"%@", [[NSSpeechSynthesizer availableVoices] objectAtIndex:i] );
//     
//     }
     
     NSString *voiceID =[[NSSpeechSynthesizer availableVoices] objectAtIndex:21];
    [self.synth setVoice:voiceID];
     //need to slow down rate a bit, 
    [self.synth startSpeakingString:text];
      
     
    
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
    } else {
        [self.audioPlayer play];
    }
    
    */
    
}




-(void) drawTargetWithType:(NSString*)targetType WithLocation:(NSString*)targetLocation WithOrder:(NSString*)targetOrder
{
    int targetID;
    float targetLocX;
    float targetLocY;
        
    if (targetType == @"virtual") {
        targetID = 0;
    }
    
    if (targetType == @"cone") {
        targetID = 1;
    }
    
    int locationID;
    
    if (targetLocation == @"midline") {
        locationID = 0;
        targetLocX = 0; 
        targetLocY = 0;
    }
    if (targetLocation == @"ipsilateral") {
        locationID = 1;
        targetLocX = 1000; 
        targetLocY = 0;
    }
    if (targetLocation == @"right") {
        locationID = 2;
        targetLocX = 2000; 
        targetLocY = 0;
    }
    
    int selectedTarget = 3*targetID + locationID;
    
    Texture2d * selectedTexture = [self.targetObjectTextures objectAtIndex:selectedTarget];

    float scaleUP = 5;
    float imageWidth = scaleUP*246;
    float imageHeight = scaleUP*212;

    
    glPushMatrix();
    
    glTranslated(targetLocX, targetLocY, 0);
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
    glColor4f(1, 1, 1, self.sceneOpacity);
    
    [selectedTexture bindTexture];
    
    [self glQuadCallWithHeight:imageHeight andWidth:imageWidth];
    
    glDisable(GL_TEXTURE_RECTANGLE_ARB);
    
    glPopMatrix();
}



-(void) manageTargetSetUpDialogue:(BOOL)shouldDraw
{
    if (shouldDraw) {
  
        //don't need because scnee change is simultaneous
        //    BOOL enableState = self.gVisualFeedback.adaptationDelegate.enableTaskSetup;
        //don't think we need to re-update this if i draw things mmodular
        if(self.gVisualFeedback.analysis.currentFrame.newButtonMessgaeReceived)
        {
            
            if (self.gVisualFeedback.analysis.currentFrame.middleTargetIsCorrect &&
                self.gVisualFeedback.analysis.currentFrame.leftTargetIsCorrect &&
                self.gVisualFeedback.analysis.currentFrame.rightTargetIsCorrect 
                //&& self.gVisualFeedback.analysis.currentFrame.transportEnabledIsCorrect
                ) {
                
                [self drawSuccessMessage];
                
                //need to add delay b4 fadeout  
                self.sceneTransitionController.useTimeOut = YES;
                
            }
            
            else {
                
                self.sceneTransitionController.useTimeOut = NO;
                
                if (!self.gVisualFeedback.analysis.currentFrame.leftTargetIsCorrect) {
                    
                    [self drawErrorMessageAtTarget:0];
                }
                
                if (!self.gVisualFeedback.analysis.currentFrame.middleTargetIsCorrect) {
                    
                    [self drawErrorMessageAtTarget:1];
                }
                
                if (!self.gVisualFeedback.analysis.currentFrame.rightTargetIsCorrect) {
                    
                    [self drawErrorMessageAtTarget:2];
                }
                
//                if (!self.gVisualFeedback.analysis.currentFrame.transportEnabledIsCorrect) {
//                    
//                    [self drawErrorMessageAtTarget:3];
//                }
            }
        }
    }
    
    else {
        self.gVisualFeedback.analysis.currentFrame.newButtonMessgaeReceived = NO;
        self.sceneTransitionController.useTimeOut = NO;
    }


}


- (void) drawShape:(GraphicsState *)state
{
    [self manageSceneTransition];
    
        if (self.sceneTransitionController.shouldDrawScene)
        {
            
           
            glDisable( GL_DEPTH_TEST );
            glEnable( GL_BLEND );
            glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
            glDisable( GL_LIGHTING );

            
//            [self updateDialogueNumber:self.gVisualFeedback.adaptationDelegate.dialogueNumber];
            [self drawStaticTable];
            [self drawTargetSetup];
        }

    [self manageTargetSetUpDialogue:self.sceneTransitionController.shouldDrawScene];

    
}

- (void) setVisualFeedback:(VisualFeedback *)f
{
	self.gVisualFeedback = f;
}


- (void) dealloc
{
 	[super dealloc];
}


@end


//
//  TargetSetup.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/28/12.
//
//

#import "TargetSetup.h"
#import "TextureController.h"

@interface TargetSetup()

@property(retain) Texture2d * tableTexture;
@property(retain) Texture2d * successTexture;
@property(retain) Texture2d * leftErrorTexture;
@property(retain) Texture2d * rightErrorTexture;
@property(retain) Texture2d * middleErrorTexture;
@property(retain) Texture2d * coneTexture0;
@property(retain) Texture2d * virtualTexture0;
@property(retain) Texture2d * buttonTexture0;
@property(retain) Texture2d * liftOnTableTexture0;
@property(retain) Texture2d * liftOffTableTexture0;

@property(retain) Texture2d * coneTexture1;
@property(retain) Texture2d * virtualTexture1;
@property(retain) Texture2d * buttonTexture1;
@property(retain) Texture2d * liftOnTableTexture1;
@property(retain) Texture2d * liftOffTableTexture1;

@property(retain) Texture2d * coneTexture2;
@property(retain) Texture2d * virtualTexture2;
@property(retain) Texture2d * buttonTexture2;
@property(retain) Texture2d * liftOnTableTexture2;
@property(retain) Texture2d * liftOffTableTexture2;

@property(retain) Texture2d * leftCylinder;
@property(retain) Texture2d * middleCylinder;
@property(retain) Texture2d * rightCylinder;
@property(retain) Texture2d * leftTransCone;
@property(retain) Texture2d * middleTransCone;
@property(retain) Texture2d * rightTransCone;

@property(retain) Texture2d * left1;
@property(retain) Texture2d * left2;
@property(retain) Texture2d * middle1;
@property(retain) Texture2d * middle2;
@property(retain) Texture2d * right1;
@property(retain) Texture2d * right2;


@property(retain) Texture2d * middleArrow;
@property(retain) Texture2d * rightArrow;
@property(retain) Texture2d * leftArrow;
@property(retain) Texture2d * whiteTableSizedTexture;

@end

@implementation TargetSetup
@synthesize tableTexture = _tableTexture;
@synthesize sceneOpacity = _sceneOpacity;
@synthesize leftErrorTexture = _leftErrorTexture;
@synthesize rightErrorTexture = _rightErrorTexture;
@synthesize middleErrorTexture = _middleErrorTexture;

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

@synthesize targetTypeLeft = _targetTypeLeft;
@synthesize targetTypeMid = _targetTypeMid;
@synthesize targetTypeRight = _targetTypeRight;

@synthesize leftTargetIsCorrect = _leftTargetIsCorrect;
@synthesize middleTargetIsCorrect = _middleTargetIsCorrect;
@synthesize rightTargetIsCorrect = _rightTargetIsCorrect;
@synthesize transportEnabledIsCorrect = _liftEnabledIsCorrect;

@synthesize speechTag = _speechTag;

@synthesize leftCylinder = _leftCylinder;
@synthesize middleCylinder = _middleCylinder;
@synthesize rightCylinder = _rightCylinder;
@synthesize leftTransCone = _leftTransCone;
@synthesize middleTransCone = _middleTransCone;
@synthesize rightTransCone = _rightTransCone;

@synthesize targetID1ForL3 = _targetID1ForL3;
@synthesize targetID2ForL3 = _targetID2ForL3;
@synthesize isTransportTask = _isTransportTask;

@synthesize left1 = _left1;
@synthesize left2 = _left2;
@synthesize middle1 = _middle1;
@synthesize middle2 = _middle2;
@synthesize right1 = _right1;
@synthesize right2 = _right2;

@synthesize leftArrow = _leftArrow;
@synthesize rightArrow = _rightArrow;
@synthesize middleArrow = _middleArrow;

@synthesize whiteTableSizedTexture = _whiteTableSizedTexture;

- (id)init
{
	self = [super init];
    if (self) {
     
        [self createTextures];
    }
	return self;
}


-(Texture2d*)loadImageWithName:(NSString*)imageName
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    NSString * fileName = [@"/textures/dialogue/" stringByAppendingPathComponent:imageName];
    
    return [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:fileName] target:GL_TEXTURE_RECTANGLE_ARB];
}

-(void) createTextures
{
    
    self.whiteTableSizedTexture = [self loadImageWithName:@"tableWhite.png"];

    self.tableTexture = [self loadImageWithName:@"table.png"];
    self.successTexture = [self loadImageWithName:@"success.png"];

    self.leftErrorTexture = [self loadImageWithName:@"leftError.png"];
    self.rightErrorTexture = [self loadImageWithName:@"rightError.png"];
    self.middleErrorTexture = [self loadImageWithName:@"middleError.png"];

    self.buttonTexture0 = [self loadImageWithName:@"button0.png"];
    self.virtualTexture0 = [self loadImageWithName:@"virtual0.png"];
    self.coneTexture0 = [self loadImageWithName:@"cone0.png"];
    
    self.liftOnTableTexture0 = [self loadImageWithName:@"leftTranspOn.png"];
    self.liftOffTableTexture0 = [self loadImageWithName:@"leftTranspOff.png"];

    self.buttonTexture1 = [self loadImageWithName:@"button1.png"];
    self.virtualTexture1 = [self loadImageWithName:@"virtual1.png"];
    self.coneTexture1 = [self loadImageWithName:@"cone1.png"];
    
    self.liftOnTableTexture1 = [self loadImageWithName:@"middleTranspOn.png"];
    self.liftOffTableTexture1 = [self loadImageWithName:@"middleTranspOff.png"];
    
    self.buttonTexture2 = [self loadImageWithName:@"button2.png"];
    self.virtualTexture2 = [self loadImageWithName:@"virtual2.png"];
    self.coneTexture2 = [self loadImageWithName:@"cone2.png"];
    
    self.liftOnTableTexture2 = [self loadImageWithName:@"rightTranspOn.png"];
    self.liftOffTableTexture2 = [self loadImageWithName:@"rightTranspOff.png"];
    
    
    self.leftCylinder = [self loadImageWithName:@"cylinder0.png"];
    self.middleCylinder = [self loadImageWithName:@"cylinder1.png"];
    self.rightCylinder = [self loadImageWithName:@"cylinder2.png"];
    
    self.leftTransCone = [self loadImageWithName:@"transCone0.png"];
    self.middleTransCone = [self loadImageWithName:@"transCone1.png"];
    self.rightTransCone = [self loadImageWithName:@"transCone2.png"];
    
    self.left1 = [self loadImageWithName:@"1.png"];
    self.left2 = [self loadImageWithName:@"2.png"];
   
    self.middle1 = [self loadImageWithName:@"1middle.png"];
    self.middle2 = [self loadImageWithName:@"2middle.png"];

    self.right1 = [self loadImageWithName:@"1right.png"];
    self.right2 = [self loadImageWithName:@"2right.png"];

    self.leftArrow =  [self loadImageWithName:@"leftArrow.png"];
    self.rightArrow =  [self loadImageWithName:@"rightArrow.png"];
    self.middleArrow =  [self loadImageWithName:@"middleArrow.png"];

}

-(void) drawQuadWithHeight:(float) imageHeight andWidth:(float)imageWidth WithTexture:(Texture2d*)texture
{
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable(GL_LIGHTING);

    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
        glColor4f(1, 1, 1, self.sceneOpacity);
    
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

    glDisable(GL_TEXTURE_RECTANGLE_ARB);

}


-(void) drawStaticTable
{
    glPushMatrix();
        float scaleUP = 2;
        float imageWidth = scaleUP*2592;
        float imageHeight = scaleUP*1936;

        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.tableTexture];
    glPopMatrix();
}
-(void) drawWhiteTableSizedBG
{
    glPushMatrix();
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
    [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.whiteTableSizedTexture];
    glPopMatrix();
}

-(void) sendSuccessMessage
{
    glPushMatrix();
        float scaleUP = 5;
        float imageWidth = scaleUP*908;
        float imageHeight = scaleUP*528;
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.successTexture];
    glPopMatrix();
}

-(void) drawErrorMessageAtTarget:(int)targetLocation
{
    glPushMatrix();
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
        if (targetLocation == 0) {
            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftErrorTexture];
        }
        if (targetLocation == 1) {
            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleErrorTexture];
        }
        if (targetLocation == 2) {
            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightErrorTexture];
        }
        //    if (targetLocation == 3) {
        //        selectedTexture = self.transportEnableErrorTexture;
        //    }
    
    glPopMatrix();
}

-(void) drawCorrectTargetSetupWithArrows:(BOOL)doIncludeArrows
{
    
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
    Texture2d * selectedTexture = nil;
    
    glPushMatrix();
    
        if (self.targetTypeLeft == targetCone) selectedTexture = self.coneTexture0;
        if (self.targetTypeLeft == targetButton) selectedTexture = self.buttonTexture0;
        if (self.targetTypeLeft == targetVirtual) selectedTexture = self.virtualTexture0;
        if (self.targetTypeLeft == targetTransportOn) selectedTexture = self.liftOnTableTexture0;
        if (self.targetTypeLeft == targetTransportOff) selectedTexture = self.liftOffTableTexture0;

    if (selectedTexture != nil) {
        if (doIncludeArrows) {
            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftArrow];    
        }
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:selectedTexture];
    }
    
    selectedTexture = nil;

        if (self.targetTypeMid == targetCone) selectedTexture = self.coneTexture1;
        if (self.targetTypeMid == targetButton) selectedTexture = self.buttonTexture1;
        if (self.targetTypeMid == targetVirtual) selectedTexture = self.virtualTexture1;
        if (self.targetTypeMid == targetTransportOn) selectedTexture = self.liftOnTableTexture1;
        if (self.targetTypeMid == targetTransportOff) selectedTexture = self.liftOffTableTexture1;
    
    if (selectedTexture != nil) {
        if (doIncludeArrows) {
            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleArrow];
        }
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:selectedTexture];
        
    }

    selectedTexture = nil;

        if (self.targetTypeRight == targetCone) selectedTexture = self.coneTexture2;
        if (self.targetTypeRight == targetButton) selectedTexture = self.buttonTexture2;
        if (self.targetTypeRight == targetVirtual) selectedTexture = self.virtualTexture2;
        if (self.targetTypeRight == targetTransportOn) selectedTexture = self.liftOnTableTexture2;
        if (self.targetTypeRight == targetTransportOff) selectedTexture = self.liftOffTableTexture2;
    
    if (selectedTexture != nil) {
        if (doIncludeArrows) {
            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightArrow];
        }
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:selectedTexture];
        
    }
    
    glPopMatrix();
}


-(void)drawCylinderPlacementReminderAtLocation:(TargetSelection)targetLocation 
{
    glPushMatrix();
    glTranslated(0, -400, 0);
    [self drawCorrectTargetSetupWithArrows:NO];
    glPopMatrix();

    
    glPushMatrix();
  
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
    glTranslated(0, 100, 0);

    float shifterDown = -1200;
    float shifterUp = -510;
    
    if (targetLocation == leftOnTransport) {
        
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftCylinder];
        glPopMatrix();
    }
    
    if (targetLocation == leftOffTransport) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftCylinder];
        glPopMatrix();
    }
        
    if (targetLocation == middleOnTransport) {
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleCylinder];
        glPopMatrix();
    }
    if (targetLocation == middleOffTransport) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleCylinder];
        glPopMatrix();
    }
    if (targetLocation == rightOnTransport) {
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightCylinder];
        glPopMatrix();
    }
    if (targetLocation ==  rightOffTransport) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightCylinder];
        glPopMatrix();
    }

    glPopMatrix();
    
    
    
}

-(void)drawConePlacementReminderAtLocation:(TargetSelection)targetLocation
{
    
    glPushMatrix();
    glTranslated(0, -400, 0);
    [self drawCorrectTargetSetupWithArrows:NO];
    glPopMatrix();
    
    
    glPushMatrix();
    
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
    glTranslated(0, 100, 0);
    
    float shifterDown = -1200;
    float shifterUp = -510;
    
    if (targetLocation == leftOnTransportCone) {
        
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftTransCone];
        glPopMatrix();
    }
    
    if (targetLocation == leftOffTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftTransCone];
        glPopMatrix();
    }
    
    if (targetLocation == middleOnTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleTransCone];
        glPopMatrix();
    }
    if (targetLocation == middleOffTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleTransCone];
        glPopMatrix();
    }
    if (targetLocation == rightOnTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightTransCone];
        glPopMatrix();
    }
    if (targetLocation ==  rightOffTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightTransCone];
        glPopMatrix();
    }
    
    glPopMatrix();
    
    
    
}





-(void)drawOnlyConePlacementWithNoTableAtLocation:(TargetSelection)targetLocation
{
    
        
    glPushMatrix();
    
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
    glTranslated(0, 100, 0);
    
    float shifterDown = -1200;
    float shifterUp = -510;
    
    if (targetLocation == leftOnTransportCone) {
        
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftTransCone];
        glPopMatrix();
    }
    
    if (targetLocation == leftOffTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftTransCone];
        glPopMatrix();
    }
    
    if (targetLocation == middleOnTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleTransCone];
        glPopMatrix();
    }
    if (targetLocation == middleOffTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middleTransCone];
        glPopMatrix();
    }
    if (targetLocation == rightOnTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterDown, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightTransCone];
        glPopMatrix();
    }
    if (targetLocation ==  rightOffTransportCone) {
        glPushMatrix();
        glTranslated(0, shifterUp, 0);
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightTransCone];
        glPopMatrix();
    }
    
    glPopMatrix();
    
    
    
}





-(void)drawLevel3ReminderForTarget1:(TargetSelection)targetLocation1 andTarget2:(TargetSelection)targetLocation2
{
 
    float scaleUP = 2;
    float imageWidth = scaleUP*2592;
    float imageHeight = scaleUP*1936;
    
    [self drawWhiteTableSizedBG];
    
    
    
//    [self drawCylinderPlacementReminderAtLocation:targetLocation1];
//    
//    [self drawCylinderPlacementReminderAtLocation:targetLocation2];
    
    glPushMatrix();
    glTranslated(-150, 300, 0);
    if (targetLocation1 == leftButton ||
        targetLocation1 == leftCone ||
        targetLocation1 == leftVirtual ||
        targetLocation1 == leftOffTransport ||
        targetLocation1 == leftOnTransport ||
        targetLocation1 == leftOnTransportCone ||
        targetLocation1 == leftOffTransportCone ) {
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.left1];
    }
    
    if (targetLocation1 == rightButton ||
        targetLocation1 == rightCone ||
        targetLocation1 == rightVirtual ||
        targetLocation1 == rightOffTransport ||
        targetLocation1 == rightOnTransport ||
        targetLocation1 == rightOnTransportCone ||
        targetLocation1 == rightOffTransportCone ) {
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.right1];
    }
    
    if (targetLocation1 == middleButton ||
        targetLocation1 == middleCone ||
        targetLocation1 == middleVirtual ||
        targetLocation1 == middleOffTransport ||
        targetLocation1 == middleOnTransport ||
        targetLocation1 == middleOnTransportCone ||
        targetLocation1 == middleOffTransportCone ) {
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middle1];
    }
    
    ////
    
    if (targetLocation2 == leftButton ||
        targetLocation2 == leftCone ||
        targetLocation2 == leftVirtual ||
        targetLocation2 == leftOffTransport ||
        targetLocation2 == leftOnTransport ||
        targetLocation2 == leftOnTransportCone ||
        targetLocation2 == leftOffTransportCone ) {
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.left2];
    }
    
    if (targetLocation2 == rightButton ||
        targetLocation2 == rightCone ||
        targetLocation2 == rightVirtual ||
        targetLocation2 == rightOffTransport ||
        targetLocation2 == rightOnTransport ||
        targetLocation2 == rightOnTransportCone ||
        targetLocation2 == rightOffTransportCone) {
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.right2];
    }
    
    if (targetLocation2 == middleButton ||
        targetLocation2 == middleCone ||
        targetLocation2 == middleVirtual ||
        targetLocation2 == middleOffTransport ||
        targetLocation2 == middleOnTransport ||
        targetLocation2 == middleOnTransportCone ||
        targetLocation2 == middleOffTransportCone) {
        
        [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.middle2];
        
    }
    
    
    if (self.isTransportTask) {
        
        if (targetLocation1 == leftOffTransport ||
            targetLocation1 == leftOnTransport ) {
            
//            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.leftArrow];

        }
        else{
        
//            [self drawQuadWithHeight:imageHeight andWidth:imageWidth WithTexture:self.rightArrow];

        }
    }
    
    
    glPopMatrix();
    
    glPushMatrix();
    glTranslated(0, -300, 0);
    [self drawCorrectTargetSetupWithArrows:NO];
    glPopMatrix();


    
    [self drawOnlyConePlacementWithNoTableAtLocation:targetLocation1];
    [self drawOnlyConePlacementWithNoTableAtLocation:targetLocation2];
    
    
}





-(void) drawTargetDemowithResultsIf:(BOOL)readyToAssess
{
    glPushMatrix();
    glTranslated(0, 550, 0);
    
        [self drawStaticTable];
        [self drawCorrectTargetSetupWithArrows:YES];

        if (readyToAssess) {
            
            if (!self.leftTargetIsCorrect) {
                [self drawErrorMessageAtTarget:0];
            }
            if (!self.middleTargetIsCorrect) {
                [self drawErrorMessageAtTarget:1];
            }
            if (!self.rightTargetIsCorrect) {
                [self drawErrorMessageAtTarget:2];
            }
            
        }
    glPopMatrix();
}




@end

//
//  Level3SceneDrawer.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level3SceneDrawer.h"

@implementation Level3SceneDrawer

@synthesize manipQualityThird;
@synthesize manipQualityFourth;

@synthesize gFirstTarget = _gFirstTarget;
@synthesize gSecondTarget = _gSecondTarget;

@synthesize currentFrame = _currentFrame;

@synthesize drawFirstIsland = _drawFirstIsland;
@synthesize drawSecondIsland = _drawSecondIsland;
@synthesize drawBirds = _drawBirds;

@synthesize sceneTransitionDictionary = _sceneTransitionDictionary;
@synthesize isOrderRightToLeft = _isOrderRightToLeft;
@synthesize drawDayBoat = _drawDayBoat;
@synthesize drawCloudyBoat = _drawCloudyBoat;
@synthesize drawMildBoat = _drawMildBoat;


@synthesize travelQuality = _travelQuality;


@synthesize showEfficientSimpleTask = _showEfficientSimpleTask;
@synthesize showInEfficientSimpleTask = _showInEfficientSimpleTask;
@synthesize showMildSimpleTask = _showMildSimpleTask;

@synthesize showEfficientComplexTask = _showEfficientComplexTask;
@synthesize showInEfficientComplexTask = _showInEfficientComplexTask;
@synthesize showMildComplexTask = _showMildComplexTask;

@synthesize secondIslandRatio = _secondIslandRatio;
@synthesize blackSquareTexture = _blackSquareTexture;
@synthesize blackCoverOpacity = _blackCoverOpacity;
@synthesize fogControl = _fogControl;
@synthesize blackBlockerTransX = _blackBlockerTransX;
@synthesize blackBlockerTransY = _blackBlockerTransY;
@synthesize blackBlockerTransZ = _blackBlockerTransZ;

@synthesize blackBlockerScaleX = _blackBlockerScaleX;
@synthesize blackBlockerScaleY = _blackBlockerScaleY;
@synthesize blackBlockerScaleZ = _blackBlockerScaleZ;

@synthesize sceneTransY;
@synthesize sceneTransZ;

@synthesize mildBoatTexture = _mildBoatTexture;
@synthesize cloudyBoatTexture = _cloudyBoatTexture;
@synthesize dayBoatTexture = _dayBoatTexture;
@synthesize blackFrame = _blackFrame;

@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize level3WaterController = _level3WaterController;
@synthesize skyController = _skyController;
@synthesize islandControllerFirst = _islandControllerFirst;
@synthesize islandControllerSecond = _islandControllerSecond;
@synthesize islandController3 = _islandController3;
@synthesize islandController4 = _islandController4;

@synthesize islandController = _islandController;
@synthesize birdsController = _birdsController;
@synthesize sceneTransitionController = sceneTransitionController;
@synthesize weatherController = _weatherController;
@synthesize sceneController = _sceneController;

@synthesize boatRotX = _boatRotX;
@synthesize boatRotY = _boatRotY;
@synthesize boatRotZ = _boatRotZ;

@synthesize boatTransX = _boatTransX;
@synthesize boatTransY = _boatTransY;
@synthesize boatTransZ = _boatTransZ;
@synthesize boatOpacity = _boatOpacity;

@synthesize boatScaleX = _boatScaleX;
@synthesize boatScaleY = _boatScaleY;
@synthesize boatScaleZ = _boatScaleZ;
@synthesize dTimer = _dTimer;

@synthesize transportQuality = _transportQuality;
@synthesize manipQualityFirst = _manipQualityFirst;
@synthesize manipQualitySecond = _manipQualitySecond;
@synthesize manipTypeFirst = _manipTypeFirst;
@synthesize manipTypeSecond = _manipTypeSecond;

@synthesize showWind = _showWind;
@synthesize showRockyRide = _showRockyRide;
@synthesize showRainFadeIn = _showRainFadeIn;

@synthesize showRainConstantHeavy = _showRainConstantHeavy;
@synthesize showRainConstantLight = _showRainConstantLight;

@synthesize showCloudsFadeIn = _showCloudsFadeIn;
@synthesize showCloudsConstant = _showCloudsConstant;
@synthesize showSnowFadeIn = _showSnowFadeIn;
@synthesize showSnowConstant = _showSnowConstant;


@synthesize showDayWater = _showDayWater;
@synthesize showNightToDay = _showNightToDay;
@synthesize showDaySkyConstant = _showDaySkyConstant;
@synthesize showDayToGrey = _showDayToGrey;
@synthesize showRoughWater = _showRoughWater;
@synthesize showVeryRoughWater = _showVeryRoughWater;
@synthesize showGreySky = _showGreySky;

@synthesize showBlueToWhiteClouds = _showBlueToWhiteClouds;
@synthesize showWhiteCloudsConstant = _showWhiteCloudsConstant;

@synthesize testX = _testX;
@synthesize testY = _testY;
@synthesize testrotX = _testrotX;
@synthesize testrotY = _testrotY;


+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"ScenarioDrawer.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	Level3SceneDrawer * node = [[Level3SceneDrawer alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}

#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {

        self.isOrderRightToLeft = NO;
        
        [self createTextures];
        [self createSceneObjects];
        
        self.sceneTransitionController.useTimeOut = YES;
        self.sceneTransitionController.timedOutInSeconds = 10; //1 sec less than animation so you don't see it stop, need to connect the two with a var
        self.sceneTransitionController.delayDurationInSeconds = 0;
        
        
        self.blackBlockerScaleX = 6000;
        self.blackBlockerScaleY = 2559.5;
        self.blackBlockerTransY = 12;

        
//        self.boatScaleX = 2;
//        self.boatScaleY = 3;
//        self.boatRotX = -66;
//        self.boatTransY = -1155;
//        self.boatTransZ = -3000;
        
        [self createDictionaryForAudio];
        
    }
    
	return self;
}


-(void) createTextures
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    
	self.dayBoatTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/boat.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.cloudyBoatTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/cloudyBoat.png"] target:GL_TEXTURE_RECTANGLE_ARB];
    
    self.mildBoatTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/mildBoat.png"] target:GL_TEXTURE_RECTANGLE_ARB];

    
     self.blackFrame = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/waterWood/blackFrame.png"] target:GL_TEXTURE_2D];

    self.blackSquareTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/level3/blackSquare.png"] target:GL_TEXTURE_2D];

}

-(void) createDictionaryForAudio
{    
    self.sceneTransitionDictionary = [[NSMutableDictionary alloc] init];
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

-(void) drawBoatWithQuality:(int) qualityType
{
    float boatScaleXt = 2;
    float boatScaleYt = 3;
    float boatRotXt = -66;
    float boatTransYt = -1275;
    float boatTransZt = -3000;
    
    glColor4f(1, 1, 1, self.boatOpacity);
    
    glPushMatrix();
    
    glTranslated(0, boatTransYt, boatTransZt);
    glRotated(boatRotXt, 1, 0, 0);
    glRotated(0, 0, 1, 0);
    glRotated(0, 0, 0, 1);
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );
    
    
    glEnable( GL_TEXTURE_RECTANGLE_ARB );
    
    if (qualityType == 0) {
        [self.dayBoatTexture bindTexture];
        [self glQuadCallWithHeight:1500*(1+boatScaleYt) andWidth:1500*(1+boatScaleXt)];
    }
    
    if (qualityType == 1) {
        [self.mildBoatTexture bindTexture];
        [self glQuadCallWithHeight:1500*(1+boatScaleYt) andWidth:1500*(1+boatScaleXt)];
    }
    
    if (qualityType == 2) {
        [self.cloudyBoatTexture bindTexture];
        [self glQuadCallWithHeight:1500*(1+boatScaleYt) andWidth:1500*(1+boatScaleXt)];
    }
    
    glDisable( GL_TEXTURE_RECTANGLE_ARB );

    glPopMatrix();
    


}


-(void) createTimer
{
    self.dTimer = [TimeController timekeeper];
}


-(void) createSceneObjects
{
    [self createTimer];
    self.sceneController = [[Level3SceneController alloc] init];
    
    self.sceneTransitionController = [[SceneTransitionController alloc] initWithStartValue:0 andEndValue:1 andDurationInSec:1];  
    
    self.level3WaterController =  [[Level3WaterController alloc] init];
    
    self.skyController = [[SkyController alloc] init];
    
    self.islandControllerSecond = [[IslandController alloc] initWithPositionX:120000 andPositionY:15000 andPositionZ:-206080];
    self.islandController = [[IslandController alloc] initWithPositionX:-120000 andPositionY:13000 andPositionZ:-350000];
    
    self.islandController3 = [[IslandController alloc] initWithPositionX:120000 andPositionY:2*15000 andPositionZ:2*-206080];
    self.islandController4 = [[IslandController alloc] initWithPositionX:-120000 andPositionY:2*13000 andPositionZ:2*-350000];

    
        
    self.birdsController = [[BirdsController alloc] init];
    
    self.weatherController = [[WeatherController alloc] init];
    
    

    self.islandController.speedFactor = 30;
    self.islandControllerSecond.speedFactor = 30;

    self.secondIslandRatio = 3;
    
    self.sceneController.transportQuality1 = 0;
    self.sceneController.transportQuality2 = 1;
    
    self.level3WaterController.level3SceneController = self.sceneController;
    
}


-(void) sendNotificationOfSceneTransitions 
{

    [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:self.sceneTransitionController.shouldDrawScene] forKey:@"shouldDrawScene"];

    //need to update Todd
    
    if (self.travelQuality == 0) {
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"showEfficientSimpleTask"];
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"showInEfficientSimpleTask"];
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"showMildSimpleTask"];
    }
    if (self.travelQuality == 1) {
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"showEfficientSimpleTask"];
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"showInEfficientSimpleTask"];
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"showMildSimpleTask"];
    }
    if (self.travelQuality == 2) {
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"showEfficientSimpleTask"];
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"showInEfficientSimpleTask"];
        [self.sceneTransitionDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"showMildSimpleTask"];
    }
    
    [self.sceneTransitionDictionary setObject:[NSNumber numberWithInt:self.travelQuality] forKey:@"travelQuality"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Level3SceneTransition" object:self.sceneTransitionDictionary];
}





-(void) manageSceneTransition
{    
    float sceneOpacity = [self.sceneTransitionController boolAnimateOpacityForScene];
        
    self.level3WaterController.waterSheet.opacity = sceneOpacity;
    self.skyController.skyOpacity = sceneOpacity;
    self.islandController.islandOpacity = sceneOpacity;
    self.islandControllerSecond.islandOpacity = sceneOpacity;
    self.islandController3.islandOpacity = sceneOpacity;
    self.islandController4.islandOpacity = sceneOpacity;

    self.weatherController.rainOpacity = sceneOpacity;
    self.birdsController.birdOpacity = sceneOpacity;
    self.blackCoverOpacity = 1-sceneOpacity;
    self.boatOpacity = sceneOpacity;
        
    //reset any objects' values that need it
    
    //test
//    if(self.sceneTransitionController.sceneDidChange && self.sceneTransitionController.previousSceneID !=levelID) {        

    if (self.sceneTransitionController.oneTimeResetAfterFadeDown) {

        [self.level3WaterController resetDisplacement];
        [self.islandController resetDisplacement];
        [self.islandControllerSecond resetDisplacement];
        [self.islandController3 resetDisplacement];
        [self.islandController4 resetDisplacement];

        [self.skyController resetVals]; 
        [self.birdsController resetDisplacement];
        
    }

}



-(void) updateCameraLocation
{
    [[[Dash dashView] cam] setTranslateZ: 6640.0];
    [[[Dash dashView] cam] setTranslateY: 0.0];
    
}


- (void) drawShape:(GraphicsState *)state
{
    
//    NSLog(@"self.currentFrame.manipQualityTargetID1 from level3draw is %i", self.currentFrame.manipQualityTargetID1);
//    NSLog(@"self.currentFrame.manipQualityTargetID2 from level3draw is %i", self.currentFrame.manipQualityTargetID2);
//    

    
    if (self.gVisualFeedback.currEnabledLevel == kLevel3Sequence ||
        self.gVisualFeedback.currEnabledLevel == kLevel3Transport) {
        
        if(self.gVisualFeedback.currEnabledLevel == kLevel3Sequence)
        {
            self.sceneTransitionController.timedOutInSeconds = 4; 

            self.islandController.level3SceneController.singleTravelSegment.stopDisplacement = YES;
            self.islandControllerSecond.level3SceneController.singleTravelSegment.stopDisplacement = YES;
            self.level3WaterController.level3SceneController.singleTravelSegment.stopDisplacement = YES;
            
        }
        
        if(self.gVisualFeedback.currEnabledLevel == kLevel3Transport)
        {
            self.sceneTransitionController.timedOutInSeconds = 10; 

            self.islandController.level3SceneController.singleTravelSegment.stopDisplacement = NO;
            self.islandControllerSecond.level3SceneController.singleTravelSegment.stopDisplacement = NO;
            self.level3WaterController.level3SceneController.singleTravelSegment.stopDisplacement = NO;
            
        }
        
        
        [self manageSceneTransition];
        
        [self updateCameraLocation];
        
        [self sendNotificationOfSceneTransitions];        
        
        if (self.sceneTransitionController.shouldDrawScene) {
            
            glPushMatrix();
            
                glScaled(.5+self.sceneTransZ, .5+self.sceneTransY, 1);            
            
                if (self.travelQuality == 0) {
                    [self drawGoodTravelConditions];
                }
                
                if (self.travelQuality == 1) {
                    [self drawMildTravelConditions];
                }
                
                if (self.travelQuality == 2) {
                    [self drawSevereTravelConditions];
                }
            
            glPopMatrix();
                        
            [state pushMatrixReset2d];
            
                [self drawBlockersWithState:state];
           
            [state popMatrix];
            
        }
        
    }

}


-(void) drawGoodTravelConditions
{
    
    glPushMatrix();
    
    float timing = [self.dTimer time];
    
    glRotated(.1*sin(timing), 1, 0, 0);
    glRotated(.1*sin(timing/5), 0, 1, 0);
    glRotated(.2*sin(timing), 0, 0, 1);

        [self connectToAdaptationAndAnalysis];
        
        [self.skyController drawClearSky];
        
        [self.islandController drawHorizonIslandDay];
        
        [self.level3WaterController drawDayWater];
        
        [self.islandController drawBlueFogOverlay];
       
//        [self manageTargetSelectionWithFirstTarget:self.manipTypeFirst 
//                         WithFirstPerformanceLevel:self.manipQualityFirst
//                                   AndSecondTarget:99
//                        WithSecondPerformanceLevel:99
//                                InOrderRightToLeft:self.isOrderRightToLeft 
//                                InTravelConditions:0];
//        
//        
//        [self secondManageTargetSelectionWithFirstTarget:99 
//                               WithFirstPerformanceLevel:99
//                                         AndSecondTarget:self.manipTypeSecond
//                              WithSecondPerformanceLevel:self.manipQualitySecond
//                                      InOrderRightToLeft:self.isOrderRightToLeft 
//                                      InTravelConditions:0];
        
        [self manageTargetSelectionWithFirstTarget:self.manipTypeFirst 
                         WithFirstPerformanceLevel:self.manipQualityFirst
                                   AndSecondTarget:self.manipTypeSecond
                        WithSecondPerformanceLevel:self.manipQualitySecond
                         WithThirdPerformanceLevel:self.gVisualFeedback.analysis.currentFrame.manipQualityTargetID3 
                        WithFourthPerformanceLevel:self.gVisualFeedback.analysis.currentFrame.manipQualityTargetID4 
                                InOrderRightToLeft:self.isOrderRightToLeft 
                                InTravelConditions:0];
    
        [self drawBoatWithQuality:0];
    
    glPopMatrix();
}

-(void) drawMildTravelConditions
{              
    [self connectToAdaptationAndAnalysis];
    
    glPushMatrix();
    
            float timing = [self.dTimer time];
            
            glRotated(.1*sin(timing), 1, 0, 0);
            glRotated(.1*sin(timing/5), 0, 1, 0);
            glRotated(sin(timing), 0, 0, 1);

        
            [self.skyController drawGreySky];
            
            [self.islandController drawHorizonIslandGrey];
            
            [self.level3WaterController drawGreyWater];
            
            [self.islandController drawGreyFogOverlay];
        
        

        
            [self manageTargetSelectionWithFirstTarget:self.manipTypeFirst
                             WithFirstPerformanceLevel:self.manipQualityFirst
                                       AndSecondTarget:self.manipTypeSecond
                            WithSecondPerformanceLevel:self.manipQualitySecond
                             WithThirdPerformanceLevel:self.gVisualFeedback.analysis.currentFrame.manipQualityTargetID3 
                            WithFourthPerformanceLevel:self.gVisualFeedback.analysis.currentFrame.manipQualityTargetID4 
                                    InOrderRightToLeft:self.isOrderRightToLeft 
                                    InTravelConditions:1];
        
            [self drawBoatWithQuality:1];
    
    [self.islandController  drawHorizonIslandGreyExtended];
//            [self.skyController drawCloud];
    glPopMatrix();

}

-(void) drawSevereTravelConditions
{              
        [self connectToAdaptationAndAnalysis];
        
        glPushMatrix();
        
            float timing = [self.dTimer time];
            
            glRotated(.3*sin(timing), 1, 0, 0);
            glRotated(.3*sin(timing/5), 0, 1, 0);
            glRotated(2*sin(timing), 0, 0, 1);
            
            [self.skyController drawStormySkyWithLightening:YES];
        
            self.level3WaterController.waterSheet.colorFactor  = self.skyController.randOpac;
            
            [self.islandController drawHorizonIslandDark];
            
            [self.level3WaterController drawStormyWater];
            
            [self.islandController drawGreyFogOverlay];

        
                //test
                /*
                glPushMatrix();
        
                    glScaled(1+self.testX, 3+self.testY, 1);
                    glTranslated(0, self.testrotX-732, 0);
       
                    glColor4f(1, 1, 1, self.skyController.randOpac/5);
                    [self.skyController.lighteningReflection bindTexture];
                    [self glQuadCallWithHeight:1500 andWidth:15000];
        
                glPopMatrix();
                 */
            
        
        
        self.islandController.lighteningReflection = self.skyController.randOpac;
            
        [self manageTargetSelectionWithFirstTarget:self.manipTypeFirst 
                         WithFirstPerformanceLevel:self.manipQualityFirst
                                   AndSecondTarget:self.manipTypeSecond
                        WithSecondPerformanceLevel:self.manipQualitySecond
                         WithThirdPerformanceLevel:self.gVisualFeedback.analysis.currentFrame.manipQualityTargetID3 
                        WithFourthPerformanceLevel:self.gVisualFeedback.analysis.currentFrame.manipQualityTargetID4 
                                InOrderRightToLeft:self.isOrderRightToLeft 
                                InTravelConditions:2];
            
            [self drawBoatWithQuality:2];
        
            [self.skyController drawCloud];
            
            [self.weatherController drawRainWithIntensity:1];
        
        glPopMatrix();

    
}

-(void) connectToAdaptationAndAnalysis
{
    [self determineOrderofTargets];
    self.manipTypeFirst = [self determineTypeOfTargetFor:self.gFirstTarget];
    self.manipTypeSecond = [self determineTypeOfTargetFor:self.gSecondTarget];
}

-(void) drawBlockersWithState:(GraphicsState*) state  
{
    glPushMatrix();
    
    float xPos = [state viewportWidth]/2.0;
	float yPos = [state viewportHeight]/2.0;   

        glEnable( GL_TEXTURE_2D );
        
            glColor4f(0, 0, 0, 1);
            glTranslated(xPos+ self.blackBlockerTransX, yPos+ self.blackBlockerTransY+self.blackBlockerScaleY, self.blackBlockerTransZ);
            [self glQuadCallWithHeight:self.blackBlockerScaleY andWidth:self.blackBlockerScaleX];
            
            glTranslated(0,-2*self.blackBlockerScaleY,0);
            [self glQuadCallWithHeight:self.blackBlockerScaleY andWidth:self.blackBlockerScaleX];
            
            glTranslated(-self.blackBlockerScaleX,self.blackBlockerScaleY,0);
            [self glQuadCallWithHeight:self.blackBlockerScaleY andWidth:self.blackBlockerScaleX];
            
            glTranslated(2*self.blackBlockerScaleX,0,0);
            [self glQuadCallWithHeight:self.blackBlockerScaleY andWidth:self.blackBlockerScaleX];
            
            glTranslated(-self.blackBlockerScaleX,0,0);
            [self.blackFrame bindTexture];
            [self glQuadCallWithHeight:self.blackBlockerScaleY andWidth:self.blackBlockerScaleX];
            
        
        glDisable(GL_TEXTURE_2D);
    
    glPopMatrix();
}



-(void) determineOrderofTargets
{
    //by default 
    
    self.gFirstTarget = self.currentFrame.firstTarget;
    
    if (self.gFirstTarget == self.gVisualFeedback.adaptationDelegate.targetID1) {
        
        self.manipQualityFirst = self.currentFrame.manipQualityTargetID1;
        
        self.gSecondTarget = self.gVisualFeedback.adaptationDelegate.targetID2;
        self.manipQualitySecond = self.currentFrame.manipQualityTargetID2;

    }
    else {
        
        self.manipQualityFirst = self.currentFrame.manipQualityTargetID2;

        self.gSecondTarget = self.gVisualFeedback.adaptationDelegate.targetID1;
        self.manipQualitySecond = self.currentFrame.manipQualityTargetID1;

    }
    
    if (self.gFirstTarget  == rightVirtual ||
        self.gFirstTarget  == rightButton ||
        self.gFirstTarget  == rightCone ||
        self.gFirstTarget  == rightOnTransport ||
        self.gFirstTarget  == rightOffTransport ||
        self.gFirstTarget == rightOnTransportCone ||
        self.gFirstTarget == rightOffTransportCone) {
        
        self.isOrderRightToLeft = YES;
    }
    
    if (self.gFirstTarget == leftVirtual ||
        self.gFirstTarget == leftButton ||
        self.gFirstTarget == leftCone ||
        self.gFirstTarget == leftOnTransport ||
        self.gFirstTarget == leftOffTransport ||
        self.gFirstTarget == leftOnTransportCone ||
        self.gFirstTarget == leftOffTransportCone) {
        
        self.isOrderRightToLeft = NO;
    }
    
    if (self.gFirstTarget == middleVirtual ||
        self.gFirstTarget == middleButton ||
        self.gFirstTarget == middleCone ||
        self.gFirstTarget == middleOnTransport ||
        self.gFirstTarget == middleOffTransport ||
        self.gFirstTarget == middleOnTransportCone ||
        self.gFirstTarget == middleOffTransportCone) {
        
        if (self.gSecondTarget == leftVirtual ||
            self.gSecondTarget == leftButton ||
            self.gSecondTarget == leftCone ||
            self.gSecondTarget == leftOnTransport ||
            self.gSecondTarget == leftOffTransport ||
            self.gSecondTarget == leftOnTransportCone ||
            self.gSecondTarget == leftOffTransportCone) {
            
            self.isOrderRightToLeft = YES;
        }
        else {
            self.isOrderRightToLeft = NO;
        }
    }
}

-(int) determineTypeOfTargetFor:(TargetSelection)targetType
{
    int manipType;
    
    if (targetType == leftVirtual ||
        targetType == middleVirtual ||
        targetType == rightVirtual) {
        
        manipType = 0;
    }
    
    if (targetType == leftButton ||
        targetType == middleButton ||
        targetType == rightButton) {
        
        manipType = 1;
    }
    
    if (targetType == leftCone ||
        targetType == middleCone ||
        targetType == rightCone) {
        
        manipType = 2;
    }
    
    if (targetType == leftOnTransport ||
        targetType == middleOnTransport ||
        targetType == rightOnTransport ||
        targetType == leftOnTransportCone ||
        targetType == middleOnTransportCone ||
        targetType == rightOnTransportCone) {
        
        manipType = 3;
    }
    
    if (targetType == leftOffTransport ||
        targetType == middleOffTransport ||
        targetType == rightOffTransport ||
        targetType == leftOffTransportCone ||
        targetType == middleOffTransportCone ||
        targetType == rightOffTransportCone) {
        
        manipType = 4;
    }
    
    
    return manipType;
}



-(void) manageTargetSelectionWithFirstTarget:(int)firstTargetType 
                   WithFirstPerformanceLevel:(int)firstTargetPerfLevel
                             AndSecondTarget:(int)secondTargetType 
                  WithSecondPerformanceLevel:(int)secondTargetPerfLevel
                  WithThirdPerformanceLevel:(int)thirdTargetPerfLevel
                  WithFourthPerformanceLevel:(int)fourthTargetPerfLevel
                          InOrderRightToLeft:(BOOL)isRightToLeft 
                          InTravelConditions:(int)travelConditions
{
    
    if (isRightToLeft) {
        
        if (firstTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
        if (firstTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];   
        }
        if (firstTargetType == 2) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
        if (firstTargetType == 3 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];
        }
        if (firstTargetType == 4 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];
        }
        
        
        if (secondTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
        if (secondTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];   
        }
        if (secondTargetType == 2) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
        if (secondTargetType == 3 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];
        }
        if (secondTargetType == 4 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];
        }
        
    
        if ((firstTargetType == 3 || firstTargetType == 4) &&self.gVisualFeedback.currEnabledLevel == kLevel3Transport) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:fourthTargetPerfLevel OnSide:-1 InOrder:4];

            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:thirdTargetPerfLevel OnSide:1 InOrder:3];

            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];  

            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];  
            
        }
    }
    
    else {
        
        if (firstTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 2) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];
        }
        if (firstTargetType == 3 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];
        }
        if (firstTargetType == 4 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];
        }
        
        
        
        if (secondTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 2) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 3 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];
        }
        if (secondTargetType == 4 && self.gVisualFeedback.currEnabledLevel == kLevel3Sequence) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];
        }
        
        
        
        
        if ((firstTargetType == 3 || firstTargetType == 4) &&self.gVisualFeedback.currEnabledLevel == kLevel3Transport) {
            
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:fourthTargetPerfLevel OnSide:1 InOrder:4];    

            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:thirdTargetPerfLevel OnSide:-1 InOrder:3];
            
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];  

            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];  
            
        }

    
    
    
    }


    
    
    
    
    
    
}



/*
-(void) manageTargetSelectionWithFirstTarget:(int)firstTargetType 
                   WithFirstPerformanceLevel:(int)firstTargetPerfLevel
                             AndSecondTarget:(int)secondTargetType 
                  WithSecondPerformanceLevel:(int)secondTargetPerfLevel
                          InOrderRightToLeft:(BOOL)isRightToLeft 
                          InTravelConditions:(int)travelConditions
{
    [self.islandController drawConeIslandInTravelConditions:0 WithPerformanceLevel:0 OnSide:1 InOrder:3];
    
    [self.islandController drawConeIslandInTravelConditions:0 WithPerformanceLevel:0 OnSide:-1 InOrder:4];   
    
    
    if (isRightToLeft) {
        
        if (firstTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
        if (firstTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];   
        }
        if (firstTargetType == 2 || firstTargetType == 3 || firstTargetType == 4) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
//        if (firstTargetType == 3) {
//            [self.islandController drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
//        }
//        if (firstTargetType == 4) {
//            [self.islandController drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
//        }
        
        
        if (secondTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
        if (secondTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];   
        }
        if (secondTargetType == 2 || secondTargetType == 3 || secondTargetType == 4) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
//        if (secondTargetType == 3) {
//            [self.islandController drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
//        }
    }
    
    else {
        
        if (firstTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 2 || firstTargetType == 3 || firstTargetType == 4) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
//        if (firstTargetType == 3) {
//            [self.islandController drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
//        }
        
        if (secondTargetType == 0) {
            [self.islandController drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 1) {
            [self.islandController drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 2 || secondTargetType == 3 || secondTargetType == 4) {
            [self.islandController drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
//        if (secondTargetType == 3) {
//            [self.islandController drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
//        }
    }
    
    

         


}
 */

/*
-(void) secondManageTargetSelectionWithFirstTarget:(int)firstTargetType 
                   WithFirstPerformanceLevel:(int)firstTargetPerfLevel
                             AndSecondTarget:(int)secondTargetType 
                  WithSecondPerformanceLevel:(int)secondTargetPerfLevel
                          InOrderRightToLeft:(BOOL)isRightToLeft 
                          InTravelConditions:(int)travelConditions
{
    if (isRightToLeft) {
        
        if (firstTargetType == 0) {
            [self.islandControllerSecond drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
        if (firstTargetType == 1) {
            [self.islandControllerSecond drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];   
        }
        if (firstTargetType == 2) {
            [self.islandControllerSecond drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
        if (firstTargetType == 3) {
            [self.islandControllerSecond drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:1 InOrder:1];    
        }
        
        if (secondTargetType == 0) {
            [self.islandControllerSecond drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
        if (secondTargetType == 1) {
            [self.islandControllerSecond drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];   
        }
        if (secondTargetType == 2) {
            [self.islandControllerSecond drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
        if (secondTargetType == 3) {
            [self.islandControllerSecond drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:-1 InOrder:2];    
        }
    }
    
    else {
        
        if (firstTargetType == 0) {
            [self.islandControllerSecond drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 1) {
            [self.islandControllerSecond drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 2) {
            [self.islandControllerSecond drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        if (firstTargetType == 3) {
            [self.islandControllerSecond drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:firstTargetPerfLevel OnSide:-1 InOrder:1];    
        }
        
        if (secondTargetType == 0) {
            [self.islandControllerSecond drawVirtualIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 1) {
            [self.islandControllerSecond drawButtonIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 2) {
            [self.islandControllerSecond drawConeIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
        if (secondTargetType == 3) {
            [self.islandControllerSecond drawTransportIslandInTravelConditions:travelConditions WithPerformanceLevel:secondTargetPerfLevel OnSide:1 InOrder:2];    
        }
    }
}
 */


-(void) setVisualFeedback:(VisualFeedback *) f
{       
	self.gVisualFeedback = f;
}



-(void) dealloc
{
    [super dealloc];
    [self.skyController release];
    [self.level3WaterController release];
    [self.islandController release];
    [self.birdsController release];
    [self.sceneController release];

}

@end

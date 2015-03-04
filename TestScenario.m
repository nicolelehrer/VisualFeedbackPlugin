//
//  TestScenario.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScenario.h"
#import "VisualFeedback.h"
#import "Texture2d.h"
#import "TravelController.h"

@implementation TestScenario

@synthesize gVisualFeedback;
@synthesize gWaterScape;
@synthesize timer;
@synthesize displacement;
@synthesize resetDisplacementAnimation;
@synthesize testControl;
@synthesize scenarioDrawer;

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"TestScenario.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	TestScenario * node = [[TestScenario alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}


#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
        
        self.testControl  = [[TravelController alloc] initWithStartValue:0 andEndValue:1000 andDurationInSec:3];

        
		timer = [TimeController timekeeper];			//create timer 
        
        NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];

        waterTexture = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent: @"/textures/waterWood/base2.png"] target:GL_TEXTURE_2D];
        
         waterTextureUp = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent: @"/textures/waterWood/base2Up.png"] target:GL_TEXTURE_2D];

//        [self setUpWater];
        
        
        
        displacementAnimation = [[DAnimateFloat alloc] initWithObject:self path:@"displacement" from:0.0 to:100.0 duration:3];
		displacementAnimation.mode = DANIMATE_INTERP_EASE_IN_EASE_OUT;
        
//        scenarioDrawer = [ScenarioDrawer createWithName:@"ScenarioDrawer" parent:[Dash root]];
     }
	
    return self;
}


-(void) setUpWater
{
    self.gWaterScape = [WaterScape createWithName:@"WaterScape" parent:[Dash root] withGridDims:500 andShaderID:3];

    self.gWaterScape.transX = 0;
 	self.gWaterScape.transY = 0;
	self.gWaterScape.transZ = 0;
	self.gWaterScape.rotX = 0;	
    
	self.gWaterScape.scaledX = 1; 
	self.gWaterScape.scaledY = 1; 
	self.gWaterScape.scaledZ = 1; 
	
	self.gWaterScape.ampX = 2.631579;
	self.gWaterScape.ampY = 2.631579;
	
	self.gWaterScape.freqX = .2105;
	self.gWaterScape.freqY = .2105;
	
	self.gWaterScape.timeFactorX = 10;
	self.gWaterScape.timeFactorY = 5;
	
	self.gWaterScape.useHeightCalc = 1;
    
    self.gWaterScape.seg = 0;
}

-(void) drawWater 
{
    
//    NSLog(@"time is: %f", [timer time]);
    //[self.gWaterScape drawWaterWithTextureType1:waterTexture andTextureType2:waterTexture andOpacity:1];
    
    [self.gWaterScape drawWaterWithTextureType1:waterTextureUp andTextureType2:waterTextureUp andOpacity:1 ];


}

- (void) setVisualFeedback:(VisualFeedback *)f
{
	self.gVisualFeedback = f;
}



//from DASH animation
static float smoothstep( float min, float max, float value )
{
	if (value <= 0.0) {
		return min;
	}
	else if (value >= 1.0) {
		return max;
	}
	else {
		float y = value * value * (3.0 - 2.0 * value);
		return (min + ((max - min) * y));
	}
	
}


-(float) easeInFrom:(float)startValue to:(float)endValue 
         startingAt:(float)startTime until:(float)endTime 
withSpeedMultiplier:(float)speedMultiplier
{
    float newValue;
    
    //    if([timekeeper time]*100 > startTime && [timekeeper time]*100 < endTime)
    {
        //        glPushMatrix();
        
        //        glColor4f(1, 1, 1, 1);
        newValue = smoothstep(startValue, endValue, ([timer time]*100-startTime)*speedMultiplier); //if == 1, duration = 100 f
        
        //        glTranslated(newValue, 0, 0);
        //        [dotBod bindTexture];
        //        
        //        [self glQuadCallWithHeight:500 andWidth:500];
        //        glPopMatrix();
        
    }
    
    return newValue;
    
}




-(void) calcDisplacement
{
//    if(turnOnAnimation)
    {
        if(self.displacement == 0)
        { 
            [displacementAnimation resetFrom:self.displacement to:500 duration:3.0]; //for a fixed duration
            [DAnimation animate:displacementAnimation];	
        }
        
        if(self.displacement == 500)
        { 
            [displacementAnimation resetFrom:self.displacement to:501 duration:3.0]; //for a fixed duration
            [DAnimation animate:displacementAnimation];	

        } 
        
        if(self.displacement == 501)
        { 
            [displacementAnimation resetFrom:self.displacement to:1000 duration:3.0]; //for a fixed duration
            [DAnimation animate:displacementAnimation];	

        } 
    }

}

-(void) resetDisplacement
{
//    [displacementAnimation resetFrom:self.displacement to:0 duration:1.0]; //for a fixed duration
//    [DAnimation animate:displacementAnimation];	

    [testControl resetDisplacement];
}

-(void) drawShape:(GraphicsState *)state
{
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
//    glEnable( GL_TEXTURE_2D );

//    glEnable(GL_LIGHTING);
    
//    float shiftX = smoothstep(-1000, 1000, fabs(sin([timer time]))); //if == 1, duration = 100 f
    
    
//    [self calcDisplacement];
    
    
    displacement = [testControl calcDisplacement];
//    NSLog(@"displacement from testScenario %f", displacement);
    
    glTranslated(displacement, 0, 0);
    glColor4f(1, 0, 1, 1);
//    drawSolidCube(300);
    
//  [self drawWater];
    

    
    
}


@end

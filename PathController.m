//
//  Path.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/22/11.
//  Copyright 2011 ASU. All rights reserved.
//

#import "PathController.h"
#import "TextureController.h"


@interface PathController (private) 
-(void) loadTexturesIntoList;
-(void) setDefaultDrawingParameters;
-(void) setAdaptableParameters;
-(void) chooseTexture;
-(void) greenTexturePickerWithArray:(float)texNumber;
-(void) glQuadWithWidth:(int)imageWidth andHeight:(int)imageHeight AtIndex:(int)i;
-(void) generateRandomTexureIDs;
-(void) simulateTrajectoryValues;

@end

@implementation PathController


@synthesize group1Categories = _group1Categories;
@synthesize group2Categories = _group2Categories;
@synthesize group3Categories = _group3Categories;
@synthesize group4Categories = _group4Categories;

@synthesize group1Magnitudes = _group1Magnitudes;
@synthesize group2Magnitudes = _group2Magnitudes;
@synthesize group3Magnitudes = _group3Magnitudes;
@synthesize group4Magnitudes = _group4Magnitudes;

@synthesize scaleNegYValleyX = _scaleNegYValleyX;
@synthesize scaleNegYValleyY = _scaleNegYValleyY;


@synthesize heightToWidthRatio = _heightToWidthRatio;
@synthesize ampHeightFactor = _ampHeightFactor;


@synthesize g5glim1 = _g5glim1;
@synthesize g5glim2 = _g5glim2;

@synthesize timekeeper = _timekeeper;
@synthesize opacity;
@synthesize enableTallRocks;

@synthesize greenTextures = _greenTextures;
@synthesize yellowTextures = _yellowTextures;
@synthesize tallYellowTextures = _tallYellowTextures;
@synthesize tallRedTextures = _tallRedTextures;
@synthesize shallowYellowTextures = _shallowYellowTextures;
@synthesize shallowRedTextures = _shallowRedTextures;
@synthesize redTextures = _redTextures;

@synthesize textureIDList1;
@synthesize textureIDList2;
@synthesize textureIDList3;
@synthesize textureIDList4;

@synthesize posHorizDisplacement;
@synthesize posVertDisplacement_posHoriz;
@synthesize posVertDisplacement_negHoriz;
@synthesize negHorizDisplacement;
@synthesize negVertDisplacement_posHoriz;
@synthesize negVertDisplacement_negHoriz;

@synthesize posHorizCategory;
@synthesize posVertCategory_posHoriz;
@synthesize posVertCategory_negHoriz;

@synthesize negHorizCategory;
@synthesize negVertCategory_posHoriz;
@synthesize negVertCategory_negHoriz;

@synthesize posVertDisplacement;
@synthesize posVertCategory;
@synthesize negVertDisplacement;
@synthesize negVertCategory;

@synthesize horizDirectionAtNegVert;
@synthesize horizDirectionAtPosVert;



@synthesize scaleFactors;

@synthesize imageScalarX;
@synthesize imageScalarY;
//errorRocks
@synthesize pathZprimeSpread;
@synthesize pathSlope;
@synthesize zPrimeError;

@synthesize horizShift;
@synthesize horizErrorAmper;
@synthesize vertShift;

@synthesize scatterGain;
@synthesize scatterMag;
@synthesize totalRocks;

@synthesize errorDuration;
@synthesize rotateRocks;

@synthesize scaleZone1;
@synthesize scaleZone2;
@synthesize scaleZone3;
@synthesize scaleZone4;
@synthesize scaleZone5;
@synthesize scaleZone6;
@synthesize scaleZone7;
@synthesize scaleZone8;

@synthesize imageHeightRocks;
@synthesize imageWidthRocks;

@synthesize binNumber;
@synthesize filterType;
@synthesize targetDescriptor;

@synthesize transX;
@synthesize transY;
@synthesize transZ;

@synthesize rotX;
@synthesize rotY;
@synthesize rotZ;

@synthesize amplitude;

@synthesize errorAmp;
@synthesize errorAmp2;
@synthesize errorAmp3;
@synthesize errorAmp4;

@synthesize errorAmpFactor;
@synthesize errorAmpFactor2;
@synthesize errorAmpFactor3;
@synthesize errorAmpFactor4;
@synthesize errorAmpFactor5;
@synthesize errorAmpFactor6;

@synthesize testOpacityDepreciation;

@synthesize plotCenterX;
@synthesize plotCenterY;
@synthesize plotScaleX;
@synthesize plotScaleY;

@synthesize caseDefaultColor;

@synthesize scaleAdder1;
@synthesize scaleAdder2;
@synthesize scaleAdder3;
@synthesize scaleAdder4;
@synthesize scaleAdder5;
@synthesize scaleAdder6;
@synthesize scaleAdder7;
@synthesize scaleAdder8;
@synthesize scaleAdder9;


@synthesize mappingChange;
@synthesize mappingChangeAtBin;

@synthesize rocksScaleX = _rocksScaleX;
@synthesize rocksScaleY = _rocksScaleY;

@synthesize testHorizGroup1 = _testHorizGroup1;
@synthesize testHorizGroup2 = _testHorizGroup2;
@synthesize testHorizGroup3 = _testHorizGroup3;
@synthesize testHorizGroup4 = _testHorizGroup4;

@synthesize testVertGroup1 = _testVertGroup1;
@synthesize testVertGroup2 = _testVertGroup2;
@synthesize testVertGroup3 = _testVertGroup3;
@synthesize testVertGroup4 = _testVertGroup4;


- (id)init
{
	self = [super init];
    
    if (self != nil) {
        
        self.enableTallRocks = YES;
        
        self.binNumber = 20;
        
        
        [self setUpDataArrays];
        
        
        [self setAdaptableParameters];
        [self loadTexturesIntoArrays];
        [self generateRandomTexureIDs];
        [self setDefaultDrawingParameters];
        
        
        self.imageScalarX = 2;
        self.imageScalarY = 2;
        
        //temp for changingle slope
        self.mappingChange = 160;
        self.mappingChangeAtBin = 10;
        
        self.scaleAdder6 = .5;
        self.scaleAdder5 = .5;
        self.scaleAdder4 = .1;
        self.scaleAdder3 = .1;
        
        self.rocksScaleX = 1000;
        self.rocksScaleY = 1663.393;
        
        self.timekeeper = [TimeController timekeeper];

        
        
    }
	return self;
}





-(void) loadTexturesIntoArrays
{
    int numTexts = 6;
    
    self.greenTextures  = [[NSMutableArray alloc] initWithCapacity:numTexts];
    self.redTextures  = [[NSMutableArray alloc] initWithCapacity:numTexts];
    self.yellowTextures  = [[NSMutableArray alloc] initWithCapacity:numTexts];
    self.tallYellowTextures  = [[NSMutableArray alloc] initWithCapacity:numTexts];
    self.tallRedTextures  = [[NSMutableArray alloc] initWithCapacity:numTexts];
    
    int numShallowYellows = 1;
    self.shallowYellowTextures  = [[NSMutableArray alloc] initWithCapacity:numShallowYellows];
    int numShallowReds = 1;
    self.shallowRedTextures  = [[NSMutableArray alloc] initWithCapacity:numShallowReds];
    
    NSString * texturesDirectoryPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    
    int i;
    NSString* imageName;
    NSString* imageFilePathName;
    

    for (i = 0; i<numTexts; i++) {
    
        imageName = [@"g" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/greens/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.greenTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
    
    
        imageName = [@"r" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/reds/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.redTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
        

        imageName = [@"y" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/yellows/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.yellowTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
    
        
        imageName = [@"ty" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/tallYellows/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.tallYellowTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
    
        
        imageName = [@"tr" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/tallReds/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.tallRedTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
        
        
        imageName = [@"sy" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/shallowYellows/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.shallowYellowTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
        
        imageName = [@"sr" stringByAppendingFormat:@"%i", i];
        imageFilePathName =  [[@"/textures/level1/rocks/shallowReds/" stringByAppendingString:imageName] stringByAppendingString:@".png"];
        
        [self.shallowRedTextures addObject:[[TextureController textureController] createTexture2dWithImage:[texturesDirectoryPath stringByAppendingPathComponent:imageFilePathName] target:GL_TEXTURE_2D]];
        
    }
}


-(void) setUpDataArrays
{
	self.posHorizDisplacement  = [[NSMutableArray alloc] initWithCapacity:self.binNumber];    
    self.negHorizDisplacement  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];

    self.posVertDisplacement  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];
    self.negVertDisplacement  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];    
    
    self.posVertCategory  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];    
    self.negVertCategory  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber]; 
    
    self.horizDirectionAtPosVert = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];
    self.horizDirectionAtNegVert = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];
    
	self.posHorizCategory  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];                                    
	self.negHorizCategory  = [[NSMutableArray alloc]  initWithCapacity:self.binNumber];                                    
    
    
    int i;
    for( i = 0; i < self.binNumber; i++ ) 
	{
        [self.posHorizCategory addObject:[NSNumber numberWithFloat:0]];
        [self.negHorizCategory addObject:[NSNumber numberWithFloat:0]];
        
        [self.negHorizDisplacement addObject: [NSNumber numberWithFloat:0]];
		[self.posHorizDisplacement addObject:[NSNumber numberWithFloat:0]];
        
        [self.posVertDisplacement addObject: [NSNumber numberWithFloat:0]];
        [self.negVertDisplacement addObject: [NSNumber numberWithFloat:0]];
        
        [self.posVertCategory addObject: [NSNumber numberWithFloat:0]];
        [self.negVertCategory addObject: [NSNumber numberWithFloat:0]];
        
        [self.horizDirectionAtPosVert addObject: [NSNumber numberWithFloat:0]];
        [self.horizDirectionAtNegVert addObject: [NSNumber numberWithFloat:0]];
    }
    
}


-(void) generateRandomTexureIDs 	//picks a random value from 0 to numberOfTexturesPerColor, used to select each texture
{	
    int pathNumber = 4;
	int numberOfTexturesPerColor = 6;
	
	self.textureIDList1  = [[NSMutableArray alloc] init];       
	self.textureIDList2  = [[NSMutableArray alloc] init];       
	self.textureIDList3  = [[NSMutableArray alloc] init];       
	self.textureIDList4  = [[NSMutableArray alloc] init];       
    
    NSNumber* tempObject;
	int i;
	for( i = 0; i < 20*pathNumber; i++ ) 
	{
		tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList1 addObject:tempObject];
        
        tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList2 addObject:tempObject];
        
        tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList3 addObject:tempObject];
        
        tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList4 addObject:tempObject];
    }
    
    //    NSLog(@"texture count is: %lu", [self.textureIDList2 count]);
}






-(void) setDefaultDrawingParameters
{
    //	self.pathZprimeSpread = 200.3505;
	self.rotateRocks = -18.92523;	
	
	self.scaleZone1=1.535047;
	self.scaleZone2=1.373239;
	self.scaleZone3=1.324766;
	self.scaleZone4=1.128505;
	self.scaleZone5=0.9507042;
	self.scaleZone6=0.75;
	
 	
	self.horizErrorAmper = 644.8598;
	self.scatterMag = .00025;
	
}

-(void) setAdaptableParameters
{
    
	self.pathSlope = 0.6;
    int pathNumber = 8;
    
	int i;
	for( i = 0; i < self.binNumber*pathNumber; i++ ) {
		scatter[i] = rand() % 800*(rand() % 2 ? 1 : -1);	
	}
	
}


-(void) mixTextures
{
    //    self.binNumber = 20;
    int pathNumber = 8;
    int i;
	for( i = 0; i < self.binNumber*pathNumber; i++ ) {
		scatter[i] = rand() % 800*(rand() % 2 ? 1 : -1);	
	}
    
    
    
	int numberOfTexturesPerColor = 6;
	
	
    
    NSNumber * tempObject;
	
	for( i = 0; i < self.binNumber*pathNumber; i++ ) 
	{
		tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList1 insertObject:tempObject atIndex:i];
        
        tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList2 insertObject:tempObject atIndex:i];
        
        tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList2 insertObject:tempObject atIndex:i];
        
        tempObject = [NSNumber numberWithInt:rand() % numberOfTexturesPerColor];
		[self.textureIDList3 insertObject:tempObject atIndex:i];
        
        
        //		NSLog(@"this is the texture ID %d", [[self.textureIDList objectAtIndex:i] intValue]);
	}
    
    
}

-(void) glQuadWithWidth:(int)imageWidth andHeight:(int)imageHeight AtIndex:(int)i
{
	float z = 0;
	glBegin(GL_QUADS);
	
	glTexCoord3f(0.0, 0.0, z);
	glVertex3f(-imageWidth/2-i*pathZprimeSpread*pathSlope-horizShift, -imageHeight/2+i*pathZprimeSpread  , 0.0);
	
	glTexCoord3f(1.0, 0.0, z);
	glVertex3f( imageWidth/2-i*pathZprimeSpread*pathSlope-horizShift, -imageHeight/2+i*pathZprimeSpread , 0.0);
	
	glTexCoord3f(1.0, 1.0, z);
	glVertex3f( imageWidth/2-i*pathZprimeSpread*pathSlope-horizShift, imageHeight/2+i*pathZprimeSpread ,0.0);
	
	glTexCoord3f(0.0, 1.0, z);
	glVertex3f(-imageWidth/2-i*pathZprimeSpread*pathSlope-horizShift, imageHeight/2+i*pathZprimeSpread , 0.0);
	
	glEnd();
}


-(void) scaleDepreciationWithInitialHeight:(float)imageHeight1 withInitialWidth:(float)imageWidth1 andCounter:(int)i1 andGenSize:(float)scatterGain2
{
	float factor;
    
	if ( i1<=(binNumber-2)*1/6) {
		
		factor = scaleZone1;
		self.testOpacityDepreciation = 1;
        
	}
	
	else if (i1>(binNumber-2)*1/6 && i1<=(binNumber-2)*2/6) {
		
        factor = self.scaleZone2;
		self.testOpacityDepreciation = .8;
        
	}		
	
	else if (i1>(binNumber-2)*2/6 && i1<=(binNumber-2)*3/6) {
		
        factor = self.scaleZone3;
		self.testOpacityDepreciation = .6;
        
	}
	
	else if (i1>(binNumber-2)*3/6 && i1<=(binNumber-2)*4/6) {
		
        factor = self.scaleZone4;
		self.testOpacityDepreciation = 4;
	}
	
	else if (i1>(binNumber-2)*4/6 && i1<=(binNumber-2)*5/6) {
        
		factor = self.scaleZone5;
		self.testOpacityDepreciation = .3;
        
	}
	
	else if (i1>(binNumber-2)*5/6 && i1<=(binNumber-2)*6/6) {
        
		factor = self.scaleZone6;
		self.testOpacityDepreciation = .2;
        
	}
	
	else if (i1>(binNumber-2)*5/6 && i1<=(binNumber-2)*6/6) {
        
		factor = self.scaleZone6;
		self.testOpacityDepreciation = .2;
	}
	else {
        
		factor = self.scaleZone6;
		self.testOpacityDepreciation = .2;
	}
    
    
    
	imageWidthRocks = self.rocksScaleX*(1+scatterGain2)*factor;
	imageHeightRocks = self.rocksScaleY*(1+scatterGain2)*factor;
}





-(void) drawTexturesInPath
{	
	float scatterMagnitude = .25;
    
//    float timer = [self.timekeeper time];
    
    int textID;
	float posHorizCat;
	float posVertCat;    
	float negHoizCat;
	float negVertCat;
    
    self.scaleZone1=1.535047 + self.scaleAdder1;
	self.scaleZone2=1.373239 + self.scaleAdder2;
	self.scaleZone3=1.324766 + self.scaleAdder3;
	self.scaleZone4=1.128505 + self.scaleAdder4;
	self.scaleZone5=0.9507042 + self.scaleAdder5;
	self.scaleZone6=0.75 + self.scaleAdder6;
    
    glDisable( GL_DEPTH_TEST );
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_LIGHTING);

    glColor4f(1, 1, 1, self.opacity);

    glPushMatrix();
    
        glTranslated(self.transX, self.transY, self.transZ);
        glRotated(self.rotX, 1, 0, 0);
        
        int i;
        
        for (i = self.binNumber-1; i >= 0; i--)  {
            
            [self scaleDepreciationWithInitialHeight:imageHeightRocks withInitialWidth:imageWidthRocks andCounter:i andGenSize:(scatterGain-0.157277)];
            horizShift = scatter[(int)i]*(scatterMagnitude);;
            
            posHorizCat = [[self.posHorizCategory objectAtIndex:i] floatValue];		
            negHoizCat = [[self.negHorizCategory objectAtIndex:i] floatValue];
            
            posVertCat = [[self.posVertCategory objectAtIndex:i] floatValue];
            negVertCat = [[self.negVertCategory objectAtIndex:i] floatValue];
       
            
            if (posHorizCat == 0 && posVertCat == 0 && 
                negHoizCat  == 0 && negVertCat == 0) {
                
                glColor4f(1, 1, 1, self.opacity);

                textID = [[self.textureIDList2 objectAtIndex:i*2] intValue];
               
                [[self.greenTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:imageWidthRocks andHeight:imageHeightRocks AtIndex:i*2];
                
                textID = [[self.textureIDList2 objectAtIndex:i*2+1] intValue];

                [[self.greenTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:imageWidthRocks andHeight:imageHeightRocks AtIndex:i*2-1];
            }
        }
        
        //place a green rock at the beginning and at the end to fix start/end 
        i = -2;
        [self scaleDepreciationWithInitialHeight:imageHeightRocks withInitialWidth:imageWidthRocks andCounter:i andGenSize:-0.157277];
        textID = [[self.textureIDList2 objectAtIndex:0] intValue];
        [[self.greenTextures objectAtIndex:textID] bindTexture];
        [self glQuadWithWidth:imageWidthRocks andHeight:imageHeightRocks AtIndex:i];
        
        i = 39;
        [self scaleDepreciationWithInitialHeight:imageHeightRocks withInitialWidth:imageWidthRocks andCounter:i andGenSize:-0.157277];
        textID = [[self.textureIDList2 objectAtIndex:0] intValue];
        [[self.greenTextures objectAtIndex:textID] bindTexture];
        [self glQuadWithWidth:imageWidthRocks andHeight:imageHeightRocks AtIndex:i];
        
	glPopMatrix();	
}


-(void) drawRockPairAtIndex:(int)i
           WithTextureArray:(NSArray*)textureArray
            WithTextID1:(int) textID1
            WithTextID2:(int) textID2
              WithError:(float) errorMagnitude
    WithErrorApmplifyer:(float) errorAmplifier
            andScatter1:(float) scatterValue1
            andScatter2:(float) scatterValue2
            andHeightFactor:(float) heightFactor
             andWidthFactor:(float) widthFactor

{    
    horizShift =  -errorAmplifier*errorMagnitude*scatterValue1;
    [[textureArray objectAtIndex:textID1] bindTexture];
    [self glQuadWithWidth:imageWidthRocks*widthFactor andHeight:imageHeightRocks*heightFactor  AtIndex:i*2];
    
    horizShift =  -errorAmplifier*errorMagnitude*scatterValue2;
    [[textureArray objectAtIndex:textID2] bindTexture];
    [self glQuadWithWidth:imageWidthRocks*widthFactor andHeight:imageHeightRocks*heightFactor  AtIndex:i*2-1];

}


-(void) drawHorizontalErrorAtIndex:(int)i WithErrorCategory:(float) errorCategory andMagnitude:(float)errorMagnitude
{
    int textID =  [[textureIDList2 objectAtIndex:i] intValue];
    int textID2 = [[textureIDList2 objectAtIndex:i + self.binNumber] intValue];
    int textID3 = [[textureIDList2 objectAtIndex:i + self.binNumber*2] intValue];
    int textID4 = [[textureIDList2 objectAtIndex:i + self.binNumber*3] intValue];
    
    float scatterVal1 = scatter[(int)i + self.binNumber*0]*(scatterMag);
    float scatterVal2 = scatter[(int)i + self.binNumber*1]*(scatterMag);
    float scatterVal3 = scatter[(int)i + self.binNumber*2]*(scatterMag);
    float scatterVal4 = scatter[(int)i + self.binNumber*3]*(scatterMag);
    float scatterVal5 = scatter[(int)i + self.binNumber*4]*(scatterMag);
    float scatterVal6 = scatter[(int)i + self.binNumber*5]*(scatterMag);
    
    glColor4f(1, 1, 1, self.opacity);
    
    if (errorCategory == 2) {
        float boostScatter = 1;
        
        //yellowband
        [self drawRockPairAtIndex:i WithTextureArray:self.yellowTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp3
                      andScatter1:(scatterVal1 + boostScatter)
                      andScatter2:(scatterVal2 + boostScatter) andHeightFactor:.5 andWidthFactor:.5];
        
        //redbands
        [self drawRockPairAtIndex:i WithTextureArray:self.redTextures
                      WithTextID1:textID3
                      WithTextID2:textID4
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp2
                      andScatter1:(scatterVal3 + boostScatter)
                      andScatter2:(scatterVal4 + boostScatter) andHeightFactor:.5 andWidthFactor:.5];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.redTextures
                      WithTextID1:textID2
                      WithTextID2:textID
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp4
                      andScatter1:(scatterVal5 + boostScatter)
                      andScatter2:(scatterVal6 + boostScatter) andHeightFactor:.5 andWidthFactor:.5];
    }
    
    if (errorCategory == 1) {
        
        float boostScatter = .75;
        
        //so rocks don't appear in straight line
        //when there is pure horizontal error and actual error value is too low, boost both the error and scatter
        //                if (posHorizMagnitudeCurr < .2) {
        //                    posHorizMagnitudeCurr = .2;
        //                    increasedScatter = 2.0;
        //                }
        
        //yellowbands
        [self drawRockPairAtIndex:i WithTextureArray:self.yellowTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp3
                      andScatter1:(scatterVal1 + boostScatter)
                      andScatter2:(scatterVal2 + boostScatter) andHeightFactor:.5 andWidthFactor:.5];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.yellowTextures
                      WithTextID1:textID3
                      WithTextID2:textID4
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp4
                      andScatter1:(scatterVal3 + boostScatter)
                      andScatter2:(scatterVal4 + boostScatter) andHeightFactor:.5 andWidthFactor:.5];
    }
}

-(void) drawNegativeVerticalErrorAtIndex:(int)i WithErrorCategory:(float)errorCategory
                    andMagnitude:(float)errorMagnitude
  withPositiveHorizontalCategory:(float)posHorizontalCategory
 withPositiveHorizontalMagnitude:(float)posHorizontalMagnitude
  withNegativeHorizontalCategory:(float)negHorizontalCategory
 withNegativeHorizontalMagnitude:(float)negHorizontalMagnitude
     andXValueAtMaximumNegativeY:(float)xValueAtMaximumNegativeY
{
    int textID =  [[textureIDList2 objectAtIndex:i] intValue];
    int textID2 = [[textureIDList2 objectAtIndex:i + self.binNumber] intValue];
    int textID3 = [[textureIDList2 objectAtIndex:i + self.binNumber*2] intValue];
    int textID4 = [[textureIDList2 objectAtIndex:i + self.binNumber*3] intValue];
    
    float scatterVal1 = scatter[(int)i + self.binNumber*0]*(scatterMag);
    float scatterVal2 = scatter[(int)i + self.binNumber*1]*(scatterMag);
    float scatterVal3 = scatter[(int)i + self.binNumber*2]*(scatterMag);
    float scatterVal4 = scatter[(int)i + self.binNumber*3]*(scatterMag);
    float scatterVal5 = scatter[(int)i + self.binNumber*4]*(scatterMag);
    float scatterVal6 = scatter[(int)i + self.binNumber*5]*(scatterMag);
    
    glColor4f(1, 1, 1, self.opacity);
    
    float mixedErrorForY = 0;
    BOOL drawPureRight = NO;
    BOOL drawPureLeft = NO;

    //the following determines on which side composite error occured
    //because we receive the max error for vert and for horiz seperately, need to know how to draw summary
    
    //if there is pos horiz error and vert error is on that side
    if (posHorizontalCategory != 0 && xValueAtMaximumNegativeY>0){
        mixedErrorForY = posHorizontalMagnitude;
    }
    //if there is neg horiz error and vert error is on that side
    else if (negHorizontalCategory != 0 && xValueAtMaximumNegativeY<0){
        mixedErrorForY = negHorizontalMagnitude;
    }
    //if there is no neg horiz error and vert error is on that side
    else if (negHorizontalCategory == 0 && posHorizontalCategory == 0){
        mixedErrorForY = scatterVal3*.75;
    }
    else if (negHorizontalCategory != 0 && xValueAtMaximumNegativeY>0){
        //draw horiz error to the left
        drawPureLeft = YES;
    }
    else if (posHorizontalCategory != 0 && xValueAtMaximumNegativeY<0) {
        //draw horiz error to the Right
        drawPureRight = YES;
    }
    
    if ( errorMagnitude == 2 || posHorizontalCategory == 2 || negHorizontalCategory == 2) {

        float boostScatter = 1.0;
        float errorRocksScalar = .5;
        float heightFactor = .75;
        
        glColor4f(1, 0, 0, .3*self.opacity);
        
        //redband
        [self drawRockPairAtIndex:i WithTextureArray:self.greenTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp3*mixedErrorForY
                      andScatter1:(scatterVal1 + boostScatter)
                      andScatter2:(scatterVal2 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*heightFactor];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.greenTextures
                      WithTextID1:textID3
                      WithTextID2:textID4
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp2*mixedErrorForY
                      andScatter1:(scatterVal3 + boostScatter)
                      andScatter2:(scatterVal4 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*heightFactor];

        [self drawRockPairAtIndex:i WithTextureArray:self.greenTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp4*mixedErrorForY
                      andScatter1:(scatterVal5 + boostScatter)
                      andScatter2:(scatterVal6 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*heightFactor];
    }
    
    else {
        
        float boostScatter = 1.0;
        float errorRocksScalar = .5;
        float heightFactor = .75;

        glColor4f(1,1,1, self.opacity);//255-215-0
        
        if (i%5 == 0) {
            
            
            [self drawRockPairAtIndex:i WithTextureArray:self.shallowYellowTextures
                          WithTextID1:textID
                          WithTextID2:textID2
                            WithError:errorMagnitude
                  WithErrorApmplifyer:self.errorAmp3*mixedErrorForY
                          andScatter1:(scatterVal1 + boostScatter)
                          andScatter2:(scatterVal2 + boostScatter)
                      andHeightFactor:errorRocksScalar*heightFactor*self.scaleNegYValleyX
                       andWidthFactor:errorRocksScalar*heightFactor*self.scaleNegYValleyY];
        }
    }
    
    if (drawPureRight) {
        [self drawHorizontalErrorAtIndex:i WithErrorCategory:posHorizontalCategory andMagnitude:posHorizontalMagnitude];
    }
    if (drawPureLeft) {
        [self drawHorizontalErrorAtIndex:i WithErrorCategory:negHorizontalCategory andMagnitude:negHorizontalMagnitude];
    }
    
}


-(void) drawPositiveVerticalErrorAtIndex:(int)i WithErrorCategory:(float)errorCategory
                            andMagnitude:(float)errorMagnitude
          withPositiveHorizontalCategory:(float)posHorizontalCategory
         withPositiveHorizontalMagnitude:(float)posHorizontalMagnitude
          withNegativeHorizontalCategory:(float)negHorizontalCategory
         withNegativeHorizontalMagnitude:(float)negHorizontalMagnitude
             andXValueAtMaximumNegativeY:(float)xValueAtMaximumNegativeY
{
    int textID =  [[textureIDList2 objectAtIndex:i] intValue];
    int textID2 = [[textureIDList2 objectAtIndex:i + self.binNumber] intValue];
    int textID3 = [[textureIDList2 objectAtIndex:i + self.binNumber*2] intValue];
    int textID4 = [[textureIDList2 objectAtIndex:i + self.binNumber*3] intValue];
    
    float scatterVal1 = scatter[(int)i + self.binNumber*0]*(scatterMag);
    float scatterVal2 = scatter[(int)i + self.binNumber*1]*(scatterMag);
    float scatterVal3 = scatter[(int)i + self.binNumber*2]*(scatterMag);
    float scatterVal4 = scatter[(int)i + self.binNumber*3]*(scatterMag);
    float scatterVal5 = scatter[(int)i + self.binNumber*4]*(scatterMag);
    float scatterVal6 = scatter[(int)i + self.binNumber*5]*(scatterMag);
    
    glColor4f(1, 1, 1, self.opacity);
    
    float mixedErrorY = 0;
    BOOL drawPureRight = NO;
    BOOL drawPureLeft = NO;
    
    //the following determines on which side composite error occured
    //because we receive the max error for vert and for horiz seperately, need to know how to draw summary
    
    //if there is pos horiz error and vert error is on that side
    if (posHorizontalCategory != 0 && xValueAtMaximumNegativeY>0){
        mixedErrorY = posHorizontalMagnitude;
    }
    //if there is neg horiz error and vert error is on that side
    else if (negHorizontalCategory != 0 && xValueAtMaximumNegativeY<0){
        mixedErrorY = negHorizontalMagnitude;
    }
    //if there is no neg horiz error and vert error is on that side
    else if (negHorizontalCategory == 0 && posHorizontalCategory == 0){
        mixedErrorY = scatterVal3*.75;
    }
    else if (negHorizontalCategory != 0 && xValueAtMaximumNegativeY>0){
        //draw horiz error to the left
        drawPureLeft = YES;
    }
    else if (posHorizontalCategory != 0 && xValueAtMaximumNegativeY<0) {
        //draw horiz error to the Right
        drawPureRight = YES;
    }
    
    float errorRocksScalar = .5;

    
    if ( errorMagnitude == 2 || posHorizontalCategory == 2 || negHorizontalCategory == 2) {
        
        float boostScatter = 1.0;
        float heightFactor = errorMagnitude*self.ampHeightFactor;
        
        if (heightFactor < 1) {
            heightFactor = 1;
        }
        
        float widthFactor = heightFactor/self.heightToWidthRatio;

        
        glColor4f(1, 1, 1, self.opacity);
        
        //redband
        [self drawRockPairAtIndex:i WithTextureArray:self.tallRedTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp3*mixedErrorY
                      andScatter1:(scatterVal1 + boostScatter)
                      andScatter2:(scatterVal2 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*widthFactor];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.tallRedTextures
                      WithTextID1:textID3
                      WithTextID2:textID4
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp2*mixedErrorY
                      andScatter1:(scatterVal3 + boostScatter)
                      andScatter2:(scatterVal4 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*widthFactor];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.tallRedTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp4*mixedErrorY
                      andScatter1:(scatterVal5 + boostScatter)
                      andScatter2:(scatterVal6 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*widthFactor];
    }
    
    else {
        
        float heightFactor = errorMagnitude+.2; //+.5; - test Aug15 demo
        
        if (heightFactor < .7) {
            heightFactor = .7;
        }
        float widthFactor = heightFactor/self.heightToWidthRatio;
        float boostScatter = 0;
        
        [self drawRockPairAtIndex:i WithTextureArray:self.tallRedTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp3*mixedErrorY
                      andScatter1:(scatterVal1 + boostScatter)
                      andScatter2:(scatterVal2 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*widthFactor];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.tallRedTextures
                      WithTextID1:textID3
                      WithTextID2:textID4
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp2*mixedErrorY
                      andScatter1:(scatterVal3 + boostScatter)
                      andScatter2:(scatterVal4 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*widthFactor];
        
        [self drawRockPairAtIndex:i WithTextureArray:self.tallRedTextures
                      WithTextID1:textID
                      WithTextID2:textID2
                        WithError:errorMagnitude
              WithErrorApmplifyer:self.errorAmp4*mixedErrorY
                      andScatter1:(scatterVal5 + boostScatter)
                      andScatter2:(scatterVal6 + boostScatter)
                  andHeightFactor:errorRocksScalar*heightFactor
                   andWidthFactor:errorRocksScalar*widthFactor];
    }
    
    if (drawPureRight) {
        [self drawHorizontalErrorAtIndex:i WithErrorCategory:posHorizontalCategory andMagnitude:posHorizontalMagnitude];
    }
    if (drawPureLeft) {
        [self drawHorizontalErrorAtIndex:i WithErrorCategory:negHorizontalCategory andMagnitude:negHorizontalMagnitude];
    }
    
}


-(void) drawTexturesDisplacedFromPath
{
	self.scaleZone1=1.535047 +.5 + self.errorAmpFactor+ scaleAdder1;
	self.scaleZone2=1.373239 +.5 + self.errorAmpFactor2+ scaleAdder2;
	self.scaleZone3=1.324766 +.5 + self.errorAmpFactor3+ scaleAdder3;
	self.scaleZone4=1.240654 +.4 + self.errorAmpFactor4+ scaleAdder4;
	self.scaleZone5=1.133803 +.4 + self.errorAmpFactor5+ scaleAdder5;
	self.scaleZone6=1.030374 +.4 + self.errorAmpFactor6+ scaleAdder6;
	self.scaleZone7=1.030374 +.3 + self.errorAmpFactor6+ scaleAdder6;
	self.scaleZone8=1.030374 +.3 + self.errorAmpFactor6 + scaleAdder6;
    
    
        
	int i;
	    
    float posHorizMagnitudeCurr;
    float negHorizMagnitudeCurr;
    float posVertMagnitudeCurr;
    float negVertMagnitudeCurr;
    
    float posHorizCategoryCurr;
    float negHorizCategoryCurr;
    float posVertCategoryCurr;
    float negVertCategoryCurr;
    
    float xValueAtMaxPosY;
    float xValueAtMaxNegY;
    
    glDisable( GL_DEPTH_TEST );
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_LIGHTING);
    
    glPushMatrix();
	glTranslated(transX, transY, transZ);
	glRotated(rotX, 1, 0, 0);
    
	
	for (i = self.binNumber-1; i >= 0; i--)
	{
        posHorizMagnitudeCurr = [[self.posHorizDisplacement objectAtIndex:i] floatValue];
        negHorizMagnitudeCurr = [[self.negHorizDisplacement objectAtIndex:i] floatValue];
        posHorizCategoryCurr =  [[self.posHorizCategory objectAtIndex:i] floatValue];
        negHorizCategoryCurr =  [[self.negHorizCategory objectAtIndex:i] floatValue];
        
        posVertMagnitudeCurr = [[self.posVertDisplacement objectAtIndex:i] floatValue];
        negVertMagnitudeCurr = [[self.negVertDisplacement objectAtIndex:i] floatValue];
        
        posVertCategoryCurr = [[self.posVertCategory objectAtIndex:i] floatValue];
        negVertCategoryCurr = [[self.negVertCategory objectAtIndex:i] floatValue];
        
        xValueAtMaxPosY =     [[self.horizDirectionAtPosVert objectAtIndex:i] floatValue];
        xValueAtMaxNegY =     [[self.horizDirectionAtNegVert objectAtIndex:i] floatValue];
        
		[self scaleDepreciationWithInitialHeight:imageWidthRocks withInitialWidth:imageWidthRocks andCounter:i andGenSize:0.157277];
        
        
        //Only horizontal error in positive direction
        if (posHorizCategoryCurr != 0 && posVertCategoryCurr == 0 && negVertCategoryCurr == 0) {
            [self drawHorizontalErrorAtIndex:i WithErrorCategory:posHorizCategoryCurr andMagnitude:posHorizMagnitudeCurr];
        }
        //Only horizontal error in negative direction
        if (negHorizCategoryCurr != 0 && posVertCategoryCurr == 0 && negVertCategoryCurr == 0) {
            [self drawHorizontalErrorAtIndex:i WithErrorCategory:negHorizCategoryCurr andMagnitude:negHorizMagnitudeCurr];
		}
        
        //If there is vertical error in negative direction
        if (negVertCategoryCurr != 0) {
            
//            [self drawNegativeVerticalErrorAtIndex:i
//                         WithErrorCategory:negVertCategoryCurr
//                              andMagnitude:negVertMagnitudeCurr
//            withPositiveHorizontalCategory:posHorizCategoryCurr
//            withPositiveHorizontalMagnitude:posHorizMagnitudeCurr
//            withNegativeHorizontalCategory:negHorizCategoryCurr
//            withNegativeHorizontalMagnitude:negHorizMagnitudeCurr
//               andXValueAtMaximumNegativeY:xValueAtMaxNegY];
        }
        
        //If there is vertical error in positive direction
        if (posVertCategoryCurr != 0){
            
            [self drawPositiveVerticalErrorAtIndex:i
                                 WithErrorCategory:negVertCategoryCurr
                                      andMagnitude:negVertMagnitudeCurr
                    withPositiveHorizontalCategory:posHorizCategoryCurr
                   withPositiveHorizontalMagnitude:posHorizMagnitudeCurr
                    withNegativeHorizontalCategory:negHorizCategoryCurr
                   withNegativeHorizontalMagnitude:negHorizMagnitudeCurr
                       andXValueAtMaximumNegativeY:xValueAtMaxPosY];               
        }
	}
    glPopMatrix();
}


/*
-(void) drawTexturesDisplacedFromPath
{
	self.scaleZone1=1.535047 +.5 + self.errorAmpFactor+ scaleAdder1;
	self.scaleZone2=1.373239 +.5 + self.errorAmpFactor2+ scaleAdder2;
	self.scaleZone3=1.324766 +.5 + self.errorAmpFactor3+ scaleAdder3;
	self.scaleZone4=1.240654 +.4 + self.errorAmpFactor4+ scaleAdder4;
	self.scaleZone5=1.133803 +.4 + self.errorAmpFactor5+ scaleAdder5;
	self.scaleZone6=1.030374 +.4 + self.errorAmpFactor6+ scaleAdder6;
	self.scaleZone7=1.030374 +.3 + self.errorAmpFactor6+ scaleAdder6;
	self.scaleZone8=1.030374 +.3 + self.errorAmpFactor6 + scaleAdder6;
    
//    scatterMag = .0005;
    
	int i;
	float heightFactor = 0;
    
    float errorRocksScalar = .5;
	int textID;
	int textID2;
    int textID3;
    int textID4;
    
    float scatterVal1;
	float scatterVal2;
    float scatterVal3;
    float scatterVal4;
    float scatterVal5;
    float scatterVal6;
    
    float boostScatter;
    
    float posHorizMagnitudeCurr;
    float negHorizMagnitudeCurr;
    float posVertMagnitudeCurr;
    float negVertMagnitudeCurr;
    
    float posHorizCategoryCurr;
    float negHorizCategoryCurr;
    float posVertCategoryCurr;
    float negVertCategoryCurr;
    
    float xValueAtMaxPosY;
    float xValueAtMaxNegY;
    
    glDisable( GL_DEPTH_TEST );
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_LIGHTING);
    
    glPushMatrix();		
	glTranslated(transX, transY, transZ);
	glRotated(rotX, 1, 0, 0);
    
	
	for (i = self.binNumber-1; i >= 0; i--)
	{
        
        
        textID =  [[textureIDList2 objectAtIndex:i] intValue];	
        textID2 = [[textureIDList2 objectAtIndex:i + self.binNumber] intValue];	
        textID3 = [[textureIDList2 objectAtIndex:i + self.binNumber*2] intValue];	
        textID4 = [[textureIDList2 objectAtIndex:i + self.binNumber*3] intValue];
        
                
        posHorizMagnitudeCurr = [[self.posHorizDisplacement objectAtIndex:i] floatValue];
        negHorizMagnitudeCurr = [[self.negHorizDisplacement objectAtIndex:i] floatValue];
        posHorizCategoryCurr =  [[self.posHorizCategory objectAtIndex:i] floatValue];
        negHorizCategoryCurr =  [[self.negHorizCategory objectAtIndex:i] floatValue];
        
        float increasedScatter = 1.0;
        
               
        scatterVal1 = scatter[(int)i + self.binNumber*0]*(scatterMag);
		scatterVal2 = scatter[(int)i + self.binNumber*1]*(scatterMag);
		scatterVal3 = scatter[(int)i + self.binNumber*2]*(scatterMag);
		scatterVal4 = scatter[(int)i + self.binNumber*3]*(scatterMag);
		scatterVal5 = scatter[(int)i + self.binNumber*4]*(scatterMag);
		scatterVal6 = scatter[(int)i + self.binNumber*5]*(scatterMag);

        
                
        posVertMagnitudeCurr = [[self.posVertDisplacement objectAtIndex:i] floatValue];
        negVertMagnitudeCurr = [[self.negVertDisplacement objectAtIndex:i] floatValue];
        
        posVertCategoryCurr = [[self.posVertCategory objectAtIndex:i] floatValue];
        negVertCategoryCurr = [[self.negVertCategory objectAtIndex:i] floatValue];
       
        xValueAtMaxPosY =     [[self.horizDirectionAtPosVert objectAtIndex:i] floatValue];
        xValueAtMaxNegY =     [[self.horizDirectionAtNegVert objectAtIndex:i] floatValue];
        
        float widthFactor;
        
		[self scaleDepreciationWithInitialHeight:imageWidthRocks withInitialWidth:imageWidthRocks andCounter:i andGenSize:0.157277];
        
        
        
        
        //set some local params for (somewhat better) ease of reading
        
        BOOL onlyDrawHorizErrorOnPosSide = NO;
        
        if (posHorizCategoryCurr != 0 && posVertCategoryCurr == 0 && negVertCategoryCurr == 0) {
            
            onlyDrawHorizErrorOnPosSide = YES;
        }
        
        BOOL onlyDrawHorizErrorOnNegSide = NO;

        if (negHorizCategoryCurr != 0 && posVertCategoryCurr == 0 && negVertCategoryCurr == 0) {

            onlyDrawHorizErrorOnNegSide = YES;
        }
        

        if (onlyDrawHorizErrorOnPosSide) {
            
            
            glColor4f(1, 1, 1, self.opacity);
            
            if (posHorizCategoryCurr == 2) {
                
                boostScatter = 1;

                //yellowband
                
                horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal1 + boostScatter);
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal2 + boostScatter);
                [[self.yellowTextures objectAtIndex:textID4] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
                //redband1
                
                horizShift =  -self.errorAmp2*posHorizMagnitudeCurr*(scatterVal3 + boostScatter);
                [[self.redTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp2*posHorizMagnitudeCurr*(scatterVal4 + boostScatter);
                [[self.redTextures objectAtIndex:textID2] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
                //redband2
                
                horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal5 + boostScatter);
                [[self.redTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal6 + boostScatter);
                [[self.redTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
			}
            
			if (posHorizCategoryCurr == 1) {
                
                boostScatter = .75;
                
                //so rocks don't appear in straight line
                //when there is pure horizontal error and actual error value is too low, boost both the error and scatter 
                
                if (posHorizMagnitudeCurr < .2) {
                    
                    posHorizMagnitudeCurr = .2;
                    increasedScatter = 2.0;
                }
//
                //yellowband1
                horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal1 + boostScatter)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal2 + boostScatter)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
                //yellowband2
                horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal3 + boostScatter)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal4 + boostScatter)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
			}
		}
        
        if (onlyDrawHorizErrorOnNegSide) {
            
            glColor4f(1, 1, 1, self.opacity);
            
            if (negHorizCategoryCurr == 2) {
                
                boostScatter = 1;
                

                //yellowband
                horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(boostScatter + scatterVal1);
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(boostScatter + scatterVal2);
                [[self.yellowTextures objectAtIndex:textID4] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
                //redband1
                horizShift =  -self.errorAmp2*negHorizMagnitudeCurr*(boostScatter + scatterVal3);
                [[self.redTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp2*negHorizMagnitudeCurr*(boostScatter + scatterVal4);
                [[self.redTextures objectAtIndex:textID2] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
                
                //redband2
                horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(boostScatter + scatterVal5);
                [[self.redTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(boostScatter + scatterVal6);
                [[self.redTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
			}
            
			if (negHorizCategoryCurr == 1) {
				
                boostScatter = .75;

                //so rocks don't appear in straight line
                //when there is pure horizontal error and actual error value is too low, boost both the error and scatter
                
                if (negHorizMagnitudeCurr > -.2) {
                    negHorizMagnitudeCurr = -.2;
                    increasedScatter = 2.0;
                    
                }
                
                //yellowband1
                horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(1+scatterVal1)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(1+scatterVal2)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
                //yellowband2
                horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(1+scatterVal3)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(1+scatterVal4)*increasedScatter;
                [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                
			}
		}
        
        
        //if there is NEGATIVE VERT ERROR 
        if (negVertCategoryCurr != 0) {
            
            float mixedErrorForNegY = 0;
            BOOL drawPureRight = NO;
            BOOL drawPureLeft = NO;
            
            
            //the following series of statements determines on which side composite error occured
            //because we receive the max error for vert and for horiz seperately, need to know how to draw summary
            
            //if there is pos horiz error and vert error is on that side 
            if (posHorizCategoryCurr != 0 && xValueAtMaxNegY>0){
                
                mixedErrorForNegY = posHorizMagnitudeCurr;
            }
            
            //if there is neg horiz error and vert error is on that side 
            else if (negHorizCategoryCurr != 0 && xValueAtMaxNegY<0){
                
                mixedErrorForNegY = negHorizMagnitudeCurr;
            }
            
            //if there is no neg horiz error and vert error is on that side 
            else if (negHorizCategoryCurr == 0 && posHorizCategoryCurr == 0){
                
                //draw in the center but give it some scatter
                mixedErrorForNegY = scatterVal3*.75;//testFactor
            }
            
            else if (negHorizCategoryCurr != 0 && xValueAtMaxNegY>0) {
                
                //draw horiz error to the left
                //have to also consider this case because there may be pure horiz error on the side oppoite of vertical
                //above we only considered the case of no vertical error
                //need to rewrite
                
                drawPureLeft = YES;
            }
            else if (posHorizCategoryCurr != 0 && xValueAtMaxNegY<0) {
                
                //draw horiz error to the Right
                drawPureRight = YES;
            }
            
            else {}
            
            
            if (negVertCategoryCurr == 2 || posHorizCategoryCurr == 2 || negHorizCategoryCurr == 2) {
                
                heightFactor = .75;     
                
                glColor4f(1, 0, 0, .3*self.opacity);
                
                //redband0
                horizShift =  -self.errorAmp3*mixedErrorForNegY*(1+scatterVal3);
                [[self.greenTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*mixedErrorForNegY*(1+scatterVal4);
                [[self.greenTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
                
                //redband1
                horizShift =  -self.errorAmp2*mixedErrorForNegY*(1+scatterVal1);
                [[self.greenTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp2*mixedErrorForNegY*(1+scatterVal2);
                [[self.greenTextures objectAtIndex:textID2] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
                
                //redband2
                horizShift =  -self.errorAmp4*mixedErrorForNegY*(1+scatterVal5);
                [[self.greenTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*mixedErrorForNegY*(1+scatterVal6);
                [[self.greenTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
            }
            
            else {
                
                heightFactor = .75;     

                glColor4f(1,1,1, self.opacity);//255-215-0
                                
                if (i%5 == 0) {
                                      
                    horizShift =  -self.errorAmp3*mixedErrorForNegY*(1+scatterVal3);
                    [[self.shallowYellowTextures objectAtIndex:textID] bindTexture];
                    [self glQuadWithWidth:self.scaleNegYValleyX*heightFactor*imageWidthRocks*errorRocksScalar andHeight:self.scaleNegYValleyY*heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];

                }

            }
            
            
            if (drawPureRight) {
                
                glColor4f(1, 1, 1, self.opacity);
                
                if (posHorizCategoryCurr == 2) {
                    
                    boostScatter = 1;
                    
                    //yellowband
                    
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal1 + boostScatter);
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal2 + boostScatter);
                    [[self.yellowTextures objectAtIndex:textID4] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //redband1
                    
                    horizShift =  -self.errorAmp2*posHorizMagnitudeCurr*(scatterVal3 + boostScatter);
                    [[self.redTextures objectAtIndex:textID] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp2*posHorizMagnitudeCurr*(scatterVal4 + boostScatter);
                    [[self.redTextures objectAtIndex:textID2] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //redband2
                    
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal5 + boostScatter);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal6 + boostScatter);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
                
                if (posHorizCategoryCurr == 1) {
                    
                    boostScatter = .75;
                    
                    //so rocks don't appear in straight line
                    //when there is pure horizontal error and actual error value is too low, boost both the error and scatter
                    
                    if (posHorizMagnitudeCurr < .2) {
                        
                        posHorizMagnitudeCurr = .2;
                        increasedScatter = 2.0;
                    }
                    
                    //yellowband1
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal1 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal2 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //yellowband2
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal3 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal4 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
            }
            
            if (drawPureLeft) {
                
                glColor4f(1, 1, 1, self.opacity);
                
                if (negHorizCategoryCurr == 2) {
                    
                    boostScatter = 1;
                    
                    
                    //yellowband
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(boostScatter + scatterVal1);
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(boostScatter + scatterVal2);
                    [[self.yellowTextures objectAtIndex:textID4] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //redband1
                    horizShift =  -self.errorAmp2*negHorizMagnitudeCurr*(boostScatter + scatterVal3);
                    [[self.redTextures objectAtIndex:textID] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp2*negHorizMagnitudeCurr*(boostScatter + scatterVal4);
                    [[self.redTextures objectAtIndex:textID2] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    
                    //redband2
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(boostScatter + scatterVal5);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(boostScatter + scatterVal6);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
                
                if (negHorizCategoryCurr == 1) {
                    
                    boostScatter = .75;
                    
                    //so rocks don't appear in straight line
                    //when there is pure horizontal error and actual error value is too low, boost both the error and scatter
                    
                    if (negHorizMagnitudeCurr > -.2) {
                        negHorizMagnitudeCurr = -.2;
                        increasedScatter = 2.0;
                        
                    }
                    
                    //yellowband1
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(1+scatterVal1)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(1+scatterVal2)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //yellowband2
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(1+scatterVal3)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(1+scatterVal4)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
            }
            
        }
        
        
        
        //if there is POSITIVE VERT error 
        if (posVertCategoryCurr != 0){// && posHorizCategoryCurr == 0 && negHorizCategoryCurr == 0){
            
            float mixedErrorForPosY = 0;
            BOOL drawPureRight = NO;
            BOOL drawPureLeft = NO;
            
            //if there is pos horiz error and vert error is on that side 
            if (posHorizCategoryCurr != 0 && xValueAtMaxPosY>0){
                
                mixedErrorForPosY = posHorizMagnitudeCurr;
            }
            
            //if there is neg horiz error and vert error is on that side 
            else if (negHorizCategoryCurr != 0 && xValueAtMaxPosY<0){
                
                mixedErrorForPosY = negHorizMagnitudeCurr;
            }
            
            //if there is neg horiz error and vert error is on that side 
            else if (negHorizCategoryCurr == 0 && posHorizCategoryCurr == 0){
                
                mixedErrorForPosY = scatterVal3*1.6;//.75; - test Aug15 demo
            }
            else if (negHorizCategoryCurr != 0 && xValueAtMaxPosY>0) {
                
                //draw horiz error to the left
                drawPureLeft = YES;
            }
            else if (posHorizCategoryCurr != 0 && xValueAtMaxPosY<0) {
                
                //draw horiz error to the Right
                drawPureRight = YES;
            }
            
            else {}
            glColor4f(1, 1, 1, self.opacity);
            
            if (posVertCategoryCurr == 2 || posHorizCategoryCurr == 2 || negHorizCategoryCurr == 2) {
                
                heightFactor = posVertMagnitudeCurr*self.ampHeightFactor;
                
                if (heightFactor < 1) {
                    heightFactor = 1;
                }
                
                widthFactor = heightFactor/self.heightToWidthRatio;
                
                //redband0
                horizShift =  -self.errorAmp3*mixedErrorForPosY*(1+scatterVal3);
                [[self.tallRedTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:widthFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*mixedErrorForPosY*(1+scatterVal4);
                [[self.tallRedTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:widthFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
                
                //redband1
                horizShift =  -self.errorAmp2*mixedErrorForPosY*(1+scatterVal1);
                [[self.tallRedTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:widthFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp2*mixedErrorForPosY*(1+scatterVal2);
                [[self.tallRedTextures objectAtIndex:textID2] bindTexture];
                [self glQuadWithWidth:widthFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
                
                //redband2
                horizShift =  -self.errorAmp4*mixedErrorForPosY*(1+scatterVal5);
                [[self.tallRedTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:widthFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*mixedErrorForPosY*(1+scatterVal6);
                [[self.tallRedTextures objectAtIndex:textID3] bindTexture];
                [self glQuadWithWidth:widthFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
            }
            
            else {
                
                heightFactor = posVertMagnitudeCurr+.2; //+.5; - test Aug15 demo
                
                if (heightFactor < .7) {
                    heightFactor = .7;
                }
                
                
                //yellowband1
                horizShift =  -self.errorAmp3*mixedErrorForPosY*(1+scatterVal3);
                [[self.tallYellowTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp3*mixedErrorForPosY*(1+scatterVal4);
                [[self.tallYellowTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
                //yellowband2
                horizShift =  -self.errorAmp2*mixedErrorForPosY*(1+scatterVal1);
                [[self.tallYellowTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp2*mixedErrorForPosY*(1+scatterVal2);
                [[self.tallYellowTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
                //yellowband3
                horizShift =  -self.errorAmp4*mixedErrorForPosY*(1+scatterVal5);
                [[self.tallYellowTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2];
                
                horizShift =  -self.errorAmp4*mixedErrorForPosY*(1+scatterVal6);
                [[self.tallYellowTextures objectAtIndex:textID] bindTexture];
                [self glQuadWithWidth:heightFactor*imageWidthRocks*errorRocksScalar andHeight:heightFactor*imageHeightRocks*errorRocksScalar AtIndex:i*2-1];
                
            }
            
            
            if (drawPureRight) {
                
                glColor4f(1, 1, 1, self.opacity);
                
                if (posHorizCategoryCurr == 2) {
                    
                    boostScatter = 1;
                    
                    //yellowband
                    
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal1 + boostScatter);
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal2 + boostScatter);
                    [[self.yellowTextures objectAtIndex:textID4] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //redband1
                    
                    horizShift =  -self.errorAmp2*posHorizMagnitudeCurr*(scatterVal3 + boostScatter);
                    [[self.redTextures objectAtIndex:textID] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp2*posHorizMagnitudeCurr*(scatterVal4 + boostScatter);
                    [[self.redTextures objectAtIndex:textID2] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //redband2
                    
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal5 + boostScatter);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal6 + boostScatter);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
                
                if (posHorizCategoryCurr == 1) {
                    
                    boostScatter = .75;
                    
                    //so rocks don't appear in straight line
                    //when there is pure horizontal error and actual error value is too low, boost both the error and scatter
                    
                    if (posHorizMagnitudeCurr < .2) {
                        
                        posHorizMagnitudeCurr = .2;
                        increasedScatter = 2.0;
                    }
                    
                    //yellowband1
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal1 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*posHorizMagnitudeCurr*(scatterVal2 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //yellowband2
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal3 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*posHorizMagnitudeCurr*(scatterVal4 + boostScatter)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
            }
            
            if (drawPureLeft) {
                
                glColor4f(1, 1, 1, self.opacity);
                
                if (negHorizCategoryCurr == 2) {
                    
                    boostScatter = 1;
                    
                    
                    //yellowband
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(boostScatter + scatterVal1);
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(boostScatter + scatterVal2);
                    [[self.yellowTextures objectAtIndex:textID4] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //redband1
                    horizShift =  -self.errorAmp2*negHorizMagnitudeCurr*(boostScatter + scatterVal3);
                    [[self.redTextures objectAtIndex:textID] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp2*negHorizMagnitudeCurr*(boostScatter + scatterVal4);
                    [[self.redTextures objectAtIndex:textID2] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    
                    //redband2
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(boostScatter + scatterVal5);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(boostScatter + scatterVal6);
                    [[self.redTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
                
                if (negHorizCategoryCurr == 1) {
                    
                    boostScatter = .75;
                    
                    //so rocks don't appear in straight line
                    //when there is pure horizontal error and actual error value is too low, boost both the error and scatter
                    
                    if (negHorizMagnitudeCurr > -.2) {
                        negHorizMagnitudeCurr = -.2;
                        increasedScatter = 2.0;
                        
                    }
                    
                    //yellowband1
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(1+scatterVal1)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp3*negHorizMagnitudeCurr*(1+scatterVal2)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                    //yellowband2
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(1+scatterVal3)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2];
                    
                    horizShift =  -self.errorAmp4*negHorizMagnitudeCurr*(1+scatterVal4)*increasedScatter;
                    [[self.yellowTextures objectAtIndex:textID3] bindTexture];
                    [self glQuadWithWidth:imageWidthRocks*errorRocksScalar andHeight:imageHeightRocks*errorRocksScalar  AtIndex:i*2-1];
                    
                }
            }

            
        }
        
        
        
	}
    
    glPopMatrix();	
}
*/



//Simple barGraph with error magnitudes and category color
-(void) drawPlotWithState:(GraphicsState *)state andOpacity:(float)adaptableOpacity
{
    float imageWidth = plotScaleX+10;
    float imageHeight = plotScaleY+10;
    float pathZprimeSpreadTemp = 20;
    
    
    glPushMatrix();
    
    glTranslated(-700, -200, 0);
    
    int i;
    
	for (i = self.binNumber-1; i >= 0; i--)
    {
        
        float colorPos = [[self.posHorizCategory objectAtIndex:i] floatValue];
        
        if(colorPos == 0) glColor4f(34./255, 139./255, 34./255, adaptableOpacity);
        if(colorPos == 1) glColor4f(1, 215./255, 0, adaptableOpacity);
        if(colorPos == 2) glColor4f(1, 0, 0, adaptableOpacity);
        
        float horizPoz =  -150*[[self.posHorizDisplacement objectAtIndex:i] floatValue];
        
        float z = 0;
        glBegin(GL_QUADS);
        
        glTexCoord3f(0.0, 0.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope, -imageHeight/2+i*pathZprimeSpreadTemp, 0.0);
        
        glTexCoord3f(1.0, 0.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-horizPoz, -imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glTexCoord3f(1.0, 1.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-horizPoz, imageHeight/2+i*pathZprimeSpreadTemp ,0.0);
        
        glTexCoord3f(0.0, 1.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope, imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glEnd();
        
        
        
        float colorNeg = [[self.negHorizCategory objectAtIndex:i] floatValue];
        
        if(colorNeg == 0) glColor4f(34./255, 139./255, 34./255, adaptableOpacity);
        if(colorNeg == 1) glColor4f(1, 215./255, 0, adaptableOpacity);
        if(colorNeg == 2) glColor4f(1, 0, 0, adaptableOpacity);
        
        float horizNeg =  -150*[[self.negHorizDisplacement objectAtIndex:i] floatValue];
        
        glBegin(GL_QUADS);
        
        glTexCoord3f(0.0, 0.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-20-horizNeg, -imageHeight/2+i*pathZprimeSpreadTemp, 0.0);
        
        glTexCoord3f(1.0, 0.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-20, -imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glTexCoord3f(1.0, 1.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-20, imageHeight/2+i*pathZprimeSpreadTemp ,0.0);
        
        glTexCoord3f(0.0, 1.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-20-horizNeg, imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glEnd();
        
        
    }
    
    glPopMatrix();
    
    glPushMatrix();
    glTranslated(plotCenterX-700, 380, 0);
    glRotated(-90, 0, 0, 1);
    
    
	for (i = self.binNumber-1; i >= 0; i--)
    {
        
        float vertPos =  -150*[[self.negVertDisplacement objectAtIndex:i] floatValue];
        float colorPos = [[self.negVertCategory objectAtIndex:i] floatValue];
        
        if(colorPos == 0) glColor4f(34./255, 139./255, 34./255, adaptableOpacity);
        if(colorPos == 1) glColor4f(1, 215./255, 0, adaptableOpacity);
        if(colorPos == 2) glColor4f(1, 0, 0, adaptableOpacity);
        
        
        float z = 0;
        glBegin(GL_QUADS);
        
        glTexCoord3f(0.0, 0.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope, -imageHeight/2+i*pathZprimeSpreadTemp, 0.0);
        
        
        glTexCoord3f(1.0, 0.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope+vertPos, -imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glTexCoord3f(1.0, 1.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope+vertPos, imageHeight/2+i*pathZprimeSpreadTemp ,0.0);
        
        glTexCoord3f(0.0, 1.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope, imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glEnd();
        
        
        
        float vertNeg =  -150*[[self.posVertDisplacement objectAtIndex:i] floatValue];
        float colorNeg = [[self.posVertCategory objectAtIndex:i] floatValue];
        
        if(colorNeg == 0) glColor4f(34./255, 139./255, 34./255, adaptableOpacity);
        if(colorNeg == 1) glColor4f(1, 215./255, 0, adaptableOpacity);
        if(colorNeg == 2) glColor4f(1, 0, 0, adaptableOpacity);
        
        
        glBegin(GL_QUADS);
        
        glTexCoord3f(0.0, 0.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope+vertNeg-20, -imageHeight/2+i*pathZprimeSpreadTemp, 0.0);
        
        
        glTexCoord3f(1.0, 0.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-20, -imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glTexCoord3f(1.0, 1.0, z);
        glVertex3f( imageWidth/2-i*pathZprimeSpreadTemp*pathSlope-20, imageHeight/2+i*pathZprimeSpreadTemp ,0.0);
        
        glTexCoord3f(0.0, 1.0, z);
        glVertex3f(-imageWidth/2-i*pathZprimeSpreadTemp*pathSlope+vertNeg-20, imageHeight/2+i*pathZprimeSpreadTemp , 0.0);
        
        glEnd();
        
    }
    
    glPopMatrix();
    
}






@end

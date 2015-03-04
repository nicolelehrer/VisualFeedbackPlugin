//
//  BoatController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "MALevel2FeedbackData.h"

@class VFAnalysisFrame;
@class AnalysisFeatures;

@interface BoatController : NSObject

@property(retain) VFAnalysisFrame * analysisFrame;
@property(retain) AnalysisFeatures * analysisFeatures;
@property(retain) DTime * timekeeper;

@property(assign) float fogDisplacement;
@property(assign) float fogOpacity;

@property(assign) int randomVariation;

@property(retain) Texture2d * efficientTexture0;
@property(retain) Texture2d * efficientTexture1;
@property(retain) Texture2d * efficientTexture2;

@property(retain) Texture2d * boatTextureInaccurate0Shadow;

@property(retain) Texture2d * boatTextureInaccurate0;
@property(retain) Texture2d * boatTextureInaccurate1;
 
@property(retain) Texture2d * boatTextureInaccurate0Red;
@property(retain) Texture2d * boatTextureInaccurate1Red;

@property(retain) Texture2d * boatTextureInaccurate0RedVar1;
@property(retain) Texture2d * boatTextureInaccurate1RedVar1;

@property(retain) Texture2d * boatTexutreSegment01;
@property(retain) Texture2d * boatTexutreSegment11;
@property(retain) Texture2d * boatTexutreSegment21;

@property(retain) Texture2d * boatTexutreSegment01Red;
@property(retain) Texture2d * boatTexutreSegment11Red;
@property(retain) Texture2d * boatTexutreSegment21Red;


@property(retain) Texture2d * boatTexutreSegment00Red;
@property(retain) Texture2d * boatTexutreSegment10Red;
@property(retain) Texture2d * boatTexutreSegment20Red;


@property(retain) Texture2d * boatTexutreSegment00;
@property(retain) Texture2d * boatTexutreSegment10;
@property(retain) Texture2d * boatTexutreSegment20;

@property(retain) Texture2d * lampTextureNoLight;    
@property(retain) Texture2d * lampTexture;

@property(retain) Texture2d * boatGrasp0;
@property(retain) Texture2d * boatGrasp1;
@property(retain) Texture2d * boatGrasp2;

@property(retain) Texture2d * boatGrasp0incomplete;
@property(retain) Texture2d * boatGrasp1incomplete;
@property(retain) Texture2d * boatGrasp2incomplete;

@property(retain) Texture2d * boatGraspMild;

@property(retain) Texture2d * fogTagTexture;
@property(retain) Texture2d * lastStepTexture;
@property(retain) Texture2d * fogOverlayTexture;

@property(assign) float fogTranslateX;
@property(assign) float fogTranslateY;
 
@property(assign) float boatSizeX;
@property(assign) float boatSizeY;
@property(assign) float boatOpacity;

@property(assign) float boatTransX;
@property(assign) float boatTransY;
@property(assign) float boatTransZ;
@property(assign) float boatRotX;
@property(assign) float boatRotY;
@property(assign) float boatRotZ;

@property(assign) float randOpac;

-(void) drawBoatWithTag:(VisualLevel2Content)tag;
-(void) resetValues;
-(void) drawDepthOverlay;
-(void) drawFogWithLiftTag:(VisualLevel2Content)liftTag WithFadeUpCue:(BOOL)fadeUpCue;


@end

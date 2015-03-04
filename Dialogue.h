//
//  Dialogue.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "VisualFeedback.h"
#import "SceneTransitionController.h"
#import <AVFoundation/AVFoundation.h>

@interface Dialogue : Transform


- (void) setVisualFeedback:(VisualFeedback *)f;
- (void)speak;

@property(retain) DTime * timekeeper;

@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) VFAdaptationDelegate * gVFAdaptationDelegate;

@property(retain) NSDictionary * dialogueDictionary;

@property(retain) NSString * dialogueContentsPList;
@property(retain) NSString * dialogueKey;


@property(retain) NSArray * dialogueContents;
@property(retain) NSArray * imageIDs;

@property(assign) float dialogueIntensity;

@property(assign) float textTransX;
@property(assign) float textTransY;
@property(assign) float textTransZ;

@property(assign) float sceneOpacity;

@property(retain) SceneTransitionController * sceneTransitionController;

@property(retain) NSArray * targetObjectTextures;

@property(retain) Texture2d * tableTexture;
@property(retain) Texture2d * successTexture;

@property(retain) Texture2d * lightIndicatorIps;
@property(retain) Texture2d * lightIndicatorMid;

@property(retain) Texture2d * orderRightLeft;
@property(retain) Texture2d * orderLeftRight;

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

@property(retain) Texture2d * leftErrorTexture;
@property(retain) Texture2d * middleErrorTexture;
@property(retain) Texture2d * rightErrorTexture;
@property(retain) Texture2d * transportEnableErrorTexture;


@property(assign) BOOL didReact;

@property(assign) BOOL fadeUpLight;
@property(assign) BOOL rightToLeft;

@property(assign)     float lightOpacity;

@property(assign) NSSpeechSynthesizer * synth;
@property(assign) AVAudioPlayer* audioPlayer;

@end


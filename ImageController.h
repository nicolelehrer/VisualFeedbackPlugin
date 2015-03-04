//
//  ImageController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
@interface ImageController : NSObject

@property(retain) Texture2d * taskTexture0;
@property(retain) Texture2d * taskTexture1;
@property(retain) Texture2d * taskTexture2;
@property(retain) Texture2d * taskTexture2b;

@property(retain) Texture2d * taskTexture3;
@property(retain) Texture2d * taskTexture4;
@property(retain) Texture2d * taskTexture5;
@property(retain) Texture2d * offRestPad;

@property(retain) Texture2d * doneButton;
@property(retain) Texture2d * readyButton;

@property(retain) Texture2d * fbTextureRealTime;
@property(retain) Texture2d * feedback0TWhite;
@property(retain) Texture2d * feedback0TRed;

@property(retain) Texture2d * markerTexture;
@property(retain) Texture2d * chairTexture;

@property(retain) Texture2d * yesButton;
@property(retain) Texture2d * noButton;

@property(assign) float imageOpacity;
@property(assign) float textImageID;

@property(retain) NSString * imageGroupName;

@property(assign) BOOL showButtons;

@property(retain) Texture2d * nextButton;
@property(retain) Texture2d * replayButton;
@property(retain) Texture2d * moreDetailButton;

-(void) drawImageGroup:(NSString *)groupName WithID:(int)imageID;
-(void) drawButtonForGroupName:(NSString*)groupName;
-(void) drawButtonsForInstructionType:(NSString*)instructionType;

@end

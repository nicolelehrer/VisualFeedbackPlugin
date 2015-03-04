//
//  FogScape.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Cocoa/Cocoa.h>

//#import <Foundation/Foundation.h>
#import "Transform.h"
#import "Shader.h"
#import "DTime.h"
#import "Texture2d.h"
@class VisualFeedback;

@interface FogScape : Transform {
    
    VisualFeedback * gVisualFeedback;
    Shader * fogShader;
    
    float * vectorData;
    float * textureData;
    
    GLuint	vertexVBO;
    GLuint	textureVBO;
}

-(void) setVisualFeedback:(VisualFeedback *) f;

@property(retain) VisualFeedback * gVisualFeedback;
@property(retain) Shader * fogShader;

@property(assign) float * vectorData;
@property(assign) float * textureData;

@property(assign) GLuint vertexVBO;
@property(assign) GLuint textureVBO;

@end
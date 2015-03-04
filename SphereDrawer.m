//
//  SphereDrawer.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SphereDrawer.h"

@implementation SphereDrawer


+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"SphereDrawer.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	SphereDrawer * node = [[SphereDrawer alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}

#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
    }
    
    
	return self;
}




-(void) setCameraPosition
{
    
    [[[Dash dashView] cam] setTranslateY:2000];
    
    
    
}


- (void) drawShape:(GraphicsState *)state
{ 
    
    [self setCameraPosition];
    
    float shapeSize = 300;

    glColor4f(1, 0, 0, 1);    
    
    glPushMatrix();
    drawSolidSphere(shapeSize, 32, 32);
    glPopMatrix();
    
    glColor4f(0, 1, 0, 1);   
    
    glPushMatrix();
    glTranslated(500, 0, 0);
    glRotated(45, 1, 0, 0);
    drawSolidCube(shapeSize);
    glPopMatrix();
}

-(void) dealloc
{
    [super dealloc];
}


@end

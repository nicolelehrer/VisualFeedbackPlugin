//
//  FogScape.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FogScape.h"
#import "Log.h"
#import "TextureController.h"
#import "TimeController.h"
#import "MaterialController.h"
#import "DashHeaders.h"
#import "VisualFeedback.h"
#import "Path.h"

@implementation FogScape
@synthesize gVisualFeedback;
@synthesize fogShader;

@synthesize vectorData; 
@synthesize vertexVBO;

@synthesize textureVBO;
@synthesize textureData; 



+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"VFPostSetScenario.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	FogScape * node = [[FogScape alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}



#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
        [self setUpShader];
        [self loadBGVertCoords];
  		[self loadBGTexCoords];         
    }
	
	return self;
}



-(void) setVisualFeedback:(VisualFeedback *) f
{
	self.gVisualFeedback = f;
}



-(void) setUpShader
{
    NSString * shadersDirectoryPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    
    fogShader = [[MaterialController materialController] addShader:[shadersDirectoryPath stringByAppendingPathComponent:@"/shaders/Brick"]];
    
    [fogShader load];
    
	glUniform1fARB( glGetUniformLocationARB( fogShader.programObject, "Scale"), 0.0 );
    
	[fogShader unload];
}


-(void) createBGVertArray
{
	float imageWidth = 600;
	float imageHeight = 600;
	float gridSizeX = 40;
    float gridSizeY = 40;
    int colCount;
    int rowCount;
    float x = 0;
    float y = 0;
    
	float deltaVertX = imageWidth/gridSizeX;
	float deltaVertY = imageHeight/gridSizeY;
	
	for(colCount=0; colCount<gridSizeY; colCount++)		
	{		
		for(rowCount=0; rowCount<gridSizeX; rowCount++)	
		{
            
			*vectorData++ = -x+rowCount*deltaVertX;
			*vectorData++ = -y+colCount*deltaVertY;
			
			*vectorData++ = 0.0;	
			
			*vectorData++ = -x+(rowCount+1)*deltaVertX;
			*vectorData++ = -y+colCount*deltaVertY;
			
			*vectorData++ = 0.0;
			
			*vectorData++ = -x+(rowCount+1)*deltaVertX;
			*vectorData++ = -y+(colCount+1)*deltaVertY;
			
			*vectorData++ = 0.0;
			
			*vectorData++ = -x+rowCount*deltaVertX;
			*vectorData++ = -y+(colCount+1)*deltaVertY;
			
			*vectorData++ = 0.0;
		}
	}
}


-(void) createBGTexArray
{
	float imageWidth = 600;
	float imageHeight = 600;
	float gridSizeX = 40;
    float gridSizeY = 40;
    int colCount;
    int rowCount;
         
	float deltaTexX = imageWidth/gridSizeX;
	float deltaTexY = imageHeight/gridSizeY;
    
	for(colCount=0; colCount<gridSizeY; colCount++)		
	{
		for(rowCount=0; rowCount<gridSizeX; rowCount++)	
		{	
			*textureData++ = rowCount*deltaTexX;
			*textureData++ =  colCount*deltaTexY;
			
			*textureData++ = (rowCount+1)*deltaTexX;
			*textureData++ = colCount*deltaTexY;
			
			*textureData++ = (rowCount+1)*deltaTexX;
			*textureData++ =  (colCount+1)*deltaTexY;
			
			*textureData++ = rowCount*deltaTexX;
			*textureData++ = (colCount+1)*deltaTexY;
		}
		
	}
}


- (void) loadBGVertCoords
{	
    float gridSizeX = 40;
    float gridSizeY = 40;
    float numVertices = 4*gridSizeX*gridSizeY;

	glGenBuffers( 1, &vertexVBO );					// number of buffer objects, array filled with new buffer object names 
	glBindBuffer( GL_ARRAY_BUFFER, vertexVBO );		// target - type of array being bound, name of buffer object 
	glBufferData( GL_ARRAY_BUFFER, numVertices * 3 * sizeof(float), NULL, GL_STATIC_DRAW );	//4 = number of vertices, 3 = number of xyz, sizeof = size in bytes 	
	vectorData = (float *)glMapBuffer( GL_ARRAY_BUFFER, GL_WRITE_ONLY );
	
	[self createBGVertArray];
	
	glUnmapBuffer( GL_ARRAY_BUFFER );		
}



- (void) loadBGTexCoords
{	
    float gridSizeX = 40;
    float gridSizeY = 40;
    float numVertices = 4*gridSizeX*gridSizeY;
 
	glGenBuffers( 1, &    textureVBO);					// number of buffer onjects, array filled with new buffer object names 
	glBindBuffer( GL_ARRAY_BUFFER,     textureVBO );		// target - type of array being bound, name of buffer object 
	
	glBufferData( GL_ARRAY_BUFFER, numVertices * 2 * sizeof(float), NULL, GL_STATIC_DRAW );	
	textureData = (float *)glMapBuffer( GL_ARRAY_BUFFER, GL_WRITE_ONLY );
	
	[self createBGTexArray];
	
	glUnmapBuffer( GL_ARRAY_BUFFER );
	
}

-(void) drawFogTest
{
    float gridSizeX = 40;
    float gridSizeY = 40;
    float numVertices = 4*gridSizeX*gridSizeY;

 	glDisable( GL_DEPTH_TEST );
	glEnable( GL_BLEND );
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	
//	glEnable( GL_TEXTURE_2D );
    
	[fogShader load];
    
	glUniform1fARB( glGetUniformLocationARB( fogShader.programObject, "Scale"), gVisualFeedback.dialogue.textTransX);

	glPushMatrix();

    
  	glBindBuffer( GL_ARRAY_BUFFER, vertexVBO );
	glVertexPointer( 3, GL_FLOAT, 0, 0 );
	glEnableClientState( GL_VERTEX_ARRAY );
	
//	glBindBuffer( GL_ARRAY_BUFFER, textureVBO );
//	glTexCoordPointer( 2, GL_FLOAT, 0, 0 );
//	glEnableClientState( GL_TEXTURE_COORD_ARRAY ); 
	
	glDrawArrays( GL_QUADS, 0, numVertices);
	
	glPopMatrix();
	
	[fogShader unload];
    
//	glDisableClientState( GL_TEXTURE_COORD_ARRAY );
	glDisableClientState( GL_VERTEX_ARRAY );	
 
//	glDisable( GL_TEXTURE_2D );     
}



-(void) glQuadCallWithHeight:(float) imageHeight andWidth:(float)imageWidth
{
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
}


- (void) drawShape:(GraphicsState *)state
{
    [self drawFogTest];
}



@end

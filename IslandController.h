//
//  IslandController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "TravelController.h"
#import "Level3SceneController.h"


typedef enum {
    showEfficient,
    showMild,
    showSevere
} IslandTypes;

@interface IslandController : NSObject

-(void) drawConeIslandInTravelConditions:(float)travelCondition WithPerformanceLevel:(int)performanceLevel OnSide:(int)islandSide InOrder:(int)islandOrder;
-(void) drawVirtualIslandInTravelConditions:(float)travelCondition WithPerformanceLevel:(int)performanceLevel OnSide:(int)islandSide InOrder:(int)islandOrder;
-(void) drawButtonIslandInTravelConditions:(float)travelCondition WithPerformanceLevel:(int)performanceLevel OnSide:(int)islandSide InOrder:(int)islandOrder;
-(void) drawTransportIslandInTravelConditions:(float)travelCondition WithPerformanceLevel:(int)performanceLevel OnSide:(int)islandSide InOrder:(int)islandOrder;

//test


-(void) resetDisplacement;
- (id) initWithPositionX:(float)positionX andPositionY:(float)positionY andPositionZ:(float)positionZ;
-(void) drawHorizonIslandDay;
-(void) drawHorizonIslandGrey;
-(void) drawHorizonIslandDark;
-(void) drawHorizonIslandGreyExtended;


-(void) drawBlueFogOverlay;
-(void) drawGreyFogOverlay;
-(void) drawIslandCluster; 
-(void) mixRandomFloatsArray;


@property(retain) Level3SceneController * level3SceneController;

@property(assign) IslandTypes islandTypes;

@property(assign) BOOL debugSwitch;

@property(assign) float tempFogScaleX;
@property(assign) float tempFogScaleY;

@property(assign) float waterfallTransX;
@property(assign) float waterfallTransY;
@property(assign) float waterfallTransZ;

@property(assign) float waterfallRotX;
@property(assign) float waterfallRotY;
@property(assign) float waterfallRotZ;

@property(assign) float waterfallScaleX;
@property(assign) float waterfallScaleY;
@property(assign) float waterfallScaleZ;


@property(assign) float distanceThresshold;
@property(assign) float islandCount;
@property(assign) float scatterAmp;

@property(retain) NSMutableArray * randomFloats;
@property(retain) Texture2d * fog;
@property(assign) BOOL showFog;
@property(assign) float manipQualFlat1;
@property(assign) float manipQualFlat2;
@property(assign) float manipQualCone1;
@property(assign) float manipQualCone2;

@property(retain) Texture2d * hazyBlueConeIsland;
@property(retain) Texture2d * hazyGreyConeIsland;


@property(retain) Texture2d * hazyButtonIsland;
@property(retain) Texture2d * hazyGreyButtonIsland;

@property(assign) float hazeOpacity;

@property(assign) float hazeScaleX;
@property(assign) float hazeScaleY;


@property(retain) Texture2d * islandTexture0;
@property(retain) Texture2d * islandTexture1;
@property(retain) Texture2d * islandTexture2;
@property(retain) Texture2d * islandTexture3;

@property(retain) Texture2d * blueFogTexture;
@property(retain) Texture2d * greyFogTexture;

@property(retain) Texture2d * horizonIslandDay; 
@property(retain) Texture2d * horizonIslandGrey; 
@property(retain) Texture2d * horizonIslandDark; 

@property(retain) Texture2d * flatIslandFail;
@property(retain) Texture2d * lightHouseFail;

@property(retain) Texture2d * lightHouse0;

@property(retain) Texture2d * lightHouseLightOn;
@property(retain) Texture2d * lightHouseLightOff;

@property(retain) Texture2d * waterFallSheet;
@property(retain) Texture2d * waterMist;

@property(retain) Texture2d * flatGreenIsland;
@property(retain) Texture2d * flatGreenIslandBlue;
@property(retain) Texture2d * flatGreenIslandGrey;

@property(retain) Texture2d * bushIsland;

@property(retain) DTime * dTimer;


@property(assign) BOOL showLightHouses;

@property(assign) float fractionTraveled;

@property(assign) float yComponent;
@property(assign) float zComponent;

@property(assign) float yComponent0;
@property(assign) float yComponent1;
@property(assign) float zComponent0;
@property(assign) float zComponent1;

@property(assign) float islandTransX;
@property(assign) float islandTransY;
@property(assign) float islandTransZ;

@property(assign) float islandScaleX;
@property(assign) float islandScaleY;
@property(assign) float islandScaleZ;

@property(assign) float islandOpacity;


@property(assign) float lightHouseTransX;
@property(assign) float lightHouseTransY;
@property(assign) float lightHouseTransZ;

@property(assign) float lightHouseScaleX;
@property(assign) float lightHouseScaleY;
@property(assign) float lightHouseScaleZ;

@property(assign) float lightHouseRotX;
@property(assign) float lightHouseRotY;
@property(assign) float lightHouseRotZ;


@property(assign) Texture2d * lightBeam;

@property(assign) float lightOpacityDuringFirstStop;
@property(assign) float lightOpacityDuringSecondStop;

@property(assign) float displacement;

@property(assign) float displacement0;
@property(assign) float stop0;
@property(assign) float displacement1;
@property(assign) float stop1;

@property(assign) float speedFactor;
@property(assign) float islandOverlap;

@property(assign) float lighteningReflection;

@property(assign) float island3transY;
@property(assign) float island4transY;
@property(assign) float island3transZ;
@property(assign) float island4transZ;

@end

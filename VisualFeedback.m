//
//  VisualFeedback.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  This class implements a Transform node plugin named VisualFeedback.

#import "VisualFeedback.h"
 

static VisualFeedback * gVisualFeedback;


@interface VisualFeedback ()
-(void) initVFObjects;

@end

@implementation VisualFeedback

@synthesize analysis = _analysis;
@synthesize demoDrawer = _demoDrawer;
@synthesize windowController = _windowController;

@synthesize level1SceneDrawer = _level1SceneDrawer;
@synthesize level2SceneDrawer = _level2SceneDrawer;
@synthesize level3SceneDrawer = _level3SceneDrawer;

@synthesize adaptationDelegate = _adaptationDelegate;

@synthesize currentScenario = _currentScenario;
@synthesize nextScenario = _nextScenario;
@synthesize countScenarioChanges = _countScenarioChanges;
@synthesize scenarioDidChange = _scenarioDidChange;  

@synthesize farClipValue = _farClipValue;

@synthesize currEnabledLevel = _currEnabledLevel;

@synthesize postTrialScenario = _postTrialScenario;
@synthesize postSetScenario = _postSetScenario;
@synthesize postSequenceScenario = _postSequenceScenario;

@synthesize triggerLevelDisplay = _triggerLevelDisplay;

@synthesize instructionDrawer = _instructionDrawer;
@synthesize turnOnMasterDisableGridLightInfo = _turnOnMasterDisableGridLightInfo;

#pragma mark ---- class methods ----

+ (BOOL) initializePlugin:(NSBundle *)bundle
{
	logInfo( @"initializePlugin VisualFeedback" );
    
    [VisualFeedback sharedVisualFeedback];
	return YES;
}

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"VisualFeedback.createWithName( %@ ) parent( %@ )", aName, aParent.name );
	VisualFeedback * node = [[VisualFeedback alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}


+ (VFAdaptationDelegate*) vfAdaptationDelegate
{
    return [gVisualFeedback adaptationDelegate];
}


+ (VisualFeedback*) sharedVisualFeedback
{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        gVisualFeedback = [[super allocWithZone:NULL] initWithName:@"VisualFeedback" parent:[Dash root]];
    });
    return gVisualFeedback;
}


+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        gVisualFeedback = [super allocWithZone:zone];
    });
    return gVisualFeedback;
}


#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
        
        
        [self initVFObjects];
        
        self.currEnabledLevel = kLevelOff;

		self.level1SceneDrawer.currentFrame = self.analysis.currentFrame;
		self.level2SceneDrawer.currentFrame = self.analysis.currentFrame;
		self.level3SceneDrawer.currentFrame = self.analysis.currentFrame;
        self.demoDrawer.currentFrame = self.analysis.currentFrame;
        
//        self.level2SceneDrawer.analysisFeatures.boatQuality =  3; // = self.analysis.analysisFeatures;

		self.currentScenario = 0;
		self.scenarioDidChange = NO;		

		self.countScenarioChanges = 0;
        self.farClipValue = 50000000;//500000.0;
        
//        [self makeViewFullScreen];
        
//        [self setUpState];
        self.turnOnMasterDisableGridLightInfo = YES;

    }
	
    return self;
}

-(void)setUpState
{
    GraphicsState * state = [[Dash dashView] graphicsState];
	state.showGrid = NO;
	state.showLights = NO;
    state.showInfo = NO;
}

-(void) initVFObjects
{
    
	self.adaptationDelegate = [[VFAdaptationDelegate alloc] init];
	[self.adaptationDelegate setVisualFeedback:self];
	
	self.analysis = [[VFAnalysis alloc] init];
	[self.analysis setVisualFeedback:self]; 
    
	self.windowController = [[VFWindowController alloc] init];
	[self.windowController setVisualFeedback:self];
    
       
    self.level1SceneDrawer = [Level1SceneDrawer createWithName:@"Level1SceneDrawer" parent:[Dash root]];
    [self.level1SceneDrawer setVisualFeedback:self];
    
    self.level2SceneDrawer = [Level2SceneDrawer createWithName:@"Level2SceneDrawer" parent:[Dash root]];
    [self.level2SceneDrawer setVisualFeedback:self];
    
    self.level3SceneDrawer = [Level3SceneDrawer createWithName:@"Level3SceneDrawer" parent:[Dash root]];
    [self.level3SceneDrawer setVisualFeedback:self];

//    self.demoDrawer = [DemoDrawer createWithName:@"DemoDrawer" parent:[Dash root]];
//	[self.demoDrawer setVisualFeedback:self];
    
    self.instructionDrawer = [InstructionsDrawer createWithName:@"InstructionsDrawer" parent:[Dash root]];
    [self.instructionDrawer setVisualFeedback:self];
    
}


///ripped from loren's biofeedback plugin
+ (void) makeViewFullScreen
{
	// move the opengl window to the secondary screen,
	// and make it fullscreen
	NSArray *screens = [NSScreen screens];
	
	//
	// documentation claims that the screen with the menu bar is at index 0
	// if there is more than one screen, move the window to the second
	// screen, then make it full screen.
	//
	if ([screens count] == 1) {
		logWarn( @"There is only one screen attached, skipping fullscreen display." );
	}
	else if ([screens count] > 1) {
		logDebug( @"There are %d screens available.", [screens count] );
		
		NSWindow * window = [[Dash dashView] window];
		NSScreen * screen = [screens objectAtIndex:1];
		//NSRect aFrame = [window frame];
		
		// move the gl window to the second screen
		//aFrame.origin.x = [secondScreen frame].origin.x;
		//[window setFrame:aFrame display:YES];
		[[window animator] setFrameOrigin:[screen frame].origin];
		
		// make the gl window full screen
		[window makeKeyAndOrderFront:self];
		[[Dash dashView] toggleFullScreen:self];
		
		// there should be some kind of test here to determine if we need to use the stretch or not
		// do we need to keep this option?
		//[dash setIsWideScreenStretch:YES];
		
	}
}




//- (void) updateScenario
//{	
//	self.nextScenario = self.adaptationDelegate.scenario;
//	if (self.nextScenario != self.currentScenario)
//	{
//		self.scenarioDidChange = YES;
//	}
//	else {
//        
//		self.scenarioDidChange = NO;
//	}
//
//}

- (void) drawShape:(GraphicsState *)state

{
    [[[Dash dashView] cam] setFarClip:self.farClipValue];
    if (self.turnOnMasterDisableGridLightInfo) {
        
        [self setUpState]; //temp location to override some setting in compiled dash
    }
//	self.currentScenario = self.nextScenario;
    
    
    
}


- (NSString *)description
{
    return( [NSString stringWithFormat:@"VisualFeedback %@", name ] );
}


 
- (void) dealloc
{
    [super dealloc];
    [self.windowController release];
    [self.analysis release];
    [self.level3SceneDrawer release];
    [self.level2SceneDrawer release];
    [self.level1SceneDrawer release];

    self.adaptationDelegate = nil;
}




@end

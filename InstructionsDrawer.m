//
//  InstructionsDrawer.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 2/7/13.
//
//

#import "InstructionsDrawer.h"


@interface InstructionsDrawer()
@property (assign) BOOL stopDrawingBecauseTargetsAreCorrect;
@property (assign) BOOL flagToStartVideo;
@property (retain) Texture2d * whiteBar;
@end

@implementation InstructionsDrawer
@synthesize gVisualFeedback = _gVisualFeedback;
@synthesize opacity = _opacity;
@synthesize videoController = _videoController;
@synthesize instructionsDictionary = _instructionsDictionary;
@synthesize imageController = _imageController;
@synthesize targetSetup = _targetSetup;
@synthesize textController = _textController;
@synthesize tangibleSetupResultsReceived = _tangibleSetupResultsReceived;
@synthesize stopDrawingBecauseTargetsAreCorrect = _stopDrawingBecauseTargetsAreCorrect;
@synthesize flagToStartVideo = _flagToStartVideo;
@synthesize whiteBar = _whiteBar;

+ (id) createWithName:(NSString *)aName parent:(Node *)aParent
{
	ReturnNilIfObjectIsNil( aName );
	ReturnNilIfObjectIsNil( aParent );
	
	logDebug( @"InstructionsDrawer( %@ ) parent( %@ )", aName, aParent.name );
	InstructionsDrawer * node = [[InstructionsDrawer alloc] initWithName:aName parent:aParent];
	ReturnNilIfObjectIsNil( node );
	
	return node;
}



#pragma mark ---- initializers  ----
- (id) initWithName:(NSString *)aName parent:(Node *)aParent
{
	self = [super initWithName:aName parent:aParent];
    if (self) {
        
        self.opacity = 1.0;
        self.videoController = [[VideoController alloc] init];
        [self loadInstructionPListIntoArray];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(checkIfShouldPlayVideo:)
													 name:@"checkIfShouldPlayVideo"
												   object:nil];
        
        
        self.imageController = [[ImageController alloc] init];
        self.targetSetup = [[TargetSetup alloc] init];
        self.textController = [[TextController alloc] init];
        
        self.targetSetup.sceneOpacity = 1.0;

        self.stopDrawingBecauseTargetsAreCorrect = NO;
        
        self.flagToStartVideo = NO;
        
        NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
        
        self.whiteBar = [[TextureController textureController] createTexture2dWithImage:[resourcesPath stringByAppendingPathComponent:@"/textures/demo/whiteBar.png"] target:GL_TEXTURE_2D];

    }
	
	return self;
}

-(void) setVisualFeedback:(VisualFeedback *) f
{
    self.gVisualFeedback = f;
}

- (void) loadInstructionPListIntoArray
{
	self.instructionsDictionary = [NSDictionary dictionaryWithContentsOfFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent: @"/Instructions.plist"]];

	if (self.instructionsDictionary == nil) {
		NSLog( @"instructionsDictionary is nil");
    }
    else {
    	NSLog( @"loaded %lu componenets from instructionsDictionary", [self.instructionsDictionary count]);
    }	
}

- (StringDisplay*) updateTextWithString:(NSString *)rawString
{                
    NSMutableAttributedString * outString;
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    
    //get an erro if increase textsize
    [attrs setObject: [NSFont fontWithName: @"Helvetica-Bold" size: 16.0f] forKey: NSFontAttributeName];
    [attrs setObject: [NSColor whiteColor] forKey: NSForegroundColorAttributeName];
    
    outString = [[[NSMutableAttributedString alloc] initWithString:rawString attributes:attrs] autorelease];

    return [[[StringDisplay alloc] initWithAttributedString:outString withTextColor:[NSColor colorWithDeviceRed:self.opacity green:self.opacity blue:self.opacity alpha:self.opacity] withBoxColor:[NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:.8f] withBorderColor:[NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:0.0f]] autorelease];
}




- (void)drawText
{
    
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );
        
    NSString * textForDisplay;
    StringDisplay * stringDisplayWithText;
    
    if ([self.instructionsDictionary valueForKey:self.gVisualFeedback.adaptationDelegate.instructionID]){
        
       if( ![[self.instructionsDictionary valueForKey:self.gVisualFeedback.adaptationDelegate.instructionID] isEqualToString:@"movie"] &&
        
           ![[self.instructionsDictionary valueForKey:self.gVisualFeedback.adaptationDelegate.instructionID] isEqualToString:@"animation"]) {
           
           textForDisplay = [self.instructionsDictionary valueForKey:self.gVisualFeedback.adaptationDelegate.instructionID];
           stringDisplayWithText = [self updateTextWithString:textForDisplay];
           NSSize frame = [stringDisplayWithText frameSize];
           float xPos = -frame.width/2.0;
           float yPos = -frame.height/2.0;
           float zPos = 6100;
           
           Vector3f * textPosition3d = [Vector3f createX:xPos Y:yPos Z:zPos];
           
           [stringDisplayWithText drawAtPoint3d:textPosition3d];           
       }
        
    }
    else {
        stringDisplayWithText = [self updateTextWithString:[NSString stringWithFormat:@"this string does not exist: %@", self.gVisualFeedback.adaptationDelegate.instructionID]];
        NSSize frame = [stringDisplayWithText frameSize];
        float xPos = -frame.width/2.0;
        float yPos = -frame.height/2.0;
        float zPos = 6100;
        
        Vector3f * textPosition3d = [Vector3f createX:xPos Y:yPos Z:zPos];
        
        [stringDisplayWithText drawAtPoint3d:textPosition3d];


    }
    
        
}





-(void) drawShape:(GraphicsState *)state
{

    
    if (! self.videoController.videoIsPlaying) {
    
        if (self.gVisualFeedback.currEnabledLevel == kLevelDemo) {

            [[[Dash dashView] cam] setTranslateY:0.0];
            [[[Dash dashView] cam] setTranslateZ:6440.0];

            
            if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"level3Reminder"]){
                
//                [self.targetSetup drawStaticTable];
                [self.targetSetup drawLevel3ReminderForTarget1:self.targetSetup.targetID1ForL3 andTarget2:self.targetSetup.targetID2ForL3];
            }
            
            
            
            if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"notifyTargetWithButtons"]){
                
                [self.targetSetup drawWhiteTableSizedBG];
                [self.targetSetup drawCylinderPlacementReminderAtLocation:self.gVisualFeedback.adaptationDelegate.position];
            }
            
            
            if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"notifyTargetWithButtonsCone"]){
                
                [self.targetSetup drawWhiteTableSizedBG];
                [self.targetSetup drawConePlacementReminderAtLocation:self.gVisualFeedback.adaptationDelegate.position];
            }

            
                if (self.gVisualFeedback.analysis.portableTargetIsInWrongPlace) {
                    
                    
                    [self.targetSetup drawWhiteTableSizedBG];
                    
                    if (self.gVisualFeedback.adaptationDelegate.transportIsCone) {                        
                        [self.targetSetup drawConePlacementReminderAtLocation:self.gVisualFeedback.analysis.targetUpdateID];
                    }
                    else{
                        [self.targetSetup drawCylinderPlacementReminderAtLocation:self.gVisualFeedback.analysis.targetUpdateID];
                    }
//                    NSLog(@"self.gVisualFeedback.analysis.targetUpdateID is %i", self.gVisualFeedback.analysis.targetUpdateID);
                }
            
            //if you're drawing for target setup check to make sure you should draw first using bool stopDrawingBecauseTargetsAreCorrect
            if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"targetSetup"] ||
                [self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"targetWrong"]) {
                
                
                if (!self.stopDrawingBecauseTargetsAreCorrect) {
                    [self drawTargetSetUp];

                    [self.imageController drawButtonsForInstructionType:self.gVisualFeedback.adaptationDelegate.demoType];
                    [self drawText];
                }
            }
            
            //if you're drawing for target setup check to make sure you should draw first using bool stopDrawingBecauseTargetsAreCorrect
            if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"targetSetup"] ||
                [self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"targetWrong"]) {
                
                if (!self.stopDrawingBecauseTargetsAreCorrect) {
                    
                    [self drawTargetSetUp];

                    [self.imageController drawButtonsForInstructionType:self.gVisualFeedback.adaptationDelegate.demoType];
                }
            }
            
            //otherwise just draw
            else{
                
                if (![self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"notifyTarget"] && ![self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"notifyTargetCone"])
                {
                    [self.imageController drawButtonsForInstructionType:self.gVisualFeedback.adaptationDelegate.demoType];
                    [self drawText];
                }
            }

            
            
            if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"setRest"]) {
                [self drawSessionProgressbar];
                [self drawProgressText];
            }
            
            
            
            
            
        }
    }
}

-(void) checkIfShouldPlayVideo:(NSNotification *) notification
{
    self.flagToStartVideo = YES;
    [self.videoController updateMediaWithID:self.gVisualFeedback.adaptationDelegate.instructionID];
    NSLog(@"THE STRING IN CHECK IS HSOULD PLAY video is : %@", self.gVisualFeedback.adaptationDelegate.instructionID);
}

//called in vfadaptationDelegate
-(void) tangibleConnectionDemo:(ADScenarioData *)adScen
{
    self.tangibleSetupResultsReceived = NO;
    
    self.targetSetup.targetTypeLeft = [adScen leftTarget];
    self.targetSetup.targetTypeMid = [adScen middleTarget];
    self.targetSetup.targetTypeRight = [adScen rightTarget];
}

-(void)drawTargetSetUp
{
    //managed by
    // tangibleConnectionDemo:(ADScenarioData *)adScen
    // tangibleSetup:(NSNotification *) notification
        
    if ([self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"targetSetup"] ||
        [self.gVisualFeedback.adaptationDelegate.instructionID isEqualToString:@"targetWrong"]) {
        
            [self.targetSetup drawTargetDemowithResultsIf:self.tangibleSetupResultsReceived];   
        
    }
}


//called in vfanalysis
-(void) tangibleSetup:(NSNotification *) notification
{
    NSDictionary * dict =  (NSDictionary*)([notification object]);
    self.targetSetup.leftTargetIsCorrect = [[dict valueForKey:@"leftTarget"] boolValue];
    self.targetSetup.rightTargetIsCorrect = [[dict valueForKey:@"rightTarget"] boolValue];
    self.targetSetup.middleTargetIsCorrect = [[dict valueForKey:@"middleTarget"] boolValue];
    
    if (!self.targetSetup.leftTargetIsCorrect  || !self.targetSetup.middleTargetIsCorrect || !self.targetSetup.rightTargetIsCorrect )
    {
        self.gVisualFeedback.adaptationDelegate.instructionID = @"targetWrong";
        [self.gVisualFeedback.adaptationDelegate runTaskInstruction:self.gVisualFeedback.adaptationDelegate.instructionID];
    }
    else{
        self.stopDrawingBecauseTargetsAreCorrect = YES;
    }
    
    self.tangibleSetupResultsReceived = YES;
}


-(void) drawSessionProgressbar
{
    float totalSessions = self.gVisualFeedback.adaptationDelegate.setCount;
    float progressFraction = self.gVisualFeedback.adaptationDelegate.setID/totalSessions; //might need to be dynamic
//    NSLog(@"Progress fraction is %f", progressFraction);
    float maxWidth = 5000.0;
    float adjustedWidth = maxWidth*progressFraction;
    
    glPushMatrix();
    glTranslated(-maxWidth/2, 1000, 0);
    [self drawQuadWithHeight:400 andWidth:maxWidth WithTexture:self.whiteBar WithOpacity:self.opacity/2.0];
    [self drawQuadWithHeight:300 andWidth:adjustedWidth WithTexture:self.whiteBar WithOpacity:self.opacity];

    glPopMatrix();
    
    
}


- (void)drawProgressText
{
    
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );
    
    StringDisplay * stringDisplayWithText;
    
    stringDisplayWithText = [self updateTextWithString:[NSString stringWithFormat:@"You are on set: %i of %i", self.gVisualFeedback.adaptationDelegate.setID, self.gVisualFeedback.adaptationDelegate.setCount]];
    NSSize frame = [stringDisplayWithText frameSize];
    float xPos = -frame.width/2.0;
    float yPos = -frame.height/2.0+80;
    float zPos = 6100;
    
    Vector3f * textPosition3d = [Vector3f createX:xPos Y:yPos Z:zPos];
    
    [stringDisplayWithText drawAtPoint3d:textPosition3d];
  
    
}


-(void) drawQuadWithHeight:(float) imageHeight andWidth:(float)imageWidth WithTexture:(Texture2d*)texture WithOpacity:(float)opacityValue
{
    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable(GL_LIGHTING);
    
    glEnable( GL_TEXTURE_2D );
    
    glColor4f(1, 1, 1, opacityValue);
    
    [texture bindTexture];
    
    glBegin(GL_QUADS);
    
    float z=0.0;
    
    glTexCoord3f(0.0, 0.0, z);
    glVertex3f(0, -imageHeight/2, 0.0);
    
    glTexCoord3f(1.0, 0.0, z);
    glVertex3f( imageWidth, -imageHeight/2, 0.0);
    
    glTexCoord3f(1.0, 1.0, z);
    glVertex3f( imageWidth, imageHeight/2, 0.0);
    
    glTexCoord3f(0.0, 1.0, z);
    glVertex3f(0, imageHeight/2, 0.0);
    
    glEnd();
    
    glDisable(GL_TEXTURE_2D);
    
}



-(void) dealloc
{
    [super dealloc];
}




@end

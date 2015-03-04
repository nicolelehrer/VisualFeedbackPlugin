//
//  TextController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextController.h"

@implementation TextController
@synthesize dialogueDictionary = _dialogueDictionary;
@synthesize elementID = _elementID;
@synthesize taskDemoMessages = _taskDemoMessages;
@synthesize synth = _synth;
@synthesize dialogueArrayIndex = _dialogueArrayIndex;
@synthesize didCompleteCheckList = _didCompleteCheckList;
@synthesize textOpacity = _textOpacity;
@synthesize textTransX = _textTransX;
@synthesize textTransY = _textTransY;
@synthesize textTransZ = _textTransZ;
@synthesize textLine = _textLine;
@synthesize sdText = _sdText;
@synthesize doneReading = _doneReading;
@synthesize dialogueGroupName = _dialogueGroupName;
@synthesize playWristPadSound = _playWristPadSound;
@synthesize soundController = _soundController;
@synthesize textLineCleaned = _textLineCleaned;

- (id)init
{
	self = [super init];
    if (self) {
        
        self.dialogueArrayIndex = 0;
        
        [self createSpeakObjects];
        [self loadDialoguePListIntoArray];
        
        self.textTransX = 0.0; 
        self.textTransY = -106.25;
        self.textTransZ = 6100;             
    }
	return self;
}

-(void) createSpeakObjects
{
    self.synth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
    
    [self.synth setVoice:@"Alex"];
    
    [self.synth setDelegate:self];
    
    self.soundController = [[SoundController alloc] init];
}

- (void) loadDialoguePListIntoArray
{
	self.dialogueDictionary = [NSDictionary dictionaryWithContentsOfFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent: @"/dialogueText.plist"]];
    
	if (self.dialogueDictionary == nil) {
		NSLog( @"dialogueDictionary is nil");
    }
    else {
    	NSLog( @"loaded %lu componenets from dialogueDictionary", [self.dialogueDictionary count]);        
    }
	
}

//called in hosting class 
- (void) selectMessageFromGroup:(NSString *)arrayName atIndex:(int)arrayIndex
{	
    if ([self.dialogueDictionary valueForKey:arrayName] != nil) {

        self.taskDemoMessages = [self.dialogueDictionary valueForKey:arrayName];
        //        NSLog(@"Found group name");
    }
    else {
        NSLog(@"Key does not exist in dialogue dictionary");
    }
    
    int maxElementCount = [self.taskDemoMessages count];

    if (arrayIndex >= 0 && arrayIndex < maxElementCount){

        self.textLine = [self.taskDemoMessages objectAtIndex:arrayIndex];
    }
}


-(NSString *) makeCleanStringFrom:(NSString *)rawString
{
    NSString * finalString;
    
    if (rawString != nil) {
 
        NSString * string1 = [self.textLine stringByReplacingOccurrencesOfString:@"[[" withString:@""];
        NSString * string2 = [string1 stringByReplacingOccurrencesOfString:@"]]" withString:@""];
        NSString * string3 = [string2 stringByReplacingOccurrencesOfString:@"emph" withString:@""];
        NSString * string4 = [string3 stringByReplacingOccurrencesOfString:@"+" withString:@""];
        NSString * string5 = [string4 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString * string6 = [string5 stringByReplacingOccurrencesOfString:@"slnc" withString:@""];
        
        NSString * strippedNumber0 = [string6 stringByReplacingOccurrencesOfString:@"0" withString:@""];
        NSString * strippedNumber1 = [strippedNumber0 stringByReplacingOccurrencesOfString:@"1" withString:@""];
        NSString * strippedNumber2 = [strippedNumber1 stringByReplacingOccurrencesOfString:@"2" withString:@""];
        NSString * strippedNumber3 = [strippedNumber2 stringByReplacingOccurrencesOfString:@"3" withString:@""];
        NSString * strippedNumber4 = [strippedNumber3 stringByReplacingOccurrencesOfString:@"4" withString:@""];
        NSString * strippedNumber5 = [strippedNumber4 stringByReplacingOccurrencesOfString:@"5" withString:@""];
        NSString * strippedNumber6 = [strippedNumber5 stringByReplacingOccurrencesOfString:@"6" withString:@""];
        NSString * strippedNumber7 = [strippedNumber6 stringByReplacingOccurrencesOfString:@"7" withString:@""];
        NSString * strippedNumber8 = [strippedNumber7 stringByReplacingOccurrencesOfString:@"8" withString:@""];
        NSString * strippedNumber9 = [strippedNumber8 stringByReplacingOccurrencesOfString:@"9" withString:@""];
        
        finalString = strippedNumber9;
    }
    
    return finalString;
}

- (void) notifyDoneReading
{    
    NSNumber * doneReadingObject = [NSNumber numberWithBool:self.doneReading];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckForDemoReplay" object:doneReadingObject];
}



- (void) keepSpeaking
{
    //need to repeat this here for speech to be updated properly
    //text requires updates earlier
    [self selectMessageFromGroup:self.dialogueGroupName
                         atIndex:self.dialogueArrayIndex];
    
    if (!self.synth.isSpeaking) {
        
        [self.synth startSpeakingString:self.textLine];
    }
}


- (void) speak
{    
    int maxElementCount = [self.taskDemoMessages count];

    
    if (self.dialogueArrayIndex >= 0 && self.dialogueArrayIndex < maxElementCount) {
        [self keepSpeaking];
        self.doneReading = NO;
    }
    else if (self.dialogueArrayIndex >= maxElementCount) {
        self.doneReading = YES;
        [self notifyDoneReading];

    }


}


- (void) updateTextWithString:(NSString *)rawString
{
    if (rawString != nil) {  

        self.textLineCleaned = [self makeCleanStringFrom:rawString];

        NSMutableAttributedString * outString;
        NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
        
        //get an erro if increase textsize
        [attrs setObject: [NSFont fontWithName: @"Helvetica-Bold" size: 16.0f] forKey: NSFontAttributeName];
        [attrs setObject: [NSColor whiteColor] forKey: NSForegroundColorAttributeName];
        
        outString = [[[NSMutableAttributedString alloc] initWithString:self.textLineCleaned attributes:attrs] autorelease];
        
        self.sdText = [[[StringDisplay alloc] initWithAttributedString:outString withTextColor:[NSColor colorWithDeviceRed:self.textOpacity green:self.textOpacity blue:self.textOpacity alpha:self.textOpacity] withBoxColor:[NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:.8f] withBorderColor:[NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.0f alpha:0.0f]] autorelease];
    }
}


-(void)updatePosition
{
    if (![self.dialogueGroupName isEqualToString: @"demoPostVisual"] &&
        ![self.dialogueGroupName isEqualToString:@"demoPostVisualWithLift"] &&
        ![self.dialogueGroupName isEqualToString:@"demoLevel2Visual"]) {
        
        self.textTransZ = 6100;

        if ([self.dialogueGroupName isEqualToString: @"startUp"] ||
            [self.dialogueGroupName isEqualToString: @"sessionDone"] ||
            [self.dialogueGroupName isEqualToString:@"markerLost"]) {
            
            self.textTransY = 0.0;
        }
        else if ([self.dialogueGroupName isEqualToString: @"cone"]) {

            self.textTransY = -106.0;
        }
        else {
            self.textTransY = -30.0;

        }
    }
    else if ([self.dialogueGroupName isEqualToString: @"demoPostVisual"] ||
             [self.dialogueGroupName isEqualToString:@"demoPostVisualWithLift"]) {
        self.textTransY = -2000;
        self.textTransZ = 6000;

    }
    else{
        self.textTransZ = 7400;
        self.textTransY = -106.0;
    }

}

- (void)drawText
{
    [self updateTextWithString:self.textLine];

    glDisable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glDisable( GL_LIGHTING );

    [self updatePosition];
    
        NSSize frame = [self.sdText frameSize];
        float xPos = -frame.width/2.0 + self.textTransX;
        float yPos = -frame.height/2.0 + self.textTransY;
        float zPos = self.textTransZ;
        
        Vector3f * textPosition3d = [Vector3f createX:xPos Y:yPos Z:zPos];
        
        [self.sdText drawAtPoint3d:textPosition3d];
    
}


- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking 
{
  //      [sender autorelease]; //- can't call this if you need to reuse object - potential memory issue?

//        NSLog(@"Line %i finished speaking", self.dialogueArrayIndex);
    
        self.dialogueArrayIndex++;
        
        if (self.playWristPadSound) {
        
            if (self.dialogueArrayIndex == 3) {
                
                [self.soundController playWristPadSound];
            }
        }

    [self speak];

}




@end

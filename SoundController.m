//
//  SoundController.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundController.h"

@implementation SoundController
@synthesize wristPadSoundPlayer = _wristPadSoundPlayer;
@synthesize chair = _chair;
@synthesize marker = _marker;
@synthesize startUp = _startUp;
@synthesize playerObjectsDictionary = _playerObjectsDictionary;
@synthesize movieFileLookupDictionary = _movieFileLookupDictionary;

- (id)init
{
	self = [super init];
 
 
    
    if (self) {
        
        NSLog(@"soundcontroller was created");
        
//        [self createPlayerObjectsDictionary];


    }
	return self;
}

-(AVAudioPlayer *)createPlayerObjectFromFileName:(NSString *)filename
{
    NSString * resourcesPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    NSURL* file = [NSURL URLWithString:[[resourcesPath stringByAppendingPathComponent:@"/sounds/audioTaskID/"] stringByAppendingPathComponent:filename]];
    
    AVAudioPlayer * playerObject = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];

    return playerObject;
}

- (void) createPlayerObjectsDictionary
{
	self.movieFileLookupDictionary = [NSDictionary dictionaryWithContentsOfFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent: @"/InstructionsMovieFileLookup.plist"]];
    
   NSDictionary * instructionDictionary = [NSDictionary dictionaryWithContentsOfFile:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent: @"/Instructions.plist"]];
    
	if (self.movieFileLookupDictionary == nil) {
		NSLog( @"movieFileLookupDictionary is nil");
    }
    else {
    	NSLog( @"loaded %lu componenets from movieFileLookupDictionary", [self.movieFileLookupDictionary count]);

        self.playerObjectsDictionary = [NSMutableDictionary dictionaryWithCapacity:[self.movieFileLookupDictionary count]];
        
        for(id key in self.movieFileLookupDictionary) {
            
            NSString * textDisplay = [instructionDictionary valueForKey:key];
            
            if ([textDisplay isEqualToString:@"movie"]) {
                NSLog(@"don't create audio player");
            }
            else{
                NSString * stringVal = [self.movieFileLookupDictionary objectForKey:key];
                
                [self.playerObjectsDictionary setObject:[self createPlayerObjectFromFileName:stringVal] forKey:key];
                
                [[self.playerObjectsDictionary objectForKey:key] prepareToPlay];

            }
        }
    }
}


-(void)playDemoSpeechWith:(AVAudioPlayer *)player
{
    if ([player isPlaying]) {
        [player pause];
    } else {
        [player play];
    }
}

-(void)updateDemoSpeechWithName:(NSString *)name
{
    if ([name isEqualToString:@"startUp"]) {
        [self playDemoSpeechWith:self.startUp];
    }
    if ([name isEqualToString:@"marker"]) {
        [self playDemoSpeechWith:self.marker];
    }
    if ([name isEqualToString:@"chair"]) {
        [self playDemoSpeechWith:self.chair];
    }
}

- (void) playWristPadSound
{    
        
        if ([self.wristPadSoundPlayer isPlaying]) {
            
            [self.wristPadSoundPlayer pause];
        } else {
            
            [self.wristPadSoundPlayer play];
        }
//        NSLog(@"play wrist pad sound");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"successful completion of playback");
    }

}

@end

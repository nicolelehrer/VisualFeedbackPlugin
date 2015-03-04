//
//  SoundController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 9/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundController : NSObject<AVAudioPlayerDelegate>

@property(assign) AVAudioPlayer* wristPadSoundPlayer;

@property(assign) AVAudioPlayer* startUp;
@property(assign) AVAudioPlayer* chair;
@property(assign) AVAudioPlayer* marker;


@property(retain) NSMutableDictionary* playerObjectsDictionary;
@property(retain) NSDictionary * movieFileLookupDictionary;



-(void) playWristPadSound;
-(void) updateDemoSpeechWithName:(NSString *)name;

@end


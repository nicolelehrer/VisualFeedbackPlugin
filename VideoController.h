//
//  VideoController.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 2/7/13.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoController : NSObject<AVAudioPlayerDelegate>

@property(assign) AVAudioPlayer* chair;

@property(retain) NSMutableDictionary* playerObjectsDictionary;
@property(retain) NSDictionary * movieFileLookupDictionary;
@property (assign) BOOL videoIsPlaying;

-(void)updateMediaWithID:(NSString *)instructionID;

@end


//
//  UnderwaterObjects.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/30/12.
//
//


#import "Transform.h"

#import <Foundation/Foundation.h>
#import "DashHeaders.h"
#import "WaterSheet.h"

@interface UnderwaterObjects : NSObject

@property(retain) WaterSheet * waterSheet;
@property(retain) DTime * timekeeper;
@end

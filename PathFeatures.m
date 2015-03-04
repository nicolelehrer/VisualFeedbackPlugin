//
//  PathFeatures.m
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/24/12.
//
//

#import "PathFeatures.h"

@implementation PathFeatures

@synthesize positiveHorizontalMagnitude = _positiveHorizontalMagnitude;
@synthesize negativeHorizontalMagnitude = _negativeHorizontalMagnitude;
@synthesize positiveVerticalMagnitude = _positiveVerticalMagnitude;
@synthesize negativeVerticalMagnitude = _negativeVerticalMagnitude;

@synthesize positiveHorizontalCategory = _positiveHorizontalCategory;
@synthesize negativeHorizontalCategory = _negativeHorizontalCategory;
@synthesize positiveVerticalCategory = _positiveVerticalCategory;
@synthesize negativeVerticalCategory = _negativeVerticalCategory;

@synthesize horizontalComponentForPositiveVertical = _horizontalComponentForPositiveVertical;
@synthesize horizontalComponentForNegativeVertical = _horizontalComponentForNegativeVertical;


- (id)init
{
	self = [super init];
    if (self != nil) {
        
    }
	return self;
}

@end

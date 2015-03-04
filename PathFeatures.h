//
//  PathFeatures.h
//  VisualFeedback
//
//  Created by Nicole Lehrer on 10/24/12.
//
//

#import <Foundation/Foundation.h>

@interface PathFeatures : NSObject

@property(assign) float positiveHorizontalMagnitude;
@property(assign) float negativeHorizontalMagnitude;
@property(assign) float positiveVerticalMagnitude;
@property(assign) float negativeVerticalMagnitude;
@property(assign) float positiveHorizontalCategory;
@property(assign) float negativeHorizontalCategory;
@property(assign) float positiveVerticalCategory;
@property(assign) float negativeVerticalCategory;
@property(assign) float horizontalComponentForPositiveVertical;
@property(assign) float horizontalComponentForNegativeVertical;


- (id)init;

@end

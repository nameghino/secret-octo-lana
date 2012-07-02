//
//  UIColor+SnapAdditions.m
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "UIColor+SnapAdditions.h"

@implementation UIColor (SnapAdditions)

#define V2P(A) ((float)A/255.0f)

+(UIColor *)snapTextColor {
	return [UIColor colorWithValuesForRed:116
									green:192
									 blue:97 
									alpha:1.0f];
}

+(UIColor*) colorWithValuesForRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:V2P(red)
						   green:V2P(green) 
							blue:V2P(blue) 
						   alpha:alpha];
}

@end

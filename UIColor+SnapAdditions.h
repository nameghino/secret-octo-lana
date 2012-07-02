//
//  UIColor+SnapAdditions.h
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SnapAdditions)

+(UIColor*) snapTextColor;
+(UIColor*) colorWithValuesForRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha;
@end

//
//  NHelper.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 04.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHelper : NSObject

+ (CGFloat)gramsToPounds:(CGFloat)grams;
+ (CGFloat)poundsToGrams:(CGFloat)pounds;

+ (NSDate *)dateFromISOString:(NSString *)isoString;
+ (NSString *)isoStringFromDate:(NSDate *)date;
+ (NSString *)postRequestStringFromDate:(NSDate *)date;
+ (NSString *)monthDayStringFromDate:(NSDate *)date;
+ (NSString *)dayMonthStringFromDate:(NSDate *)date;

+ (NSArray *)sortWeightArrayByDate:(NSArray *)weights;

@end

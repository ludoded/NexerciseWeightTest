//
//  NHelper.m
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 04.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import "NHelper.h"
#import "NWeight.h"

CGFloat kGramsInPound = 453.592;

@implementation NHelper

#pragma mark - Weight Metric Converting

+ (CGFloat)gramsToPounds:(CGFloat)grams
{
    return grams / kGramsInPound;
}

+ (CGFloat)poundsToGrams:(CGFloat)pounds
{
    return pounds * kGramsInPound;
}

#pragma mark - String/Date Converting

+ (NSString *)isoStringFromDate:(NSDate *)date
{
    return [[self formatter:@"yyyy-MM-dd'T'HH:mm:ss'Z'"] stringFromDate:date];
}

+ (NSString *)postRequestStringFromDate:(NSDate *)date
{
    return [[self formatter:@"MM/dd/yyyy"] stringFromDate:date];
}

+ (NSString *)monthDayStringFromDate:(NSDate *)date
{
    return [[self formatter:@"MMMM dd"] stringFromDate:date];
}

+ (NSString *)dayMonthStringFromDate:(NSDate *)date
{
    return [[self formatter:@"dd,MMM"] stringFromDate:date];
}

+ (NSDate *)dateFromISOString:(NSString *)isoString
{
    return [[self formatter:@"yyyy-MM-dd'T'HH:mm:ss'Z'"] dateFromString:isoString];
}

+ (NSDateFormatter *)formatter:(NSString *)format
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return dateFormatter;
}

#pragma mark - Sorting

+ (NSArray *)sortWeightArrayByDate:(NSArray *)weights
{
    NSArray * sortedWeights = [weights sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NWeight *w1 = obj1;
        NWeight *w2 = obj2;
        
        return [[self dateFromISOString:w1.recordedDate] compare:[self dateFromISOString:w2.recordedDate]];
    }];
    return sortedWeights;
}

@end

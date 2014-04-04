//
//  NNetwrokingManager.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@class NWeight, NWeightHistory;

@interface NNetwrokingManager : AFHTTPSessionManager

+ (NNetwrokingManager *)sharedManager;

- (void)getWeightWithId:(NSString *)idStr startDate:(NSString *)startDate endDate:(NSString *)endDate andCompletion:(void (^)(NWeight *weight))completion;
- (void)getWeightWithCompletion:(void (^)(NWeightHistory *weightHistory))completion;

- (void)postRecordedDate:(NSString *)recordedDate grams:(NSNumber *)grams offset:(NSNumber *)offset completion:(void (^)(NSError *error))completion;

@end

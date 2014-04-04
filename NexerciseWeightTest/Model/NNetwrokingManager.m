//
//  NNetwrokingManager.m
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import "NNetwrokingManager.h"

#import "NWeightHistory.h"
#import "NWeight.h"

#import "NHTTPPutRequestSerializer.h"

static NSString * kBaseURL = @"https://apitest.nexercise.com/";
static NSString * kPath = @"/v1/weight";

static NSString * kUserID = @"ab557029-ed76-4ceb-b883-a5b055c39856";

static NSString * kUserName = @"testTemp";
static NSString * kPassword = @"xB:QJyB24;6[$6Zn";

@implementation NNetwrokingManager

+ (NNetwrokingManager *)sharedManager {
    static NNetwrokingManager *sharedNetManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * baseURL = [NSURL URLWithString:kBaseURL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"userID" : kUserID}];
        
        sharedNetManager = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        sharedNetManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sharedNetManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sharedNetManager.requestSerializer setAuthorizationHeaderFieldWithUsername:kUserName password:kPassword];
    });
    return sharedNetManager;
}

- (void)getWeightWithCompletion:(void (^)(NWeightHistory *))completion
{
    [[NNetwrokingManager sharedManager] GET:kPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"GET responseObj : %@", responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            completion([self serializeWeightHistory:(NSDictionary *)responseObject]);
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail %@", error.description);
    }];
}

- (void)getWeightWithId:(NSString *)idStr startDate:(NSString *)startDate endDate:(NSString *)endDate andCompletion:(void (^)(NWeight *))completion
{
    NSMutableDictionary * params = [@{} mutableCopy];
    if (![idStr isEqualToString:@""]) {
        [params setValue:idStr forKey:@"id"];
        if (![startDate isEqualToString:@""])
            [params setValue:startDate forKey:@"startDate"];
        if (![endDate isEqualToString:@""])
            [params setValue:endDate forKey:@"endDate"];
    }
    
    [[NNetwrokingManager sharedManager] GET:kPath parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObj : %@", responseObject);
        completion([self serializeWeight:(NSDictionary *)responseObject[@"weight"]]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail %@", error.description);
    }];
}

- (void)postRecordedDate:(NSString *)recordedDate grams:(NSNumber *)grams offset:(NSNumber *)offset completion:(void (^)(NSError *))completion
{
    NSLog(@"Header %@", [NNetwrokingManager sharedManager].session.configuration.HTTPAdditionalHeaders);
    NSLog(@"recordedDate: %@", recordedDate);
    NSLog(@"grams: %@", grams);
    [[NNetwrokingManager sharedManager] POST:kPath parameters:@{@"grams" : grams, @"recordedDate" : recordedDate} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"RESPONSE POST: %@", responseObject);
        completion(nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"FAIL PUT: %@", error.description);
        completion(error);
    }];
}

- (NWeightHistory *)serializeWeightHistory:(NSDictionary *)dict
{
    NWeightHistory * weightHistory = [[NWeightHistory alloc] init];
    weightHistory.endDate = dict[@"endDate"];
    weightHistory.startDate = dict[@"startDate"];
    NSMutableArray * resArr = [@[] mutableCopy];
    NSArray * arrWeightHistory = dict[@"weightHistory"];
    for (int i = 0; i < arrWeightHistory.count; i++)
        [resArr addObject:[self serializeWeight:arrWeightHistory[i][@"weight"]]];
    weightHistory.weights = [NSArray arrayWithArray:resArr];
    return weightHistory;
}

- (NWeight *)serializeWeight:(NSDictionary *)dict
{
    NWeight * weight = [[NWeight alloc] init];
    weight.recordedDate = dict[@"recordedDate"];
    weight.weightId = dict[@"weightId"];
    weight.offset = [dict[@"offset"] floatValue];
    weight.weightInGrams = [dict[@"weightInGrams"] floatValue];
    weight.weightInPounds = [dict[@"weightInPounds"] floatValue];
    return weight;
}

@end

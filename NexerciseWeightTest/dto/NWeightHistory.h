//
//  NWeightHistory.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWeightHistory : NSObject

@property (nonatomic, strong) NSArray * weights; // NSArray of NWeight objects;
@property (nonatomic, copy) NSString * endDate;
@property (nonatomic, copy) NSString * startDate;

@end

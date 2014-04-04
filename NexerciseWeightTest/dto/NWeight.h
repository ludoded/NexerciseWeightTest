//
//  NWeight.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWeight : NSObject

@property (nonatomic, copy) NSString * weightId;
@property (nonatomic, copy) NSString * recordedDate;
@property (nonatomic, assign) CGFloat weightInPounds;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat weightInGrams;

@end

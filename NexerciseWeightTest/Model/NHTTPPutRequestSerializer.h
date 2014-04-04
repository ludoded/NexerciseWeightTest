//
//  NHTTPPutResponseSerializer.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import "AFURLRequestSerialization.h"

@interface NHTTPPutRequestSerializer : AFHTTPRequestSerializer

@property (nonatomic, copy) NSString * body;

@end

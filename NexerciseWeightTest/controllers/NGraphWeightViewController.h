//
//  NGraphWeightViewController.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BEMSimpleLineGraphView.h"

@interface NGraphWeightViewController : UIViewController <BEMSimpleLineGraphDelegate>
@property (strong, nonatomic) IBOutlet BEMSimpleLineGraphView *lineGraphView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedButton;
@property (strong, nonatomic) IBOutlet UILabel *poundsLabel;

- (IBAction)timeRange:(UISegmentedControl *)sender;
@end

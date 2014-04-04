//
//  NLogWeightViewController.h
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNetwrokingManager.h"

@interface NLogWeightViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)submit:(UIButton *)sender;
- (IBAction)weightMetric:(UIButton *)sender;

@end

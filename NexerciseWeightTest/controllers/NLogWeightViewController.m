//
//  NLogWeightViewController.m
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import "NLogWeightViewController.h"

#import "NWeight.h"
#import "NWeightHistory.h"

#import "NHelper.h"

@interface NLogWeightViewController () {
    BOOL _pounds;
}

@end

@implementation NLogWeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)testCalls
{
    [[NNetwrokingManager sharedManager] getWeightWithCompletion:^(NWeightHistory *weightHistory) {
        NSLog(@"completion %f", ((NWeight *)weightHistory.weights[1]).offset);
    }];
    [[NNetwrokingManager sharedManager] getWeightWithId:@"1d1caa1d-9e79-4d71-b4ca-545a4fd2d29d" startDate:@"" endDate:@"" andCompletion:^(NWeight *weight) {
        NSLog(@"completion weight offset %f", weight.offset);
    }];
    
    [[NNetwrokingManager sharedManager] postRecordedDate:@"03/24/2013" grams:@(55940) offset:@(0) completion:^(NSError *error) {
        NSLog(@"ASAS");
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pounds = YES;
    
    [[NNetwrokingManager sharedManager] getWeightWithCompletion:^(NWeightHistory *weightHistory) {
        NWeight * recentWeight = [self mostRecentWeight:weightHistory];
        _infoLabel.text = [NSString stringWithFormat:@"You last weighed %.01f Pounds on %@", recentWeight.weightInPounds, [NHelper monthDayStringFromDate:[NHelper dateFromISOString:recentWeight.recordedDate]]];
    }];
    
    [_textField becomeFirstResponder];
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NWeight *)mostRecentWeight:(NWeightHistory *)weightHistory
{
    NSArray *sortedWeights;
    sortedWeights = [NHelper sortWeightArrayByDate:weightHistory.weights];
    
    return sortedWeights.lastObject;
}

#pragma mark - Actions

- (IBAction)submit:(UIButton *)sender {
    CGFloat logWeight = _textField.text.floatValue;
    if (_pounds)
        logWeight = [NHelper poundsToGrams:logWeight];
    NSString * date = [NHelper postRequestStringFromDate:[NSDate date]];
    
    [[NNetwrokingManager sharedManager] postRecordedDate:date grams:@((int)logWeight) offset:@(0) completion:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:(!error) ? @"Succes!" : @"Fail!"
                                    message:(!error) ? @"New Log Added" : [NSString stringWithFormat:@"Error: %@", error.description]
                                   delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }];
}

- (IBAction)weightMetric:(UIButton *)sender {
    [sender setTitle:(_pounds) ? @"Grams" : @"Pounds" forState:UIControlStateNormal];
    _pounds = !_pounds;
}
@end

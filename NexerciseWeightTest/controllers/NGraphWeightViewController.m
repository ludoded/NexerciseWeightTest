//
//  NGraphWeightViewController.m
//  NexerciseWeightTest
//
//  Created by Aik Ampardjian on 03.04.14.
//  Copyright (c) 2014 Boomie. All rights reserved.
//

#import "NGraphWeightViewController.h"

#import "NNetwrokingManager.h"
#import "NHelper.h"

#import "NWeight.h"
#import "NWeightHistory.h"

@interface NGraphWeightViewController () {
    NSArray *  _weights;
}

@end

@implementation NGraphWeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _weights = @[];
    _lineGraphView.colorTop = [UIColor orangeColor];
    _lineGraphView.alphaTop = 1.0f;
    _lineGraphView.colorBottom = [UIColor orangeColor];
    _lineGraphView.alphaBottom = 1.0f;
    _lineGraphView.colorLine = [UIColor whiteColor];
    _lineGraphView.alphaLine = 1.0f;
    _lineGraphView.widthLine = 2.0f;
    _lineGraphView.colorXaxisLabel = [UIColor darkGrayColor];
    _lineGraphView.enableTouchReport = YES;
    _lineGraphView.labelFont = [UIFont systemFontOfSize:12];
    // Do any additional setup after loading the view.
    [[NNetwrokingManager sharedManager] getWeightWithCompletion:^(NWeightHistory *weightHistory) {
        _weights = [NHelper sortWeightArrayByDate:weightHistory.weights];
        [_lineGraphView reloadGraph];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BEMSimpleLineGraphDelegate

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    return _weights.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    NWeight *w = _weights[index];
    return w.weightInGrams;
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index
{
    NWeight *w = _weights[index];
    _poundsLabel.text = [NSString stringWithFormat:@"%.0f Pounds", w.weightInPounds];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _poundsLabel.alpha = 0.0;
    } completion:^(BOOL finished){
        
        _poundsLabel.text = @"";
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _poundsLabel.alpha = 1.0;
        } completion:nil];
    }];
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 0;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index
{
    if (_weights.count > 0) {
        NWeight *w = _weights[index];
        return [NHelper dayMonthStringFromDate:[NHelper dateFromISOString:w.recordedDate]];
    } else {
        return @"";
    }
}

#pragma mark - Actions

- (IBAction)timeRange:(UISegmentedControl *)sender {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
}
@end

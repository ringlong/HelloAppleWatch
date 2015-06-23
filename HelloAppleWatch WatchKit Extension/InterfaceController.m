//
//  InterfaceController.m
//  HelloAppleWatch WatchKit Extension
//
//  Created by Ryan on 15/6/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "InterfaceController.h"
#import "MeatTemperature.h"

@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceTimer *timer;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *weightLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *cookLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *timerButton;

@property (assign, nonatomic) NSTimeInterval countdown;
@property (assign, nonatomic) NSInteger ounces;
@property (strong, nonatomic) MeatTemperature *cookTemp;
@property (assign, nonatomic) BOOL timerRunning;
@property (assign, nonatomic) BOOL usingMetric;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _countdown = 20;
    _ounces = 16;
    _timerRunning = FALSE;
    _usingMetric = FALSE;
    [_timer setDate:[NSDate dateWithTimeIntervalSinceNow:_countdown]];
    _cookTemp = [[MeatTemperature alloc] initWithRawValue:Medium];
    [self updateConfiguration];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)updateConfiguration {
    NSInteger weight = _ounces;
    NSString *unit = @"oz";
    if (_usingMetric) {
        CGFloat grams = _ounces * 28.3495;
        weight = (NSInteger)grams;
        unit = @"gm";
    }
    [_weightLabel setText:[NSString stringWithFormat:@"Weight: %@%@", @(weight), unit]];
    [_cookLabel setText:_cookTemp.stringValue];
}

- (IBAction)onTimerButton {
    if (_timerRunning) {
        [_timer stop];
        [_timerButton setTitle:@"Start Timer"];
    } else {
        NSTimeInterval time = [self cookTimeForOunces:_ounces temperature:_cookTemp];
        [_timer setDate:[NSDate dateWithTimeIntervalSinceNow:time]];
        [_timer start];
        [_timerButton setTitle:@"Stop Timer"];
    }
    _timerRunning = !_timerRunning;
}

- (IBAction)onMinusButton {
    _ounces--;
    [self updateConfiguration];
}

- (IBAction)onPlusButton {
    _ounces++;
    [self updateConfiguration];
}

- (IBAction)onTempChange:(float)value {
    [_cookTemp setMeetTempWithRawValue:value];
    [self updateConfiguration];
}

- (IBAction)onMetricChanged:(BOOL)value {
    _usingMetric = value;
    [self updateConfiguration];
}

- (NSTimeInterval)cookTimeForOunces:(NSInteger)ounces temperature:(MeatTemperature *)cookTemp {
    NSTimeInterval baseTime = 47 * 60;
    CGFloat baseWeight = 16.;
    CGFloat weightModifier = ounces / baseWeight;
    NSTimeInterval timeModifier = cookTemp.timeModifier;
    return baseTime * weightModifier * timeModifier;
}

@end




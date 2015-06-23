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

@property (assign, nonatomic) NSTimeInterval countdown;
@property (assign, nonatomic) NSInteger ounces;
@property (strong, nonatomic) MeatTemperature *cookTemp;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _countdown = 20;
    _ounces = 16;
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
    [_weightLabel setText:[NSString stringWithFormat:@"Weight: %@oz", @(_ounces)]];
    [_cookLabel setText:_cookTemp.stringValue];
}

- (IBAction)onTimerButton {
    [_timer start];
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
@end




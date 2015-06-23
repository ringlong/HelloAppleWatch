//
//  MeatTemperature.m
//  HelloAppleWatch
//
//  Created by Ryan on 15/6/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "MeatTemperature.h"

@implementation MeatTemperature

- (instancetype)initWithRawValue:(NSInteger)rawValue {
    if (self = [super init]) {
        _rawValue = rawValue;
        _stringValue = @[@"Rare", @"Medium Rare", @"Medium", @"WellDone"][_rawValue];
        _timeModifier = [@[@0.5, @0.75, @1.0, @1.5][_rawValue] floatValue];
    }
    return self;
}

- (void)setMeetTempWithRawValue:(NSInteger)rawValue {
    self.rawValue = rawValue;
    _stringValue = @[@"Rare", @"Medium Rare", @"Medium", @"WellDone"][_rawValue];
    _timeModifier = [@[@0.5, @0.75, @1.0, @1.5][_rawValue] floatValue];
}

@end

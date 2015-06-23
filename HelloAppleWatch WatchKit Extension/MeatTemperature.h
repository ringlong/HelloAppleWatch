//
//  MeatTemperature.h
//  HelloAppleWatch
//
//  Created by Ryan on 15/6/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MeatTemp) {
    Rare = 0,
    MediumRare,
    Medium,
    WellDone
};

@interface MeatTemperature : NSObject

@property (nonatomic, assign) NSInteger rawValue;

@property (nonatomic, assign) NSTimeInterval timeModifier;
@property (nonatomic, copy) NSString *stringValue;

- (instancetype)initWithRawValue:(NSInteger)rawValue;

- (void)setMeetTempWithRawValue:(NSInteger)rawValue;

@end

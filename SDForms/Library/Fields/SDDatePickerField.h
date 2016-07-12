//
//  SDDatePickerFormField.h
//  SDForms
//
//  Created by Rafal Kwiatkowski on 18.08.2014.
//  Copyright (c) 2014 Snowdog sp. z o.o. All rights reserved.
//

#import "SDFormField.h"

@interface SDDatePickerField : SDFormField

@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) NSString *dateFormat;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic) UIDatePickerMode datePickerMode;

@end

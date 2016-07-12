//
//  SDTextFormField.h
//  SDForms
//
//  Created by Rafal Kwiatkowski on 13.08.2014.
//  Copyright (c) 2014 Snowdog sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDFormField.h"

typedef enum {SDTextFormFieldCellTypeTextOnly, SDTextFormFieldCellTypeTextAndLabel, SDTextFormFieldCellTypeIconAndText} SDTextFormFieldCellType;

@interface SDTextFormField : SDFormField

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *enabledIconColor;
@property (nonatomic, strong) UIColor *disabledIconColor;
@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic) UITextAutocorrectionType autocorrectionType;
@property (nonatomic) BOOL secure;
@property (nonatomic) BOOL enabled;
@property (nonatomic) SDTextFormFieldCellType cellType;

@end

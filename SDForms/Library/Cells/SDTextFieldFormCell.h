//
//  SDTextFieldCell.h
//  SDForms
//
//  Created by Rafal Kwiatkowski on 18.08.2014.
//  Copyright (c) 2014 Snowdog sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDFormCell.h"
#import "SDTextFieldView.h"

static NSString * const kTextFieldCell = @"SDTextFieldFormCell";

@interface SDTextFieldFormCell : SDFormCell <SDTextFieldDelegate>

@property (weak, nonatomic) IBOutlet SDTextFieldView *textField;
@property (nonatomic) BOOL enabled;

@end

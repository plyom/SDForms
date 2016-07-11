//
//  SDTextFormField.m
//  SDForms
//
//  Created by Rafal Kwiatkowski on 13.08.2014.
//  Copyright (c) 2014 Snowdog sp. z o.o. All rights reserved.
//

#import "SDTextFormField.h"
#import "SDTextFieldFormCell.h"
#import "SDTextFieldWithLabelFormCell.h"
#import "SDTextFieldWithIconFormCell.h"

@implementation SDTextFormField 

- (id)init
{
    self = [super init];
    if (self) {
        self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.secure = NO;
        self.enabled = YES;
        self.cellType = SDTextFormFieldCellTypeTextOnly;
        self.textColor = [UIColor blackColor];
        self.enabledIconColor = [UIColor blackColor];
        self.disabledIconColor = [UIColor blackColor];
    }
    return self;
}

- (NSArray *)reuseIdentifiers {
    NSString *cellId;
    if (self.cellType == SDTextFormFieldCellTypeTextOnly) {
        cellId = kTextFieldCell;
    } else if (self.cellType == SDTextFormFieldCellTypeTextAndLabel) {
        cellId = kTextFieldWithLabelCell;
    } else if (self.cellType == SDTextFormFieldCellTypeIconAndText) {
        cellId = kTextFieldWithIconCell;
    } else {
        cellId = kTextFieldCell;
    }
    
   return @[cellId];
}

- (SDFormCell *)cellForTableView:(UITableView *)tableView atIndex:(NSUInteger)index
{
    SDFormCell *cell = [super cellForTableView:tableView atIndex:index];
    
    if ([cell isKindOfClass:[SDTextFieldFormCell class]]) {
        SDTextFieldFormCell *textFieldCell = (SDTextFieldFormCell *)cell;
        
        if (self.valueType == SDFormFieldValueTypeText) {
            textFieldCell.textField.keyboardType = UIKeyboardTypeDefault;
            textFieldCell.textField.text = self.value;
        } else {
            if (self.valueType == SDFormFieldValueTypeDouble) {
                textFieldCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            } else if (self.valueType == SDFormFieldValueTypeInt) {
                textFieldCell.textField.keyboardType = UIKeyboardTypeNumberPad;
            } else {
                textFieldCell.textField.keyboardType = UIKeyboardTypeDefault;
            }
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setPositiveFormat:@"####.##"];
            textFieldCell.textField.text = [formatter stringFromNumber:self.value];
        }
        
        if ([cell isKindOfClass:[SDTextFieldWithLabelFormCell class]]) {
            SDTextFieldWithLabelFormCell *tfWithLabelCell = (SDTextFieldWithLabelFormCell *)cell;
            tfWithLabelCell.titleLabel.text = self.title;
        }
        
        
        if ([cell isKindOfClass:[SDTextFieldWithIconFormCell class]]) {
            SDTextFieldWithIconFormCell *tfWithIconCell = (SDTextFieldWithIconFormCell *)cell;
            UIImage *newImage = [self.icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            if ([textFieldCell.textField.text length] > 0) {
                tfWithIconCell.iconView.tintColor = self.enabledIconColor;
            }else {
                tfWithIconCell.iconView.tintColor = self.disabledIconColor;
            }
            tfWithIconCell.iconView.image = newImage;
        }
        
        textFieldCell.enabled = self.enabled;
        textFieldCell.textField.textColor = self.textColor;
        textFieldCell.textField.placeholder = self.placeholder;
        textFieldCell.textField.autocapitalizationType = self.autocapitalizationType;
        textFieldCell.textField.autocorrectionType = self.autocorrectionType;
        textFieldCell.textField.secureTextEntry = self.secure;
    }
    
    return cell;
}


@end

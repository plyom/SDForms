//
//  SDTextFieldCell.m
//  SDForms
//
//  Created by Rafal Kwiatkowski on 18.08.2014.
//  Copyright (c) 2014 Snowdog sp. z o.o. All rights reserved.
//

#import "SDTextFieldFormCell.h"

@implementation SDTextFieldFormCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.responders = @[self.textField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - SDTextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputAccessoryViewForCell:)]) {
        textField.inputAccessoryView = [self.delegate inputAccessoryViewForCell:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(formCell:didActivateResponder:)]) {
        [self.delegate formCell:self didActivateResponder:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setFieldValueFromTextField:textField withCellRefresh:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(formCell:didDeactivateResponder:)]) {
        [self.delegate formCell:self didDeactivateResponder:textField];
    }
}

- (void)textFieldDidChange:(SDTextFieldView *)textField
{
    [self setFieldValueFromTextField:textField withCellRefresh:NO];
}

- (void)setFieldValueFromTextField:(UITextField *)textField withCellRefresh:(BOOL)refresh
{
    if (self.field.valueType == SDFormFieldValueTypeText || self.field.valueType ==  SDFormFieldValueTypeNumberText) {
        [self.field setValue:textField.text withCellRefresh:refresh];
    } else if (self.field.valueType == SDFormFieldValueTypeDouble || self.field.valueType == SDFormFieldValueTypeInt) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [self.field setValue:[formatter numberFromString:textField.text] withCellRefresh:refresh];
    } else if (self.field.valueType == SDFormFieldValueTypeCep) {
        textField.text = [[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                          componentsJoinedByString:@""];
        if ([textField.text length] > 7) {
            NSString *formattedText = [NSString stringWithFormat:@"%@-%@",
            [textField.text substringWithRange:NSMakeRange(0, 5)],
            [textField.text substringWithRange:NSMakeRange(5, 3)]];
            [self.field setValue:formattedText withCellRefresh:refresh];
        } else {
            [self.field setValue:textField.text withCellRefresh:refresh];
        }
    } else if (self.field.valueType ==  SDFormFieldValueTypePhone) {
        textField.text = [[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                          componentsJoinedByString:@""];
        if ([textField.text length] > 9) {
            NSString *formattedText = [NSString stringWithFormat:@"(%@)%@-%@",
            [textField.text substringWithRange:NSMakeRange(0, 2)],
            [textField.text substringWithRange:NSMakeRange(2, 4)],
            [textField.text substringWithRange:NSMakeRange(4, [textField.text length] - 6)]];
            [self.field setValue:formattedText withCellRefresh:refresh];
        } else {
            [self.field setValue:textField.text withCellRefresh:refresh];
        }
    }
}

- (void)setField:(SDFormField *)field
{
    [super setField:field];
}

- (void)setEnabled:(BOOL)enabled
{
    self.textField.enabled = enabled;
    if (enabled) {
        self.responders = @[self.textField];
    } else {
        self.responders = nil;
    }
}

- (BOOL)enabled
{
    return self.textField.enabled;
}

@end

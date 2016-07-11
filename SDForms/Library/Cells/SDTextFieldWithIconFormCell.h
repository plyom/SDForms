//
//  SDTextFieldWithIconFormCell.h
//  SDForms
//
//  Created by Fernando Pileggi on 7/9/16.
//  Copyright © 2016 Snowdog sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDTextFieldView.h"
#import "SDTextFieldFormCell.h"

static NSString * const kTextFieldWithIconCell = @"SDTextFieldWithIconFormCell";

@interface SDTextFieldWithIconFormCell : SDTextFieldFormCell

@property (weak, nonatomic) IBOutlet SDTextFieldView *textField;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end

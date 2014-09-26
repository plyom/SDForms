//
//  SDFormField.m
//  SDForms
//
//  Created by Rafal Kwiatkowski on 13.08.2014.
//  Copyright (c) 2014 Snowdog sp. z o.o. All rights reserved.
//

#import "SDFormField.h"
#import "SDFormCell.h"

@implementation SDFormField


- (id)initWithObject:(id)object relatedPropertyKey:(NSString *)key
{
    self = [self init];
    if (self) {
        self.relatedObject = object;
        self.relatedPropertyKey = key;
        
        [self setValueBasedOnRelatedObjectProperty];
    }
    return self;
}

- (id)initWithObject:(id)object relatedPropertyKey:(NSString *)key formattedValueKey:(NSString *)formattedKey
{
    self = [self initWithObject:object relatedPropertyKey:key];
    if (self) {
        self.formattedValueKey = formattedKey;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _hasPicker = NO;
        _enabled = YES;
    }
    return self;
}

- (void)registerCellsInTableView:(UITableView *)tableView
{
    
}

- (SDFormCell *)cellForTableView:(UITableView *)tableView atIndex:(NSUInteger)index
{
    if (index < self.reuseIdentifiers.count) {
        NSString *reuseIdentifier = [self.reuseIdentifiers objectAtIndex:index];
        SDFormCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.field = self;
        
        if (self.segueIdentifier.length > 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)heightForCellInTableView:(UITableView *)tableView atIndex:(NSUInteger)index
{
    if (index < self.cellHeights.count) {
        NSNumber *height = [self.cellHeights objectAtIndex:index];
        return height.floatValue;
    }
    return 44.0;
}

- (void)setValue:(id)value
{
    [self setValue:value withCellRefresh:YES];
}

- (void)setValue:(id)value withCellRefresh:(BOOL)refresh
{
    _value = value;
    
    [self setRelatedObjectProperty];
    
    if (refresh) {
        [self refreshFieldCell];
    }
}

- (void)setRelatedObject:(id)relatedObject
{
    _relatedObject = relatedObject;
    [self setValueBasedOnRelatedObjectProperty];
}

- (void) setRelatedPropertyKey:(NSString *)relatedPropertyKey
{
    _relatedPropertyKey = relatedPropertyKey;
    [self setValueBasedOnRelatedObjectProperty];
}

- (void)setRelatedObjectProperty
{
    if (self.relatedObject && self.relatedPropertyKey) {
        [self.relatedObject setValue:self.value forKey:self.relatedPropertyKey];
    }
}

- (void)setValueBasedOnRelatedObjectProperty
{
    if (self.relatedObject && self.relatedPropertyKey) {
        self.value = [self.relatedObject valueForKey:self.relatedPropertyKey];
    }
}

- (NSString *)formattedValue
{
    if (self.formatDelegate && [self.formatDelegate respondsToSelector:@selector(formattedValueForField:)]) {
        NSString *title = [self.formatDelegate formattedValueForField:self];
        return title;
    } else if (self.relatedObject && self.formattedValueKey) {
        return [self.relatedObject valueForKey:self.formattedValueKey];
    }
    
    if (self.value) {
        return [NSString stringWithFormat:@"%@", self.value];
    } else {
        return @"";
    }
}

- (void)refreshFieldCell
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(formFieldDidUpdateValue:)]) {
        [self.delegate formFieldDidUpdateValue:self];
    }
}

- (void)form:(SDForm *)form didSelectFieldAtIndex:(NSInteger)index
{
    
}

- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated
{
    if (self.presentingMode == SDFormFieldPresentingModePush && self.delegate) {
        if ([self.delegate respondsToSelector:@selector(formField:pushesViewController:animated:)]) {
            [self.delegate formField:self pushesViewController:controller animated:animated];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(formField:presentsViewController:animated:)]) {
            [self.delegate formField:self presentsViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES];
        }
    }
}

- (NSBundle *)defaultBundle
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"SDFormsResources" withExtension:@"bundle"]];
    return bundle;
}

@end
//
//  ActionSheetPoolDistancePicker.h
//  ActionSheetPicker-iOS6-7
//
//  Created by Daniel Morgan on 19/11/2014.
//
//

#import <CoreActionSheetPicker/CoreActionSheetPicker.h>

@interface ActionSheetPoolDistancePicker : AbstractActionSheetPicker


+ (id)showPickerWithTitle:(NSString *)title bigUnitString:(NSString *)bigUnitString bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitString:(NSString*)smallUnitString smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin;

- (id)initWithTitle:(NSString *)title bigUnitString:(NSString *)bigUnitString bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitString:(NSString*)smallUnitString smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin;

@end

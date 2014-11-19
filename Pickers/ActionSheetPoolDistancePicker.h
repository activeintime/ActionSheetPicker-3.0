//
//  ActionSheetPoolDistancePicker.h
//  ActionSheetPicker-iOS6-7
//
//  Created by Daniel Morgan on 19/11/2014.
//
//

#import "AbstractActionSheetPicker.h"
#import "DistancePickerView.h"

@class ActionSheetPoolDistancePicker;

typedef void(^ActionSheetPoolPickerDoneBlock)(ActionSheetPoolDistancePicker *picker, id origin);
typedef void(^ActionSheetPoolPickerCancelBlock)(ActionSheetPoolDistancePicker *picker);

@interface ActionSheetPoolDistancePicker : AbstractActionSheetPicker


+ (id)showPickerWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit doneBlock:(ActionSheetPoolPickerDoneBlock)doneBlock cancelBlock:(ActionSheetPoolPickerCancelBlock)cancelBlock origin:(id)origin;

+ (id)showPickerWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin;

- (id)initWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin;

-(NSInteger)bigUnits;
-(NSInteger)smallUnits;

@end

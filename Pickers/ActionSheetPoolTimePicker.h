//
//  ActionSheetPoolDistancePicker.h
//  ActionSheetPicker-iOS6-7
//
//  Created by Daniel Morgan on 19/11/2014.
//
//

#import "AbstractActionSheetPicker.h"

@class ActionSheetPoolTimePicker;

typedef void(^ActionSheetPoolTimePickerDoneBlock)(ActionSheetPoolTimePicker *picker, id origin);
typedef void(^ActionSheetPoolTimePickerCancelBlock)(ActionSheetPoolTimePicker *picker);

@interface ActionSheetPoolTimePicker : AbstractActionSheetPicker <UIPickerViewDelegate,UIPickerViewDataSource>


+ (id)showPickerWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit doneBlock:(ActionSheetPoolTimePickerDoneBlock)doneBlock cancelBlock:(ActionSheetPoolTimePickerCancelBlock)cancelBlock origin:(id)origin;

+ (id)showPickerWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin;

- (id)initWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin;

- (id)initWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit doneBlock:(ActionSheetPoolTimePickerDoneBlock)doneBlock cancelBlock:(ActionSheetPoolTimePickerCancelBlock)cancelBlock origin:(id)origin;

-(NSInteger)bigUnits;
-(NSInteger)smallUnits;
-(NSString *)selectedBigUnitString;
-(NSString *)selectedSmallUnitString;

@end

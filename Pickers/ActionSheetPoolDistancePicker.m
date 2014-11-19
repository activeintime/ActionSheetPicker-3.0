//
//  ActionSheetPoolDistancePicker.m
//  ActionSheetPicker-iOS6-7
//
//  Created by Daniel Morgan on 19/11/2014.
//
//

#import "ActionSheetPoolDistancePicker.h"
#import "DistancePickerView.h"


@interface ActionSheetPoolDistancePicker()
//@property (nonatomic, strong) NSString *bigUnitString;
@property (nonatomic, strong) NSArray *bigUnitStrings;
@property (nonatomic, strong) NSArray *smallUnitStrings;
@property (nonatomic, assign) NSInteger selectedBigUnit;
@property (nonatomic, assign) NSInteger bigUnitMax;
@property (nonatomic, assign) NSInteger bigUnitDigits;
@property (nonatomic, assign) NSInteger selectedSmallUnit;
@property (nonatomic, assign) NSInteger smallUnitMax;
@property (nonatomic, assign) NSInteger smallUnitDigits;

@property (nonatomic, copy) ActionSheetPoolPickerDoneBlock onActionSheetDone;
@property (nonatomic, copy) ActionSheetPoolPickerCancelBlock onActionSheetCancel;

@end

@implementation ActionSheetPoolDistancePicker

+ (id)showPickerWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit doneBlock:(ActionSheetPoolPickerDoneBlock)doneBlock cancelBlock:(ActionSheetPoolPickerCancelBlock)cancelBlock origin:(id)origin {
    
    ActionSheetPoolDistancePicker *picker = [[ActionSheetPoolDistancePicker alloc] initWithTitle:title bigUnitStrings:bigUnitStrings bigUnitMax:bigUnitMax selectedBigUnit:selectedBigUnit smallUnitStrings:smallUnitStrings smallUnitMax:smallUnitMax selectedSmallUnit:selectedSmallUnit doneBlock:doneBlock cancelBlock:cancelBlock origin:origin];
    
    [picker showActionSheetPicker];
    return picker;
    
}

+ (id)showPickerWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin {
    ActionSheetPoolDistancePicker *picker = [[ActionSheetPoolDistancePicker alloc] initWithTitle:title bigUnitStrings:bigUnitStrings bigUnitMax:bigUnitMax selectedBigUnit:selectedBigUnit smallUnitStrings:smallUnitStrings smallUnitMax:smallUnitMax selectedSmallUnit:selectedSmallUnit target:target action:action origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (id)initWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit target:(id)target action:(SEL)action origin:(id)origin {
    self = [super initWithTarget:target successAction:action cancelAction:nil origin:origin];
    if (self) {
        self.title = title;
        self.bigUnitStrings = bigUnitStrings;
        self.bigUnitMax = bigUnitMax;
        self.selectedBigUnit = selectedBigUnit;
        self.smallUnitStrings = smallUnitStrings;
        self.smallUnitMax = smallUnitMax;
        self.selectedSmallUnit = selectedSmallUnit;
        self.bigUnitDigits = [[NSString stringWithFormat:@"%li", (long)self.bigUnitMax] length];
        self.smallUnitDigits = [[NSString stringWithFormat:@"%li", (long)self.smallUnitMax] length];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title bigUnitStrings:(NSArray *)bigUnitStrings bigUnitMax:(NSInteger)bigUnitMax selectedBigUnit:(NSInteger)selectedBigUnit smallUnitStrings:(NSArray*)smallUnitStrings smallUnitMax:(NSInteger)smallUnitMax selectedSmallUnit:(NSInteger)selectedSmallUnit doneBlock:(ActionSheetPoolPickerDoneBlock)doneBlock cancelBlock:(ActionSheetPoolPickerCancelBlock)cancelBlock origin:(id)origin {
    self = [super initWithTarget:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        self.title = title;
        self.bigUnitStrings = bigUnitStrings;
        self.bigUnitMax = bigUnitMax;
        self.selectedBigUnit = selectedBigUnit;
        self.smallUnitStrings = smallUnitStrings;
        self.smallUnitMax = smallUnitMax;
        self.selectedSmallUnit = selectedSmallUnit;
        self.bigUnitDigits = [[NSString stringWithFormat:@"%li", (long)self.bigUnitMax] length];
        self.smallUnitDigits = [[NSString stringWithFormat:@"%li", (long)self.smallUnitMax] length];
        
        self.onActionSheetCancel = cancelBlock;
        self.onActionSheetDone = doneBlock;
    }
    
    return self;
}

- (UIView *)configuredPickerView {
    CGRect distancePickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    DistancePickerView *picker = [[DistancePickerView alloc] initWithFrame:distancePickerFrame];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    //    [picker addLabel:self.bigUnitString forComponent:(NSUInteger) (self.bigUnitDigits - 1) forLongestString:nil];
    //    [picker addLabel:self.smallUnitString forComponent:(NSUInteger) (self.bigUnitDigits + self.smallUnitDigits - 1)
    //    forLongestString:nil];
    
    NSInteger unitSubtract = 0;
    NSInteger currentDigit = 0;
    
    for (int i = 0; i < self.bigUnitDigits; ++i) {
        NSInteger factor = (int)pow((double)10, (double)(self.bigUnitDigits - (i+1)));
        currentDigit = (( self.selectedBigUnit - unitSubtract ) / factor )  ;
        [picker selectRow:currentDigit inComponent:i animated:NO];
        unitSubtract += currentDigit * factor;
    }
    
    unitSubtract = 0;
    
    for (NSInteger i = self.bigUnitDigits + 1; i < self.bigUnitDigits + self.smallUnitDigits + 1; ++i) {
        NSInteger factor = (int)pow((double)10, (double)(self.bigUnitDigits + self.smallUnitDigits + 1 - (i+1)));
        currentDigit = (( self.selectedSmallUnit - unitSubtract ) / factor )  ;
        [picker selectRow:currentDigit inComponent:i animated:NO];
        unitSubtract += currentDigit * factor;
    }
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing
    self.pickerView = picker;
    
    return picker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)action origin:(id)origin {
    NSInteger bigUnits = [self bigUnits];
    NSInteger smallUnits = [self smallUnits];
    
    //sending three objects, so can't use performSelector:
    if (self.onActionSheetDone) {
        self.onActionSheetDone(self,origin);
    }
    else {
        if ([target respondsToSelector:action])
        {
            void (*response)(id, SEL, id, id,id) = (void (*)(id, SEL, id, id,id)) objc_msgSend;
            response(target, action, @(bigUnits), @(smallUnits), origin);
        }
        else
            NSAssert(NO, @"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker", object_getClassName(target), sel_getName(action));
    }
    
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin
{
    if (self.onActionSheetCancel)
    {
        self.onActionSheetCancel(self);
        return;
    }
    else
        if ( target && cancelAction && [target respondsToSelector:cancelAction] )
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:cancelAction withObject:origin];
#pragma clang diagnostic pop
        }
}

-(NSInteger)bigUnits {
    NSInteger bigUnits = 0;
    
    DistancePickerView *picker = (DistancePickerView *)self.pickerView;
    for (int i = 0; i < self.bigUnitDigits; ++i)
        bigUnits += [picker selectedRowInComponent:i] * (int)pow((double)10, (double)(self.bigUnitDigits - (i + 1)));
    
    return bigUnits;
    
}

-(NSInteger)smallUnits {
    NSInteger smallUnits = 0;
    
    DistancePickerView *picker = (DistancePickerView *)self.pickerView;
    
    int numberOfComponents = picker.numberOfComponents - 1;
    
    if (self.smallUnitStrings && self.smallUnitStrings.count > 0) {
        numberOfComponents--;
    }
    
    for (NSInteger i = self.bigUnitDigits + 1; i < self.bigUnitDigits + self.smallUnitDigits + 1; ++i) {
        smallUnits += [picker selectedRowInComponent:i] * (int)pow((double)10, (double)((numberOfComponents - i)));
    }
    
    return smallUnits;
}

-(NSString *)selectedBigUnitString {
    if (self.bigUnitStrings && self.bigUnitStrings.count > 0) {
        DistancePickerView *picker = (DistancePickerView *)self.pickerView;
        NSInteger selectedIndex = [picker selectedRowInComponent:self.bigUnitDigits];
        NSString *unitString = [self.bigUnitStrings objectAtIndex:selectedIndex];
        return unitString;
    }
    else {
        return nil;
    }
}

-(NSString *)selectedSmallUnitString {
    
    if (self.smallUnitStrings && self.smallUnitStrings.count > 0) {
        DistancePickerView *picker = (DistancePickerView *)self.pickerView;
        return [self.smallUnitStrings objectAtIndex:[picker selectedRowInComponent:self.bigUnitDigits + self.smallUnitDigits + 1]];
    }
    else {
        return nil;
    }
    
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSInteger count = self.bigUnitDigits + 1 + 1;
    
    if (self.smallUnitStrings && self.smallUnitStrings.count > 0) {
        count++;
    }
    
    return count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger numberOfRows = 10;
    
    //for labels
    if (component == self.bigUnitDigits) {
        numberOfRows = self.bigUnitStrings.count;
    } else if (component == self.bigUnitDigits + self.smallUnitDigits + 1) {
        numberOfRows = self.smallUnitStrings.count;
    }
    if (component + 1 <= self.bigUnitDigits) {
        if (component == 0)
            numberOfRows = self.bigUnitMax / (int)pow((double)10, (double)(self.bigUnitDigits - 1)) + 1;
        return
        numberOfRows = 10;
    }
    if (component == self.bigUnitDigits + 1)
        numberOfRows = self.smallUnitMax / (int)pow((double)10, (double)(self.smallUnitDigits - 1)) + 1;
    
    return numberOfRows;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    CGFloat totalWidth = pickerView.frame.size.width - 30;
    CGFloat otherSize = (totalWidth )/(self.bigUnitDigits + self.smallUnitDigits + 2);
    
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, otherSize, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont boldSystemFontOfSize:20];
    
    if ( component == self.bigUnitDigits )
    {
        label.text = [self.bigUnitStrings objectAtIndex:row];
        return label;
    }
    
    //Small units
    if (component == self.bigUnitDigits + 1) {
        label.font = [UIFont systemFontOfSize:20];
        label.text = [NSString stringWithFormat:@".%li0", (long)row];
        return label;
    }
    else if ( component == self.bigUnitDigits + self.smallUnitDigits + 1 )
    {
        label.text = [self.smallUnitStrings objectAtIndex:row];
        return label;
    }
    
    label.font = [UIFont systemFontOfSize:20];
    label.text = [NSString stringWithFormat:@"%li", (long)row];
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat totalWidth = pickerView.frame.size.width - 30;
    NSInteger numberOfComponents = self.bigUnitDigits + self.smallUnitDigits + 1;
    
    if (self.smallUnitStrings && self.smallUnitStrings.count > 0) {
        numberOfComponents++;
    }
    
    CGFloat otherSize = (totalWidth )/(numberOfComponents);
    return otherSize;
}


- (void)customButtonPressed:(id)sender {
    NSLog(@"Not implemented. If you get around to it, please contribute back to the project :)");
}

@end

//
//  OHCustomPickView.h
//  OurHours
//
//  Created by dazhiQi on 2017/6/27.
//  Copyright © 2017年 Chunhui Du. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OHCustomPickView;
@protocol OHPickerViewDataSource<NSObject>
@required
- (NSInteger)numberOfComponentsInPickerView:(OHCustomPickView *_Nullable)pickerView;

- (NSInteger)pickerView:(OHCustomPickView *_Nullable)pickerView numberOfRowsInComponent:(NSInteger)component;
@end

@protocol OHPickerViewDelegate<NSObject>
@optional

- (CGFloat)pickerView:(OHCustomPickView *_Nullable)pickerView widthForComponent:(NSInteger)component;
- (CGFloat)pickerView:(OHCustomPickView *_Nullable)pickerView rowHeightForComponent:(NSInteger)component;

- (nullable NSString *)pickerView:(OHCustomPickView *_Nullable)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickerView:(OHCustomPickView *_Nullable)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (nullable NSAttributedString *)pickerView:(OHCustomPickView *_Nullable)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (nullable UIView *)pickerView:(OHCustomPickView *_Nullable)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
@end

@interface OHCustomPickView : UIView<UITableViewDataSource,UITableViewDelegate>

/*
 给定固定高度
 */
- (void)setFrame:(CGRect)frame;

//展示
- (void)show;
//隐藏
- (void)hide;

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) BOOL isAnimation;

@property(nullable,nonatomic,weak) id<OHPickerViewDataSource> dataSource;                // default is nil. weak reference
@property(nullable,nonatomic,weak) id<OHPickerViewDelegate>   delegate;                  // default is nil. weak reference
@property(nonatomic,readonly) NSInteger numberOfComponents;
- (NSInteger)numberOfRowsInComponent:(NSInteger)component;
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (NSInteger)selectedRowInComponent:(NSInteger)component;
@end

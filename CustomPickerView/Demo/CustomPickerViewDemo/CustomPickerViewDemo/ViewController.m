//
//  ViewController.m
//  CustomPickerViewDemo
//
//  Created by Mr.Qi on 2017/7/7.
//  Copyright © 2017年 Mr.Qi. All rights reserved.
//

#import "ViewController.h"
#import "OHCustomPickView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<OHPickerViewDataSource,OHPickerViewDelegate>{
    OHCustomPickView *pickView;
    BOOL _isShowing;
}
@property (nonatomic, strong) NSMutableArray *testArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testArray = [@[
                        @[@"今天",@"明天",@"后天"],
                        @[@"尽快送达",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00"]
                        ] mutableCopy];
    
    //测试OHCustomPickerView
    pickView = [[OHCustomPickView alloc] init];
    //设置frame不起作用
    pickView.frame = CGRectMake(0, 300, ScreenWidth, 100);
    pickView.delegate = self;
    pickView.dataSource = self;
    [self.view addSubview:pickView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPickerView:(id)sender {
    if (!_isShowing) {
        _isShowing = YES;
        [pickView show];
    }
}

- (IBAction)hidePickerView:(id)sender {
    if (_isShowing) {
        _isShowing = NO;
        [pickView hide];
    }
}

#pragma mark - OHCustomPickerView DataSource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(OHCustomPickView *_Nullable)pickerView{
    return self.testArray.count;
}

- (NSInteger)pickerView:(OHCustomPickView *_Nullable)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self.testArray objectAtIndex:component] count];
}


/*
 title 、 UIView 、attributedString 三选一
 同时存在优先级：  UIView > attributedString > title
 */

////返回View
//- (nullable UIView *)pickerView:(OHCustomPickView *_Nullable)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
//    return nil;
//}
//
////返回  attributedString
//- (nullable NSAttributedString *)pickerView:(OHCustomPickView *_Nullable)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return nil;
//
//}

//返回title
- (NSString *)pickerView:(OHCustomPickView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *array = [self.testArray objectAtIndex:component];
    NSString *title = [array objectAtIndex:row];
    return title;
}

- (CGFloat)pickerView:(OHCustomPickView *_Nullable)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return 100;
    }else {
        return ScreenWidth - 100;
    }
}

- (CGFloat)pickerView:(OHCustomPickView *_Nullable)pickerView rowHeightForComponent:(NSInteger)component{
    return 45.0f;
}

- (void)pickerView:(OHCustomPickView *_Nullable)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"第%d列， 第%d行",(int)component,(int)row);
}
@end

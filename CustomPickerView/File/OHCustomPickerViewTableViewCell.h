//
//  OHCustomPickerViewTableViewCell.h
//  OurHours
//
//  Created by Mr.Qi on 2017/6/28.
//  Copyright © 2017年 Mr.Qi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHCustomPickerViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *splitLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splitLineHeightLayout;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributeStr;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL isHiddenSplitLine;
- (void)setText:(NSString *)text textColor:(UIColor *)textColor isHiddenSplitLine:(BOOL)isHiddenSplitLine;
- (void)setAttributedString:(NSAttributedString *)attributeStr isHiddenSplitLine:(BOOL)isHiddenSplitLine;
@end

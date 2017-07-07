//
//  OHCustomPickerViewTableViewCell.m
//  OurHours
//
//  Created by Mr.Qi on 2017/6/28.
//  Copyright © 2017年 Mr.Qi. All rights reserved.
//

#import "OHCustomPickerViewTableViewCell.h"
#define ColorFromRGB16HEX(value) [UIColor colorWithRed:(float)((value&0xFF0000)>>16)/0xff green:(float)((value&0x00FF00)>>8)/0xff blue:(float)(value&0x0000FF)/0xff alpha:1.0]
#define OHSeparaterLineBGColor ColorFromRGB16HEX(0xEEEEEE)      //分割线颜色

@implementation OHCustomPickerViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.splitLine.backgroundColor = OHSeparaterLineBGColor;
    self.splitLineHeightLayout.constant = 0.5;
}

- (void)setText:(NSString *)text textColor:(UIColor *)textColor isHiddenSplitLine:(BOOL)isHiddenSplitLine{
    _text = text;
    _textColor = textColor;
    _isHiddenSplitLine = isHiddenSplitLine;
    
    self.titleLabel.text = _text;
    self.titleLabel.textColor = _textColor;
    self.splitLine.hidden = _isHiddenSplitLine;
}

- (void)setAttributedString:(NSAttributedString *)attributeStr isHiddenSplitLine:(BOOL)isHiddenSplitLine{
    _attributeStr = attributeStr;
    _isHiddenSplitLine = isHiddenSplitLine;
    
    self.titleLabel.attributedText = _attributeStr;
    self.splitLine.hidden = _isHiddenSplitLine;
}
@end

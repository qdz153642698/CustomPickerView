//
//  OHCustomPickerViewTableViewCell.m
//  OurHours
//
//  Created by dazhiQi on 2017/6/28.
//  Copyright © 2017年 Chunhui Du. All rights reserved.
//

#import "OHCustomPickerViewTableViewCell.h"

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

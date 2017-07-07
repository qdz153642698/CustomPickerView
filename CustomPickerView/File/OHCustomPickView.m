//
//  OHCustomPickView.m
//  OurHours
//
//  Created by Mr.Qi on 2017/6/27.
//  Copyright © 2017年 Mr.Qi. All rights reserved.
//

#import "OHCustomPickView.h"
#import "OHCustomPickerViewTableViewCell.h"
#define TableTag 100

static NSString *OHCustomPickerViewCell = @"OHCustomPickerViewCell";
@implementation OHCustomPickView
- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 256);
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 256)];
}

- (void)show{
    CGFloat tableViewCount = 0;
    CGFloat tableWidth = 0;
    CGFloat _tableWidth = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        tableViewCount = [self.dataSource numberOfComponentsInPickerView:self];
    }
    for (int i=0; i<tableViewCount && _tableWidth<=ScreenWidth; i++) {
        if ([self.delegate respondsToSelector:@selector(pickerView:widthForComponent:)]) {
            tableWidth = [self.delegate pickerView:self widthForComponent:i];
        }
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(_tableWidth, 0, tableWidth, 256) style:UITableViewStylePlain];
        if (i == 0) {
            tableView.backgroundColor = OHSystemTableViewBGColor;
        }else{
            tableView.backgroundColor = [UIColor whiteColor];
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.tag = TableTag + i;
        [tableView registerNib:[UINib nibWithNibName:@"OHCustomPickerViewTableViewCell" bundle:nil] forCellReuseIdentifier:OHCustomPickerViewCell];
        [self addSubview:tableView];
        _tableWidth = _tableWidth + tableWidth;
        [tableView reloadData];
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, -256);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)hide{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         for (id view in self.subviews) {
                             [view removeFromSuperview];
                         }
                     }];
}


- (NSInteger)numberOfComponents{
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [self.dataSource numberOfComponentsInPickerView:self];
    }
    return 0;
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component{
    if ([self.dataSource respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.dataSource pickerView:self numberOfRowsInComponent:component];
    }
    return 0;
}

- (void)reloadAllComponents{
    for (UITableView *tableView in self.subviews) {
        [tableView reloadData];
    }
}

- (void)reloadComponent:(NSInteger)component{
    UITableView *tableView = (UITableView *)[self viewWithTag:component+TableTag];
    [tableView reloadData];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    _row = row;
    UITableView *tableView = (UITableView *)[self viewWithTag:component+TableTag];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:1];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component{
    return _row;
}

#pragma mark - UITableView Deledate And DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.dataSource pickerView:self numberOfRowsInComponent:(tableView.tag-TableTag)];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OHCustomPickerViewTableViewCell *cell = (OHCustomPickerViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:OHCustomPickerViewCell forIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
        UIView *view = [self.delegate pickerView:self viewForRow:indexPath.row forComponent:(tableView.tag-TableTag) reusingView:nil];
        [cell.contentView addSubview:view];
    }else if ([self.delegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]){
        BOOL isHiddenSplitLine = NO;
        NSAttributedString *attributeStr = [self.delegate pickerView:self attributedTitleForRow:indexPath.row forComponent:(tableView.tag-TableTag)];
        isHiddenSplitLine = tableView.tag - TableTag == 0 ? YES : NO;
        [cell setAttributedString:attributeStr isHiddenSplitLine:isHiddenSplitLine];
    }else if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        NSString *text = @"";
        UIColor *color = OHSystemBlackColor;
        BOOL isHiddenSplitLine = NO;
        if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
            text = [self.delegate pickerView:self titleForRow:indexPath.row forComponent:(tableView.tag-TableTag)];
        }
        color = tableView.tag - TableTag == 0 ? OHSystemBlackColor : OHSystemGrayColor;
        isHiddenSplitLine = tableView.tag - TableTag == 0 ? YES : NO;
        [cell setText:text textColor:color isHiddenSplitLine:isHiddenSplitLine];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(pickerView:rowHeightForComponent:)]) {
        return [self.delegate pickerView:self rowHeightForComponent:(tableView.tag-TableTag)];
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        _row = indexPath.row;
        [self.delegate pickerView:self didSelectRow:indexPath.row inComponent:(tableView.tag-TableTag)];
    }
}
@end

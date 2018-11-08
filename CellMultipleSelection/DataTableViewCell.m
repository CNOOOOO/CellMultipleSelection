//
//  DataTableViewCell.m
//  AAAA
//
//  Created by Mac2 on 2018/11/8.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "DataTableViewCell.h"

@implementation DataTableViewCell

- (void)setModel:(DataModel *)model {
    self.textLabel.text = [NSString stringWithFormat:@"line: %@", model.number];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell {
    //去除选中时cell的蓝色背景
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = backGroundView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    //重写此方法，作用为当进入编辑模式时候运行customMultipleChioce方法
    [super setEditing:editing animated:animated];
    if (editing) {
        [self customMultipleChioce];
    }
}

- (void)layoutSubviews {
    [self customMultipleChioce];
    [super layoutSubviews];
}

- (void)customMultipleChioce {
    for (UIControl *control in self.subviews) {
        //循环cell的subview
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            //找出UITableViewCellEditControl
            for (UIView *view in control.subviews) {
                if ([view isKindOfClass: [UIImageView class]]) {
                    //在UITableViewCellEditControl中找到imageView
                    UIImageView *imageView = (UIImageView *)view;
                    if (self.selected) {
                        imageView.image = [UIImage imageNamed:@"selected"];
                    }else {
                        imageView.image = [UIImage imageNamed:@"unselected"];
                    }
                }
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

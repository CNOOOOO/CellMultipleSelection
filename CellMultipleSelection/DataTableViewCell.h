//
//  DataTableViewCell.h
//  AAAA
//
//  Created by Mac2 on 2018/11/8.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface DataTableViewCell : UITableViewCell

@property (nonatomic, strong) DataModel *model;
- (void)setModel:(DataModel *)model;

@end

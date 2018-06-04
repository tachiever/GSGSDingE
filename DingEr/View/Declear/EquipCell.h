//
//  EquipCell.h
//  DingEr
//
//  Created by Tcy on 2018/4/25.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (copy, nonatomic) void (^changeNumAction)(NSInteger sig);

@end

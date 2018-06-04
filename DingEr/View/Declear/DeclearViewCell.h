//
//  DeclearViewCell.h
//  DingEr
//
//  Created by Tcy on 2018/4/16.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeclearViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *yandMLab;
@property (weak, nonatomic) IBOutlet UILabel *pointLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *statueLab;

- (void)setStatue:(NSString *)str;
@end

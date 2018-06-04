//
//  FormReadView.h
//  DingEr
//
//  Created by Tcy on 2018/5/3.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormReadView : UIView
- (void)updateWithImageArr:(NSMutableArray *)imageArr;

@property (nonatomic ) NSString *sum;
@property (nonatomic ) NSInteger model;

@end

//
//  SheBeiCell.h
//  DingEr
//
//  Created by Tcy on 2018/5/18.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheBeiCell : UIView
@property (nonatomic ) BOOL isRead;
- (void)createWithPart:(NSString *)part Loca:(NSString *)loca name:(NSString *)name;

@property (copy, nonatomic) void (^closeCell)(NSInteger sig);
@end
